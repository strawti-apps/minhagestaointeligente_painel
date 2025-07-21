import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/form_validators.dart';
import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../materials_controller.dart';

class MaterialCreateEditWidget extends StatefulWidget {
  final bool isEditing;

  const MaterialCreateEditWidget({super.key, required this.isEditing});

  @override
  State<MaterialCreateEditWidget> createState() =>
      _MaterialCreateEditWidgetState();
}

class _MaterialCreateEditWidgetState extends State<MaterialCreateEditWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFileName;
  final bool _isDragOver = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MaterialsController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.backToList,
                      icon: const Icon(Icons.arrow_back),
                      tooltip: 'Voltar',
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.isEditing ? 'Editar Material' : 'Novo Material',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Form Fields
                AppTextFormField(
                  controller: controller.materialTitleController,
                  title: 'Título *',
                  hintText: 'Digite o título do material',
                  validator: FormValidators.required,
                ),
                const SizedBox(height: 20),

                // File Upload Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.attach_file,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Arquivo do Material',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // URL Field
                      AppTextFormField(
                        controller: controller.materialFileUrlController,
                        title: 'URL do Arquivo *',
                        hintText: 'Cole a URL do arquivo ou faça upload abaixo',
                        validator: FormValidators.required,
                        maxLines: 2,
                      ),

                      const SizedBox(height: 16),

                      // Upload Section
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                _isDragOver
                                    ? AppColors.primary
                                    : AppColors.primary.withValues(alpha: 0.3),
                            width: _isDragOver ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color:
                              _isDragOver
                                  ? AppColors.primary.withValues(alpha: 0.05)
                                  : Colors.grey[50],
                        ),
                        child: InkWell(
                          onTap:
                              controller.isUploadingFile
                                  ? null
                                  : () => _selectFile(controller),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 32,
                              horizontal: 16,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (controller.isUploadingFile) ...[
                                  const CircularProgressIndicator(),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Enviando arquivo...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ] else if (_selectedFileName != null) ...[
                                  Icon(
                                    Icons.check_circle,
                                    size: 48,
                                    color: AppColors.success,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Arquivo selecionado:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _selectedFileName!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  OutlinedButton.icon(
                                    onPressed: () => _selectFile(controller),
                                    icon: const Icon(Icons.refresh),
                                    label: const Text(
                                      'Selecionar outro arquivo',
                                    ),
                                  ),
                                ] else ...[
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 48,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Clique para selecionar um arquivo',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    kIsWeb
                                        ? 'ou arraste e solte aqui'
                                        : 'Toque para abrir o seletor de arquivos',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      'PDF, DOC, DOCX (até 10MB)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.primaryDark,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: controller.backToList,
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 15),
                    AppButtonDefault(
                      text:
                          widget.isEditing
                              ? 'Salvar Alterações'
                              : 'Criar Material',
                      onTap: () => _saveMaterial(controller),
                      isLoading:
                          widget.isEditing
                              ? controller.isLoadingEditing
                              : controller.isLoadingCreating,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectFile(MaterialsController controller) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: false,
        withData: kIsWeb, // Para web, carrega os bytes
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        setState(() {
          _selectedFileName = file.name;
        });

        // Fazer upload do arquivo
        String? uploadedUrl;

        if (kIsWeb) {
          // Para web, usar bytes
          if (file.bytes != null) {
            uploadedUrl = await controller.uploadFileBytes(
              file.bytes!,
              file.name,
            );
          }
        } else {
          // Para mobile/desktop, usar path
          if (file.path != null) {
            final fileObj = File(file.path!);
            uploadedUrl = await controller.uploadFile(fileObj);
          }
        }

        if (uploadedUrl != null) {
          // Sucesso no upload
          setState(() {
            _selectedFileName = file.name;
          });
        } else {
          // Erro no upload
          setState(() {
            _selectedFileName = null;
          });
        }
      }
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Erro ao selecionar arquivo: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      setState(() {
        _selectedFileName = null;
      });
    }
  }

  Future<void> _saveMaterial(MaterialsController controller) async {
    if (_formKey.currentState?.validate() == true) {
      await controller.saveMaterial();
      if (!controller.isLoadingCreating && !controller.isLoadingEditing) {
        // Reset filename after successful save
        setState(() {
          _selectedFileName = null;
        });
      }
    }
  }
}
