import 'package:flutter/foundation.dart';

class DownloadServiceImpl {
  static Future<bool> forceDownload(String url, String filename) async {
    // Para mobile, não usamos JavaScript
    // O download será feito diretamente via Dio no widget
    debugPrint('MobileDownloadService: Download será feito via Dio');
    return false; // Indica que deve usar o método mobile
  }
  
  static bool openInNewTab(String url) {
    // Para mobile, não temos conceito de nova aba
    debugPrint('MobileDownloadService: Não há suporte para nova aba no mobile');
    return false;
  }
} 