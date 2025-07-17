import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

class UserRepository extends StrautilsTryThis {
  static final _usersTable = Supabase.instance.client.from('users');
  static final _authClient = Supabase.instance.client.auth;

  // Obter um usuário pelo ID
  FStrautilsResponse<UserModel?> getUserById(int id) {
    return tryThis(() async {
      final response = await _usersTable.select().eq('id', id).maybeSingle();
      if (response == null) {
        return StrautilsResponse.warning('Usuário não encontrado');
      }
      return StrautilsResponse.success(UserModel.fromMap(response));
    });
  }

  // Obter um usuário pelo authId
  FStrautilsResponse<UserModel?> getUserByAuthId(String authUserId) {
    return tryThis(() async {
      final response = await _usersTable.select().eq('authUserId', authUserId).maybeSingle();
      if (response == null) {
        return StrautilsResponse.warning('Usuário não encontrado');
      }
      return StrautilsResponse.success(UserModel.fromMap(response));
    });
  }

  // Obter todos os usuários
  FStrautilsResponse<List<UserModel>> getAllUsers() {
    return tryThis(() async {
      final response = await _usersTable.select().order('firstName', ascending: true);
      final list = (response as List).map((json) => UserModel.fromMap(json)).toList();
      return StrautilsResponse.success(list);
    });
  }

  // Criar usuário
  FStrautilsResponse<UserModel> createUser(UserModel user) {
    return tryThis(() async {
      final response = await _usersTable.insert(user.toMap()).select().single();
      return StrautilsResponse.success(UserModel.fromMap(response));
    });
  }

  // Criar usuário com autenticação completa
  FStrautilsResponse<UserModel> createUserWithAuth(UserModel user) {
    return tryThis(() async {
      // Gerar senha padrão (3 primeiras letras do nome + 2025)
      final firstName = user.firstName.toLowerCase();
      final passwordPrefix = firstName.length >= 3 
          ? firstName.substring(0, 3) 
          : firstName.padRight(3, '0');
      final defaultPassword = '${passwordPrefix}2025';

      // Criar usuário no Supabase Auth
      final authResponse = await _authClient.signUp(
        email: user.email,
        password: defaultPassword,
      );

      if (authResponse.user == null) {
        return StrautilsResponse.error('Erro ao criar usuário na autenticação');
      }

      // Criar usuário na tabela users
      // Usuários criados pelo painel administrativo DEVEM mudar a senha
      final userWithAuthId = user.copyWith(
        authUserId: authResponse.user!.id,
        createdAt: DateTime.now(),
        mustChangePassword: true, // Obrigatório para usuários criados pelo painel
      );

      final response = await _usersTable.insert(userWithAuthId.toMap()).select().single();
      return StrautilsResponse.success(UserModel.fromMap(response));
    });
  }

  // Atualizar usuário
  FStrautilsResponse<UserModel> updateUser(UserModel user) {
    return tryThis(() async {
      if (user.id == null) {
        return StrautilsResponse.warning('ID do usuário não fornecido para atualização');
      }
      final response = await _usersTable.update(user.toMap()).eq('id', user.id!).select().single();
      return StrautilsResponse.success(UserModel.fromMap(response));
    });
  }

  // Deletar usuário
  FStrautilsResponse<bool> deleteUser(int id) {
    return tryThis(() async {
      await _usersTable.delete().eq('id', id);
      return StrautilsResponse.success(true);
    });
  }

  // Buscar usuários pelo papel (role)
  FStrautilsResponse<List<UserModel>> getUsersByRole(String role) {
    return tryThis(() async {
      final response = await _usersTable.select().eq('role', role).order('firstName', ascending: true);
      return StrautilsResponse.success((response as List).map((json) => UserModel.fromMap(json)).toList());
    });
  }

  // Buscar usuários por texto (nome ou email)
  FStrautilsResponse<List<UserModel>> searchUsers(String query) {
    return tryThis(() async {
      // Buscar todos os usuários primeiro
      final allUsersResponse = await getAllUsers();
      
      if (!allUsersResponse.success) {
        return StrautilsResponse.error(allUsersResponse.message);
      }
      
      final allUsers = allUsersResponse.data!;
      final queryLower = query.toLowerCase();
      
      // Filtrar no lado do cliente
      final filteredUsers = allUsers.where((user) {
        final fullName = '${user.firstName} ${user.lastName ?? ''}'.toLowerCase();
        final email = user.email.toLowerCase();
        
        return fullName.contains(queryLower) || 
               email.contains(queryLower);
      }).toList();

      return StrautilsResponse.success(filteredUsers);
    });
  }

  // Verificar se email já existe
  FStrautilsResponse<bool> checkEmailExists(String email) {
    return tryThis(() async {
      final response = await _usersTable.select('id').eq('email', email).maybeSingle();
      return StrautilsResponse.success(response != null);
    });
  }

  // Obter usuários por múltiplos IDs (para o módulo de acessos)
  FStrautilsResponse<List<UserModel>> getUsersByIds(List<int> userIds) {
    return tryThis(() async {
      if (userIds.isEmpty) {
        return StrautilsResponse.success(<UserModel>[]);
      }
      
      final response = await _usersTable
          .select()
          .inFilter('id', userIds)
          .order('firstName', ascending: true);
      
      final users = (response as List).map((json) => UserModel.fromMap(json)).toList();
      return StrautilsResponse.success(users);
    });
  }

  // Marcar que o usuário alterou a senha
  FStrautilsResponse<UserModel> markPasswordChanged(int userId) {
    return tryThis(() async {
      final response = await _usersTable
          .update({'mustChangePassword': false})
          .eq('id', userId)
          .select()
          .single();
      
      return StrautilsResponse.success(UserModel.fromMap(response));
    });
  }

  // Alterar senha do usuário no Supabase Auth
  FStrautilsResponse<bool> changeUserPassword(String newPassword) {
    return tryThis(() async {
      await _authClient.updateUser(
        UserAttributes(password: newPassword),
      );
      
      return StrautilsResponse.success(true);
    });
  }

  // Verificar se o usuário precisa alterar a senha
  FStrautilsResponse<bool> mustChangePassword(String authUserId) {
    return tryThis(() async {
      final response = await _usersTable
          .select('mustChangePassword')
          .eq('authUserId', authUserId)
          .maybeSingle();
      
      if (response == null) {
        return StrautilsResponse.warning('Usuário não encontrado');
      }
      
      // Por padrão, usuários NÃO precisam mudar a senha
      // Apenas usuários criados pelo painel administrativo devem mudar a senha
      return StrautilsResponse.success(response['mustChangePassword'] ?? false);
    });
  }
}
