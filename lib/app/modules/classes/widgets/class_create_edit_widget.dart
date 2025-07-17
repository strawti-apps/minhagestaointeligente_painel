import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../shared/widgets/expandable_dropdown_widget.dart';
import '../../../shared/widgets/image_upload_widget.dart';
import '../../../shared/utils/form_validators.dart';
import '../classes_controller.dart';

class ClassCreateEditWidget extends StatefulWidget {
  final bool isEditing;

  const ClassCreateEditWidget({super.key, required this.isEditing});

  @override
  State<ClassCreateEditWidget> createState() => _ClassCreateEditWidgetState();
}

class _ClassCreateEditWidgetState extends State<ClassCreateEditWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassesController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(24),
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
                    ),
                    const SizedBox(width: 16),
                    Text(
                      widget.isEditing ? 'Editar Turma' : 'Criar Nova Turma',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Formulário
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Título
                        AppTextFormField(
                          controller: controller.classTitleController,
                          title: 'Título da Turma *',
                          hintText: 'Digite o título da turma',
                          validator: FormValidators.required,
                          maxLength: 100,
                        ),

                        const SizedBox(height: 15),

                        // Dropdown de Cursos
                        ExpandableDropdownWidget(
                          title: 'Curso',
                          hintText: 'Selecione um curso',
                          searchHintText: 'Buscar curso...',
                          prefixIcon: Icons.book,
                          selectedItem: controller.selectedCourse,
                          items: controller.courses,
                          getItemTitle: (course) => course.title,
                          getItemId: (course) => course.id.toString(),
                          onItemSelected: controller.onCourseSelected,
                          isLoading: controller.courses.isEmpty,
                          emptyMessage: 'Nenhum curso encontrado',
                        ),

                        const SizedBox(height: 15),

                        // Upload de Imagem
                        ImageUploadWidget(
                          initialImageUrl: controller.classThumbnailUrlController.text.isNotEmpty
                              ? controller.classThumbnailUrlController.text
                              : null,
                          currentImageUrl: controller.classThumbnailUrlController.text.isNotEmpty
                              ? controller.classThumbnailUrlController.text
                              : null,
                          onImageChanged: (file) async {
                            if (file != null) {
                              await controller.uploadClassImage(file);
                            } else {
                              controller.classThumbnailUrlController.clear();
                            }
                          },
                          isUploading: controller.isUploadingImage,
                          title: 'Imagem da Turma',
                          hintText: 'Selecione uma imagem para a turma',
                        ),

                        const SizedBox(height: 15),

                        // Botões de ação
                        Row(
                          children: [
                            Expanded(
                              child: AppButtonDefault(
                                buttonColor: Colors.white,
                                textColor: Colors.black,
                                onTap: controller.backToList,
                                text: 'Cancelar',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AppButtonDefault(
                                text: widget.isEditing ? 'Atualizar' : 'Criar',
                                isValid: true,
                                onTap: () {
                                  if (_formKey.currentState?.validate() == true) {
                                    if (widget.isEditing) {
                                      controller.updateClass();
                                    } else {
                                      controller.createClass();
                                    }
                                  }
                                },
                                isLoading:
                                    controller.isLoadingCreating ||
                                    controller.isLoadingEditing,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 