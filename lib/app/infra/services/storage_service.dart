import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  static Future<bool> bucketExists(String bucketId) async {
    try {
      await Supabase.instance.client.storage.from(bucketId).list();
      return true;
    } catch (e) {
      // Bucket não existe ou não tem permissão
      return false;
    }
  }

  static FStrautilsResponse<String?> uploadFile(
    File? file, {
    String bucketId = 'materials',
    String? folder,
  }) async {
    try {
      if (file == null) {
        return StrautilsResponse.warning(
          'Você precisa enviar um arquivo válido',
        );
      }

      // Verifica se o bucket existe
      final exists = await bucketExists(bucketId);
      if (!exists) {
        return StrautilsResponse.warning(
          'Bucket "$bucketId" não existe no Supabase Storage. '
          'Crie o bucket no painel do Supabase primeiro.',
        );
      }

      final extensionFile = basename(file.path).split('.').last.toLowerCase();

      // Verifica se é um arquivo permitido (PDF ou imagem)
      final allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'];
      if (!allowedExtensions.contains(extensionFile)) {
        return StrautilsResponse.warning(
          'Tipo de arquivo não permitido. Use: ${allowedExtensions.join(', ')}',
        );
      }

      final today = DateTime.now();
      final userId =
          Supabase.instance.client.auth.currentUser?.id ?? 'anonymous';

      // Construir o caminho do arquivo
      String nameFileF;
      if (folder != null && folder.isNotEmpty) {
        nameFileF =
            '$folder/$userId/${today.day}-${today.month}-${today.year}-${today.millisecondsSinceEpoch}.$extensionFile';
      } else {
        nameFileF =
            '$userId/${today.day}-${today.month}-${today.year}-${today.millisecondsSinceEpoch}.$extensionFile';
      }

      final supabase = Supabase.instance.client.storage.from(bucketId);

      await supabase.upload(
        nameFileF,
        file,
        retryAttempts: 3,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      final fullPathR = supabase.getPublicUrl(nameFileF);
      return StrautilsResponse.success(fullPathR);
    } catch (e) {
      String errorMessage = 'Erro ao subir o arquivo';

      if (e.toString().contains('Bucket not found')) {
        errorMessage =
            'Bucket "$bucketId" não encontrado. Crie o bucket no Supabase Storage.';
      } else if (e.toString().contains('permission')) {
        errorMessage =
            'Sem permissão para fazer upload. Verifique as políticas RLS do bucket.';
      } else if (e.toString().contains('size') ||
          e.toString().contains('large')) {
        errorMessage = 'Arquivo muito grande. Máximo permitido: 10MB.';
      } else if (e.toString().contains('already exists')) {
        errorMessage = 'Arquivo já existe. Tente novamente.';
      }

      return StrautilsResponse.warning(
        '$errorMessage ${kDebugMode ? ' - Detalhes: $e' : ''}',
      );
    }
  }

  static FStrautilsResponse<String?> uploadBytes(
    Uint8List? fileBytes, {
    required String fileName,
    String bucketId = 'materials',
    String? folder,
  }) async {
    try {
      if (fileBytes == null) {
        return StrautilsResponse.warning(
          'Você precisa enviar um arquivo válido',
        );
      }

      // Verifica se o bucket existe
      final exists = await bucketExists(bucketId);
      if (!exists) {
        return StrautilsResponse.warning(
          'Bucket "$bucketId" não existe no Supabase Storage. '
          'Crie o bucket no painel do Supabase primeiro.',
        );
      }

      final extensionFile = fileName.split('.').last.toLowerCase();

      // Verifica se é um arquivo permitido
      final allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'];
      if (!allowedExtensions.contains(extensionFile)) {
        return StrautilsResponse.warning(
          'Tipo de arquivo não permitido. Use: ${allowedExtensions.join(', ')}',
        );
      }

      final today = DateTime.now();
      final userId =
          Supabase.instance.client.auth.currentUser?.id ?? 'anonymous';

      // Construir o caminho do arquivo
      String nameFileF;
      if (folder != null && folder.isNotEmpty) {
        nameFileF =
            '$folder/$userId/${today.day}-${today.month}-${today.year}-${today.millisecondsSinceEpoch}.$extensionFile';
      } else {
        nameFileF =
            '$userId/${today.day}-${today.month}-${today.year}-${today.millisecondsSinceEpoch}.$extensionFile';
      }

      final supabase = Supabase.instance.client.storage.from(bucketId);

      await supabase.uploadBinary(
        nameFileF,
        fileBytes,
        retryAttempts: 3,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      final fullPathR = supabase.getPublicUrl(nameFileF);
      return StrautilsResponse.success(fullPathR);
    } catch (e) {
      String errorMessage = 'Erro ao subir o arquivo';

      if (e.toString().contains('Bucket not found')) {
        errorMessage =
            'Bucket "$bucketId" não encontrado. Crie o bucket no Supabase Storage.';
      } else if (e.toString().contains('permission')) {
        errorMessage =
            'Sem permissão para fazer upload. Verifique as políticas RLS do bucket.';
      } else if (e.toString().contains('size') ||
          e.toString().contains('large')) {
        errorMessage = 'Arquivo muito grande. Máximo permitido: 10MB.';
      }

      return StrautilsResponse.warning(
        '$errorMessage ${kDebugMode ? ' - Detalhes: $e' : ''}',
      );
    }
  }

  static FStrautilsResponse<bool> removeFiles(
    List<String> urls, {
    String bucketId = 'materials',
    String? folder,
  }) async {
    try {
      final supabase = Supabase.instance.client.storage.from(bucketId);

      final userId =
          Supabase.instance.client.auth.currentUser?.id ?? 'anonymous';

      final paths =
          urls.map((u) {
            final fileName = u.split('/').last;
            if (folder != null && folder.isNotEmpty) {
              return '$folder/$userId/$fileName';
            } else {
              return '$userId/$fileName';
            }
          }).toList();

      final response = await supabase.remove(paths);

      if (response.isNotEmpty) return StrautilsResponse.success(true);

      return StrautilsResponse.warning('Erro ao remover os arquivos');
    } catch (e) {
      return StrautilsResponse.warning(
        'Erro ao remover os arquivos ${kDebugMode ? e : ''}',
      );
    }
  }

  // Método específico para upload de imagens
  static FStrautilsResponse<String?> uploadImage(
    dynamic file, {
    required String bucketId,
    String? folder,
  }) async {
    try {
      if (file == null) {
        return StrautilsResponse.warning(
          'Você precisa enviar uma imagem válida',
        );
      }

      // Verifica se o bucket existe
      final exists = await bucketExists(bucketId);
      if (!exists) {
        return StrautilsResponse.warning(
          'Bucket "$bucketId" não existe no Supabase Storage. '
          'Crie o bucket no painel do Supabase primeiro.',
        );
      }

      String extensionFile;

      // Determina se é web (bytes) ou mobile (path)
      if (file is Uint8List) {
        // Web - bytes
        extensionFile = 'jpg'; // Padrão para bytes
      } else if (file is String) {
        // Mobile - path
        extensionFile = basename(file).split('.').last.toLowerCase();
      } else {
        return StrautilsResponse.warning('Tipo de arquivo não suportado');
      }

      // Verifica se é uma imagem permitida
      final allowedExtensions = ['jpg', 'jpeg', 'png', 'webp', 'gif'];
      if (!allowedExtensions.contains(extensionFile)) {
        return StrautilsResponse.warning(
          'Tipo de imagem não permitido. Use: ${allowedExtensions.join(', ')}',
        );
      }

      final today = DateTime.now();
      final userId =
          Supabase.instance.client.auth.currentUser?.id ?? 'anonymous';

      // Construir o caminho do arquivo
      String nameFileF;
      if (folder != null && folder.isNotEmpty) {
        nameFileF =
            '$folder/$userId/${today.day}-${today.month}-${today.year}-${today.millisecondsSinceEpoch}.$extensionFile';
      } else {
        nameFileF =
            '$userId/${today.day}-${today.month}-${today.year}-${today.millisecondsSinceEpoch}.$extensionFile';
      }

      final supabase = Supabase.instance.client.storage.from(bucketId);

      if (file is Uint8List) {
        // Upload de bytes (web)
        await supabase.uploadBinary(
          nameFileF,
          file,
          retryAttempts: 3,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
      } else if (file is String) {
        // Upload de arquivo (mobile)
        final fileObj = File(file);
        await supabase.upload(
          nameFileF,
          fileObj,
          retryAttempts: 3,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
      }

      final fullPathR = supabase.getPublicUrl(nameFileF);
      return StrautilsResponse.success(fullPathR);
    } catch (e) {
      String errorMessage = 'Erro ao subir a imagem';

      // Log detalhado do erro para debug
      if (kDebugMode) {
        print('=== ERRO STORAGE DEBUG ===');
        print('Bucket: $bucketId');
        print('Folder: $folder');
        print('File type: ${file.runtimeType}');
        print('User ID: ${Supabase.instance.client.auth.currentUser?.id}');
        print('User role: ${Supabase.instance.client.auth.currentUser?.role}');
        print('Erro completo: $e');
        print('========================');
      }

      if (e.toString().contains('Bucket not found')) {
        errorMessage =
            'Bucket "$bucketId" não encontrado. Crie o bucket no Supabase Storage.';
      } else if (e.toString().contains('permission') ||
          e.toString().contains('row-level security')) {
        errorMessage =
            'Sem permissão para fazer upload. Verifique as políticas RLS do bucket.';
      } else if (e.toString().contains('size') ||
          e.toString().contains('large')) {
        errorMessage = 'Imagem muito grande. Máximo permitido: 50MB.';
      } else if (e.toString().contains('already exists')) {
        errorMessage = 'Imagem já existe. Tente novamente.';
      }

      return StrautilsResponse.warning(
        '$errorMessage ${kDebugMode ? ' - Detalhes: $e' : ''}',
      );
    }
  }

  static Future<void> removeEmptyFolders(String bucketId) async {
    try {
      await Supabase.instance.client.storage.emptyBucket(bucketId);
    } catch (e) {
      // Erro ao remover as pastas vazias
    }
  }
}
