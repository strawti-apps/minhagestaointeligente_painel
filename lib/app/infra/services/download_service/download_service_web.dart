import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class DownloadServiceImpl {
  static Future<bool> forceDownload(String url, String filename) async {
    if (!kIsWeb) return false;
    
    try {
      debugPrint('WebDownloadService: Iniciando download de $url como $filename');
      
      // Chamar função JavaScript global assíncrona
      js.context.callMethod('forceDownload', [url, filename]);
      
      // Aguardar o resultado (a função JS retorna uma Promise)
      await Future.delayed(const Duration(milliseconds: 500));
      
      debugPrint('WebDownloadService: Download executado');
      return true;
    } catch (e) {
      debugPrint('Erro ao chamar função JavaScript de download: $e');
      return false;
    }
  }
  
  static bool openInNewTab(String url) {
    if (!kIsWeb) return false;
    
    try {
      debugPrint('WebDownloadService: Abrindo $url em nova aba');
      final result = js.context.callMethod('openInNewTab', [url]);
      return result == true;
    } catch (e) {
      debugPrint('Erro ao abrir nova aba: $e');
      return false;
    }
  }
} 