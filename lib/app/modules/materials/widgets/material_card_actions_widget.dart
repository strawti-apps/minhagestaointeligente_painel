import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../infra/models/material_model.dart';
import '../../../infra/services/download_service/web_download_service.dart';
import '../../../shared/utils/app_snackbar.dart';
import '../../../themes/app_colors.dart';
import '../materials_controller.dart';

class MaterialCardActionsWidget extends StatelessWidget {
  final MaterialModel item;
  final MaterialsController controller;

  const MaterialCardActionsWidget({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(Icons.more_vert, color: AppColors.textSecondary, size: 16),
      ),
      onSelected: (value) => _handleAction(context, value),
      itemBuilder:
          (context) => [
            const PopupMenuItem(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.visibility, size: 16),
                  SizedBox(width: 8),
                  Text('Visualizar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'download',
              child: Row(
                children: [
                  Icon(Icons.download, size: 16),
                  SizedBox(width: 8),
                  Text('Baixar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'copy_link',
              child: Row(
                children: [
                  Icon(Icons.link, size: 16),
                  SizedBox(width: 8),
                  Text('Copiar Link'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 16),
                  SizedBox(width: 8),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 16, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Excluir', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
    );
  }

  void _handleAction(BuildContext context, String action) {
    switch (action) {
      case 'view':
        _viewFile();
        break;
      case 'download':
        _downloadFile();
        break;
      case 'copy_link':
        _copyLink();
        break;
      case 'edit':
        controller.goToEditItem(item);
        break;
      case 'delete':
        controller.showDeleteMaterialConfirmation(item);
        break;
    }
  }

  Future<void> _viewFile() async {
    try {
      final Uri url = Uri.parse(item.fileUrl);

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        AppSnackbar.to.error('Não foi possível abrir o arquivo');
      }
    } catch (e) {
      AppSnackbar.to.error('Erro ao abrir arquivo: $e');
    }
  }

  Future<void> _downloadFile() async {
    if (kIsWeb) {
      await _downloadFileWeb();
    } else {
      await _downloadFileMobile();
    }
  }

  Future<void> _downloadFileWeb() async {
    try {
      final fileName = _getFileName();

      _showLoadingDialog('Preparando download...');

      final downloadSuccess = await WebDownloadService.forceDownload(
        item.fileUrl,
        fileName,
      );

      _closeLoadingDialog();

      if (downloadSuccess) {
        AppSnackbar.to.success(
          title: 'Download Iniciado',
          'O arquivo está sendo baixado para sua pasta de Downloads.',
        );
      } else {
        _handleDownloadFallback();
      }
    } catch (e) {
      _closeLoadingDialog();
      AppSnackbar.to.error('Erro no download: $e');
    }
  }

  Future<void> _downloadFileMobile() async {
    try {
      if (!await _requestStoragePermission()) {
        AppSnackbar.to.warning(
          title: 'Permissão Negada',
          'É necessário permitir o acesso ao armazenamento para baixar arquivos',
        );
        return;
      }

      _showLoadingDialog('Baixando arquivo...');

      final downloadsDir = await _getDownloadsDirectory();
      final fileName = _getFileName();
      final filePath = '${downloadsDir.path}/$fileName';

      await Dio().download(
        item.fileUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            debugPrint('Download progress: $progress%');
          }
        },
      );

      _closeLoadingDialog();

      AppSnackbar.to.success(
        title: 'Download Concluído',
        'Arquivo salvo em: ${downloadsDir.path}',

        mainButton: TextButton(
          onPressed: () => _openFile(filePath),
          child: const Text('Abrir', style: TextStyle(color: Colors.white)),
        ),
      );
    } catch (e) {
      _closeLoadingDialog();
      AppSnackbar.to.error('Erro no download: $e');
    }
  }

  Future<void> _copyLink() async {
    try {
      await Clipboard.setData(ClipboardData(text: item.fileUrl));
      AppSnackbar.to.success(
        title: 'Link Copiado',
        'O link do arquivo foi copiado para a área de transferência',
      );
    } catch (e) {
      AppSnackbar.to.error('Erro ao copiar link: $e');
    }
  }

  // Métodos auxiliares
  String _getFileName() {
    String fileName =
        _getFileNameFromUrl(item.fileUrl) ??
        '${item.title.replaceAll(RegExp(r'[^\w\s-]'), '')}.pdf';

    if (!fileName.toLowerCase().endsWith('.pdf')) {
      fileName = '$fileName.pdf';
    }

    return fileName;
  }

  String? _getFileNameFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      if (segments.isNotEmpty) {
        String fileName = segments.last;
        if (fileName.contains('?')) {
          fileName = fileName.split('?').first;
        }
        return fileName;
      }
    } catch (e) {
      debugPrint('Erro ao extrair nome do arquivo da URL: $e');
    }
    return null;
  }

  Future<bool> _requestStoragePermission() async {
    if (!Platform.isAndroid) return true;

    if (await Permission.storage.isGranted) return true;

    final status = await Permission.storage.request();
    if (status.isGranted) return true;

    if (await Permission.manageExternalStorage.isGranted) return true;

    final manageStatus = await Permission.manageExternalStorage.request();
    return manageStatus.isGranted;
  }

  Future<Directory> _getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      Directory downloadsDir = Directory('/storage/emulated/0/Download');
      if (!downloadsDir.existsSync()) {
        final externalDir = await getExternalStorageDirectory();
        downloadsDir = Directory('${externalDir!.path}/Download');
      }

      if (!downloadsDir.existsSync()) {
        downloadsDir.createSync(recursive: true);
      }

      return downloadsDir;
    } else {
      return await getDownloadsDirectory() ??
          await getApplicationDocumentsDirectory();
    }
  }

  Future<void> _openFile(String filePath) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        final Uri fileUri = Uri.file(filePath);
        if (await canLaunchUrl(fileUri)) {
          await launchUrl(fileUri);
        }
      } else {
        final directory = File(filePath).parent.path;
        final Uri dirUri = Uri.file(directory);
        if (await canLaunchUrl(dirUri)) {
          await launchUrl(dirUri);
        }
      }
    } catch (e) {
      debugPrint('Erro ao abrir arquivo: $e');
    }
  }

  void _handleDownloadFallback() {
    final tabOpened = WebDownloadService.openInNewTab(item.fileUrl);

    if (tabOpened) {
      AppSnackbar.to.success(
        title: 'Arquivo Aberto',
        'O arquivo foi aberto em nova aba. Use Ctrl+S para salvar.',
      );
    } else {
      AppSnackbar.to.warning(
        title: 'Fallback',
        'Tente clicar com botão direito no link e selecionar "Salvar como..."',
      );
    }
  }

  // Métodos para diálogos e notificações
  void _showLoadingDialog(String message) {
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _closeLoadingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
