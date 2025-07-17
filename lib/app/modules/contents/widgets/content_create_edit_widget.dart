import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/form_validators.dart';
import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../shared/widgets/expandable_dropdown_widget.dart';
import '../contents_controller.dart';

class ContentCreateEditWidget extends StatefulWidget {
  final bool isEditing;

  const ContentCreateEditWidget({super.key, required this.isEditing});

  @override
  State<ContentCreateEditWidget> createState() =>
      _ContentCreateEditWidgetState();
}

class _ContentCreateEditWidgetState extends State<ContentCreateEditWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentsController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.backToList,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      widget.isEditing
                          ? 'Editar Conteúdo'
                          : 'Criar Novo Conteúdo',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ExpandableDropdownWidget(
                          title: 'Curso *',
                          hintText: 'Selecione um curso',
                          searchHintText: 'Buscar curso...',
                          prefixIcon: Icons.school,
                          selectedItem: controller.selectedCourse,
                          items: controller.courses,
                          getItemTitle: (course) => course.title,
                          getItemId: (course) => course.id.toString(),
                          onItemSelected: (course) {
                            controller.selectCourse(course);
                          },
                          isLoading: controller.courses.isEmpty,
                          emptyMessage: 'Nenhum curso encontrado',
                        ),

                        const SizedBox(height: 32),

                        if (controller.selectedCourse != null) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Módulos',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: controller.addModule,
                                icon: const Icon(Icons.add, size: 16),
                                label: const Text('Adicionar Módulo'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1976D2),
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          ...controller.currentModules.asMap().entries.map((
                            entry,
                          ) {
                            int moduleIndex = entry.key;
                            return ModuleWidget(
                              moduleIndex: moduleIndex,
                              controller: controller,
                            );
                          }),

                          const SizedBox(height: 32),
                        ],

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
                                isValid:
                                    controller.selectedCourse != null &&
                                    controller.currentModules.isNotEmpty,
                                onTap: () {
                                  if (controller.selectedCourse != null &&
                                      controller.currentModules.isNotEmpty) {
                                    if (widget.isEditing) {
                                      controller.updateContent();
                                    } else {
                                      controller.createContent();
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

class ModuleWidget extends StatelessWidget {
  final int moduleIndex;
  final ContentsController controller;

  const ModuleWidget({
    super.key,
    required this.moduleIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final module = controller.currentModules[moduleIndex];
    final lessons = controller.currentLessons[moduleIndex] ?? [];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Módulo ${moduleIndex + 1}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => controller.removeModule(moduleIndex),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Remover módulo',
                ),
              ],
            ),

            const SizedBox(height: 12),

            AppTextFormField(
              initialValue: module.title,
              title: 'Título do Módulo *',
              hintText: 'Digite o título do módulo',
              validator: FormValidators.required,
              onChanged: (value) => controller.updateModuleTitle(moduleIndex, value),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Aulas',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => controller.addLesson(moduleIndex),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Adicionar Aula'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            
            ...lessons.asMap().entries.map((entry) {
              int lessonIndex = entry.key;
              return LessonWidget(
                moduleIndex: moduleIndex,
                lessonIndex: lessonIndex,
                controller: controller,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class LessonWidget extends StatelessWidget {
  final int moduleIndex;
  final int lessonIndex;
  final ContentsController controller;

  const LessonWidget({
    super.key,
    required this.moduleIndex,
    required this.lessonIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final lesson = controller.currentLessons[moduleIndex]![lessonIndex];

    return Card(
      margin: const EdgeInsets.only(bottom: 12, left: 0, top: 8),
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Aula ${lessonIndex + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  onPressed:
                      () => controller.removeLesson(moduleIndex, lessonIndex),
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  tooltip: 'Remover aula',
                ),
              ],
            ),

            const SizedBox(height: 8),

            AppTextFormField(
              initialValue: lesson.title,
              title: 'Título da Aula *',
              hintText: 'Digite o título da aula',
              validator: FormValidators.required,
              onChanged: (value) => controller.updateLessonTitle(
                moduleIndex,
                lessonIndex,
                value,
              ),
            ),

            const SizedBox(height: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tipo da Aula *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: lesson.type,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha:0.3),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha:0.3),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: const Color(0xFF1976D2).withValues(alpha:0.5),
                        width: 1.5,
                      ),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(value: 'video', child: Text('Vídeo')),
                    DropdownMenuItem(
                      value: 'material',
                      child: Text('Material'),
                    ),
                    DropdownMenuItem(
                      value: 'quiz',
                      child: Text('Questionário'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.updateLessonType(
                        moduleIndex,
                        lessonIndex,
                        newValue,
                      );
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (lesson.type == 'video') ...[
              AppTextFormField(
                initialValue: lesson.videoId ?? '',
                title: 'ID do Vídeo',
                hintText: 'Digite o ID do vídeo (ex: dQw4w9WgXcQ)',
                onChanged: (value) => controller.updateLessonVideoId(
                  moduleIndex,
                  lessonIndex,
                  value,
                ),
              ),
            ] else if (lesson.type == 'material') ...[
              ExpandableDropdownWidget(
                title: 'Material',
                hintText: 'Selecione um material',
                searchHintText: 'Buscar material...',
                prefixIcon: Icons.description,
                selectedItem:
                    controller.materials
                        .where((m) => m.id != null && m.id == lesson.materialId)
                        .firstOrNull,
                items: controller.materials,
                getItemTitle: (material) => material.title,
                getItemId: (material) => material.id?.toString() ?? '',
                onItemSelected: (material) {
                  controller.updateLessonMaterialId(
                    moduleIndex,
                    lessonIndex,
                    material?.id,
                  );
                },
                isLoading: controller.materials.isEmpty,
                emptyMessage: 'Nenhum material encontrado',
              ),
            ] else if (lesson.type == 'quiz') ...[
              ExpandableDropdownWidget(
                title: 'Questionário',
                hintText: 'Selecione um questionário',
                searchHintText: 'Buscar questionário...',
                prefixIcon: Icons.quiz,
                selectedItem:
                    controller.quizzes
                        .where((q) => q.id != null && q.id == lesson.quizId)
                        .firstOrNull,
                items: controller.quizzes,
                getItemTitle: (quiz) => quiz.title,
                getItemId: (quiz) => quiz.id?.toString() ?? '',
                onItemSelected: (quiz) {
                  controller.updateLessonQuizId(
                    moduleIndex,
                    lessonIndex,
                    quiz?.id,
                  );
                },
                isLoading: controller.quizzes.isEmpty,
                emptyMessage: 'Nenhum questionário encontrado',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
