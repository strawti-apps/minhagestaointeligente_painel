// Import condicional baseado na plataforma
import 'download_service_web.dart' if (dart.library.io) 'download_service_mobile.dart';

// Interface comum para ambas as plataformas
class WebDownloadService {
  static Future<bool> forceDownload(String url, String filename) async {
    return await DownloadServiceImpl.forceDownload(url, filename);
  }
  
  static bool openInNewTab(String url) {
    return DownloadServiceImpl.openInNewTab(url);
  }
} 