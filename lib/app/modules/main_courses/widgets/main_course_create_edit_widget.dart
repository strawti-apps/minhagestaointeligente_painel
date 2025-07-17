import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../shared/widgets/image_upload_widget.dart';
import '../../../shared/utils/form_validators.dart';
import '../main_courses_controller.dart';

class MainCourseCreateEditWidget extends StatefulWidget {
  final bool isEditing;

  const MainCourseCreateEditWidget({super.key, required this.isEditing});

  @override
  State<MainCourseCreateEditWidget> createState() => _MainCourseCreateEditWidgetState();
}

class _MainCourseCreateEditWidgetState extends State<MainCourseCreateEditWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainCoursesController>(
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
                      widget.isEditing ? 'Editar Curso' : 'Criar Novo Curso',
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
                          controller: controller.courseTitleController,
                          title: 'Título do Curso *',
                          hintText: 'Digite o título do curso',
                          validator: FormValidators.required,
                          maxLength: 100,
                        ),

                        const SizedBox(height: 15),

                        // Descrição
                        AppTextFormField(
                          controller: controller.courseDescriptionController,
                          title: 'Descrição',
                          hintText: 'Digite uma descrição para o curso',
                          maxLines: 4,
                          maxLength: 500,
                          optional: true,
                        ),

                        const SizedBox(height: 15),

                        // Categoria
                        AppTextFormField(
                          controller: controller.courseCategoryController,
                          title: 'Categoria',
                          hintText: 'Digite a categoria do curso',
                          maxLength: 50,
                          optional: true,
                        ),

                        const SizedBox(height: 15),

                        // Upload de Imagem de Capa
                        ImageUploadWidget(
                          initialImageUrl: controller.courseCoverImageUrlController.text.isNotEmpty
                              ? controller.courseCoverImageUrlController.text
                              : null,
                          currentImageUrl: controller.courseCoverImageUrlController.text.isNotEmpty
                              ? controller.courseCoverImageUrlController.text
                              : null,
                          onImageChanged: (file) async {
                            if (file != null) {
                              await controller.uploadCourseImage(file);
                            } else {
                              controller.courseCoverImageUrlController.clear();
                            }
                          },
                          isUploading: controller.isUploadingImage,
                          title: 'Imagem de Capa do Curso',
                          hintText: 'Selecione uma imagem de capa',
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
                                      controller.updateCourse();
                                    } else {
                                      controller.createCourse();
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
