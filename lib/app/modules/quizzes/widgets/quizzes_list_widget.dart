import 'package:flutter/material.dart';

import '../../../infra/models/quiz_model.dart';
import '../../../themes/app_colors.dart';
import '../quizzes_controller.dart';
import 'quiz_card_actions_widget.dart';

class QuizzesListWidget extends StatelessWidget {
  final QuizzesController controller;
  const QuizzesListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.filteredQuizzes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Nenhum questionário encontrado',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Se a tela for pequena, usar lista vertical
          if (constraints.maxWidth < 768) {
            return _buildMobileList();
          }
          // Se a tela for grande, usar tabela
          return _buildDesktopTable();
        },
      ),
    );
  }

  Widget _buildDesktopTable() {
    return Column(
      children: [
        // Header da tabela
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'TÍTULO',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'TIPO',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'QUESTÕES',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'CRIADO EM',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(
                width: 100,
                child: Text(
                  'AÇÕES',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        
        // Linhas da tabela
        Expanded(
          child: ListView.builder(
            itemCount: controller.filteredQuizzes.length,
            itemBuilder: (context, index) {
              final quiz = controller.filteredQuizzes[index];
              return _buildTableRow(quiz, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTableRow(QuizModel quiz, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Título
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quiz.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
                     // Tipo
           Expanded(
             flex: 2,
             child: Align(
               alignment: Alignment.centerLeft,
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                 decoration: BoxDecoration(
                   color: _getTypeColor(quiz.type),
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Text(
                   quiz.type,
                   style: const TextStyle(
                     fontSize: 12,
                     fontWeight: FontWeight.w500,
                     color: Colors.white,
                   ),
                   textAlign: TextAlign.center,
                 ),
               ),
             ),
           ),
          
          // Questões
          Expanded(
            flex: 2,
            child: Text(
              '${controller.getQuestionsCount(quiz.id)} questões',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          
          // Data de criação
          Expanded(
            flex: 2,
            child: Text(
              _formatDate(quiz.createdAt),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          
          // Ações
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuizCardActionsWidget(
                  item: quiz,
                  controller: controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.filteredQuizzes.length,
      itemBuilder: (context, index) {
        final quiz = controller.filteredQuizzes[index];
        return _buildMobileCard(quiz);
      },
    );
  }

  Widget _buildMobileCard(QuizModel quiz) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  quiz.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              QuizCardActionsWidget(
                item: quiz,
                controller: controller,
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getTypeColor(quiz.type),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  quiz.type,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${controller.getQuestionsCount(quiz.id)} questões',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Criado em ${_formatDate(quiz.createdAt)}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'prova':
        return Colors.red.shade400;
      case 'teste':
        return Colors.blue.shade400;
      default:
        return Colors.grey.shade400;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Data não disponível';

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }
} 