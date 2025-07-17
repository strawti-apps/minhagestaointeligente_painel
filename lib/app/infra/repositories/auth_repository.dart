// import 'package:flutter/foundation.dart';
// import 'package:strawti_utils/strawti_utils.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:get/get.dart';

// import '../services/user_service.dart';
// import '../models/user_model.dart';
// import '../../shared/navbar/navbar_navigation_controller.dart';

// class AuthRepository extends StrautilsTryThis {
//   static final _authDatabase = Supabase.instance.client.from('users');

//   FStrautilsResponse<UserModel?> findUserByEmail(String email) {
//     return tryThis(() async {
//       final response = await _authDatabase.select().match({'email': email}).maybeSingle();
//       if (response != null) {
//         return StrautilsResponse.success(UserModel.fromMap(response));
//       }
//       return StrautilsResponse.warning('Usuário não encontrado');
//     });
//   }

//   FStrautilsResponse<bool> signUp(UserModel user, String password) {
//     return tryThis(() async {
//       final existsResp = await findUserByEmail(user.email);
//       if (existsResp.success && existsResp.data != null) {
//         return StrautilsResponse.warning('O e-mail já está em uso.');
//       }
//       final response = await Supabase.instance.client.auth.signUp(
//         email: user.email,
//         password: password,
//       );
//       if (response.user != null) {
//         // Usuários que se cadastram normalmente NÃO precisam mudar a senha
//         // Apenas usuários criados pelo painel administrativo devem mudar a senha na primeira vez
//         final newUser = user.copyWith(
//           authUserId: response.user!.id,
//           mustChangePassword: false, // Usuários que se cadastram normalmente
//         );
//         final response2 = await _authDatabase.insert(newUser.toMap()).select();
//         if (response2.isNotEmpty) {
//           return StrautilsResponse.success(true);
//         }
//         return StrautilsResponse.warning('Sua conta não foi criada corretamente');
//       }
//       return StrautilsResponse.warning('Erro ao criar conta');
//     });
//   }

//   FStrautilsResponse<bool> signIn(String email, String password) {
//     return tryThis(() async {
//       try {
//         await Supabase.instance.client.auth.signInWithPassword(
//           email: email,
//           password: password,
//         );
//         await UserService().updateCurrentUserData();
        
//         // Notificar a navbar sobre a mudança do usuário
//         try {
//           final navController = Get.find<NavbarNavigationController>();
//           navController.updateNavbarForRole();
//         } catch (e) {
//           // Navbar controller pode não estar registrado ainda
//           debugPrint('Navbar controller não encontrado: $e');
//         }
        
//         return StrautilsResponse.success(true);
//       } catch (e) {
//         debugPrint('Erro no signIn: $e');
//         if (e is AuthException) {
//           switch (e.code) {
//             case 'invalid_credentials':
//               return StrautilsResponse.warning('E-mail ou senha inválidos');
//             case 'email_not_confirmed':
//               return StrautilsResponse.warning('Confirme seu e-mail para entrar.');
//           }
//         }
//         return StrautilsResponse.warning('Erro desconhecido');
//       }
//     });
//   }

//   FStrautilsResponse<bool> signOut() {
//     return tryThis(() async {
//       try {
//         await Supabase.instance.client.auth.signOut();
        
//         // Notificar a navbar sobre logout
//         try {
//           final navController = Get.find<NavbarNavigationController>();
//           navController.updateNavbarForRole();
//         } catch (e) {
//           debugPrint('Navbar controller não encontrado: $e');
//         }
        
//         return StrautilsResponse.success(true);
//       } catch (e) {
//         debugPrint('Erro no signOut: $e');
//         return StrautilsResponse.warning('Erro ao sair da conta');
//       }
//     });
//   }

//   FStrautilsResponse<bool> recoveryPassword(String email) {
//     return tryThis(() async {
//       try {
//         await Supabase.instance.client.auth.resetPasswordForEmail(email);
//         return StrautilsResponse.success(true);
//       } catch (e) {
//         debugPrint('Erro no recoveryPassword: $e');
//         if (e is AuthException) {
//           if (e.statusCode == '429') {
//             return StrautilsResponse.warning('Você já fez solicitações, tente novamente em alguns instantes.');
//           }
//         }
//         return StrautilsResponse.warning('Erro desconhecido.');
//       }
//     });
//   }

//   FStrautilsResponse<UserModel?> getCurrentUser() {
//     return tryThis(() async {
//       try {
//         final user = Supabase.instance.client.auth.currentUser;
//         if (user != null) {
//           final userResp = await findUserByEmail(user.email ?? '');
//           if (userResp.success) {
//             return StrautilsResponse.success(userResp.data);
//           } else {
//             return StrautilsResponse.warning('Usuário não encontrado');
//           }
//         }
//         return StrautilsResponse.warning('Nenhum usuário logado');
//       } catch (e) {
//         debugPrint('Erro ao obter usuário atual: $e');
//         return StrautilsResponse.warning('Erro ao obter usuário atual');
//       }
//     });
//   }
// } 