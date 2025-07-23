import 'package:flutter/material.dart';

import '../educacao_controller.dart';

class AlunoCardWidget extends StatelessWidget {
  final Aluno aluno;
  final EducacaoController controller;

  const AlunoCardWidget({
    super.key,
    required this.aluno,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem do aluno
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    aluno.imagem ??
                        'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?w=400&h=300&fit=crop',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey.shade100,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),

              // Informações do aluno
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título e turma
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            aluno.nome,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getTurmaColor(aluno.turma),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            aluno.turma,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Descrição
                    Text(
                      _getDescricao(aluno),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Escola
                    if (aluno.escola != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            size: 16,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              aluno.escola!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],

                    // Responsável
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Responsável: ${aluno.responsavel}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Telefone
                    if (aluno.telefone != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 16,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            aluno.telefone!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Botões de ação
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => controller.openEditAluno(aluno),
                      tooltip: 'Editar',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.deleteAluno(aluno),
                      tooltip: 'Remover',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTurmaColor(String turma) {
    if (turma.contains('1º') || turma.contains('2º')) {
      return Colors.green;
    } else if (turma.contains('3º') || turma.contains('4º')) {
      return Colors.blue;
    } else if (turma.contains('5º') || turma.contains('6º')) {
      return Colors.orange;
    } else {
      return Colors.purple;
    }
  }

  String _getDescricao(Aluno aluno) {
    String descricao = 'Aluno do ${aluno.turma}';

    if (aluno.idade != null) {
      descricao += ' com ${aluno.idade} anos';
    }

    descricao +=
        '. Estuda na ${aluno.escola ?? 'escola'} e é responsável pelo seu desenvolvimento educacional.';

    return descricao;
  }
}
