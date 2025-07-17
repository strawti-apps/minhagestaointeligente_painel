import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../shared/utils/form_validators.dart';
import '../../../themes/app_colors.dart';
import '../quizzes_controller.dart';

class QuizCreateEditWidget extends StatefulWidget {
  final bool isEditing;

  const QuizCreateEditWidget({super.key, required this.isEditing});

  @override
  State<QuizCreateEditWidget> createState() => _QuizCreateEditWidgetState();
}

class _QuizCreateEditWidgetState extends State<QuizCreateEditWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizzesController>(
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
                      widget.isEditing ? 'Editar Questionário' : 'Criar Novo Questionário',
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
                          controller: controller.quizTitleController,
                          title: 'Título do Questionário *',
                          hintText: 'Digite o título do questionário',
                          validator: FormValidators.required,
                          maxLength: 100,
                        ),

                        const SizedBox(height: 15),

                        // Tipo
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tipo do Questionário',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: controller.selectedQuizType,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              ),
                              items: controller.quizTypes.map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.selectedQuizType = newValue;
                                  controller.update();
                                }
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Questões
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Questões',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: controller.addQuestion,
                              icon: const Icon(Icons.add, size: 16),
                              label: const Text('Adicionar Questão'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryDark,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Lista de questões
                        ...controller.questions.asMap().entries.map((entry) {
                          int questionIndex = entry.key;
                          return QuestionWidget(
                            questionIndex: questionIndex,
                            controller: controller,
                          );
                        }),

                        const SizedBox(height: 32),

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
                                      controller.updateQuiz();
                                    } else {
                                      controller.createQuiz();
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

class QuestionWidget extends StatelessWidget {
  final int questionIndex;
  final QuizzesController controller;

  const QuestionWidget({
    super.key,
    required this.questionIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header da questão
          Row(
            children: [
              Expanded(
                child: Text(
                  'Questão ${questionIndex + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => controller.removeQuestion(questionIndex),
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Remover questão',
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Campo de texto da questão
          AppTextFormField(
            initialValue: controller.questions[questionIndex].text,
            hintText: 'Digite o enunciado da questão',
            maxLines: 3,
            validator: FormValidators.required,
            onChanged: (value) => controller.updateQuestionText(questionIndex, value),
          ),

          const SizedBox(height: 16),

          // Alternativas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Alternativas',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => controller.addOption(questionIndex),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Adicionar Alternativa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

                     // Lista de alternativas
           if (controller.questionsOptions[questionIndex] != null)
             ...controller.questionsOptions[questionIndex]!.asMap().entries.map((optionEntry) {
               int optionIndex = optionEntry.key;
               var option = optionEntry.value;
               
               return OptionWidget(
                 questionIndex: questionIndex,
                 optionIndex: optionIndex,
                 option: option,
                 controller: controller,
               );
             }),
        ],
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  final int questionIndex;
  final int optionIndex;
  final dynamic option;
  final QuizzesController controller;

  const OptionWidget({
    super.key,
    required this.questionIndex,
    required this.optionIndex,
    required this.option,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: option.isCorrect ? Colors.green.shade50 : Colors.grey.shade50,
        border: Border.all(
          color: option.isCorrect ? Colors.green : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          // Radio button para marcar como correta
          Radio<bool>(
            value: true,
            groupValue: option.isCorrect,
            onChanged: (value) {
              if (value == true) {
                controller.setCorrectOption(questionIndex, optionIndex);
              }
            },
            activeColor: Colors.green,
          ),

          // Campo de texto da alternativa
          Expanded(
            child: TextFormField(
              initialValue: option.text,
              onChanged: (value) => controller.updateOptionText(questionIndex, optionIndex, value),
              decoration: const InputDecoration(
                hintText: 'Digite a alternativa',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
              ),
              validator: FormValidators.required,
            ),
          ),

          // Botão de remover
          IconButton(
            onPressed: () => controller.removeOption(questionIndex, optionIndex),
            icon: const Icon(Icons.remove_circle, color: Colors.red, size: 20),
            tooltip: 'Remover alternativa',
          ),
        ],
      ),
    );
  }
} 