import 'package:flutter/material.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

class BoletimWidget extends StatelessWidget {
  final Map<String, dynamic> boletimData;
  final VoidCallback? onTap;

  const BoletimWidget({super.key, required this.boletimData, this.onTap});

  @override
  Widget build(BuildContext context) {
    final String image = boletimData['image'] ?? '';
    final String aluno = boletimData['aluno'] ?? '';
    final Map<String, dynamic> boletim = boletimData['boletim'] ?? {};

    // Calcular média geral
    double mediaGeral = 0;
    int totalMaterias = 0;

    boletim.forEach((materia, dados) {
      if (dados is Map && dados['media'] != null) {
        mediaGeral += dados['media'];
        totalMaterias++;
      }
    });

    if (totalMaterias > 0) {
      mediaGeral = mediaGeral / totalMaterias;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 350,
          color: AppColors.card,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho do boletim
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        image,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.textPrimary,
                            child: Text(
                              aluno.isNotEmpty ? aluno[0].toUpperCase() : 'A',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            aluno,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Boletim Escolar',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getMediaColor(mediaGeral),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Média: ${mediaGeral.toStringAsFixed(1)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Lista de matérias
              ...boletim.entries.map((entry) {
                final String materia = entry.key;
                final Map<String, dynamic> dados = entry.value;
                final List<double> notas = List<double>.from(
                  dados['notas'] ?? [],
                );
                final double media = dados['media'] ?? 0.0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            materia,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getMediaColor(media),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              media.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Notas: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Expanded(
                            child: Wrap(
                              spacing: 4,
                              children:
                                  notas.map((nota) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getNotaColor(nota),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        nota.toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 12),

              // Rodapé com informações adicionais
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Clique para ver detalhes completos',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                        ),
                      ),
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

  Color _getMediaColor(double media) {
    if (media >= 9.0) return Colors.green;
    if (media >= 7.0) return Colors.blue;
    if (media >= 6.0) return Colors.orange;
    return Colors.red;
  }

  Color _getNotaColor(double nota) {
    if (nota >= 9.0) return Colors.green;
    if (nota >= 7.0) return Colors.blue;
    if (nota >= 6.0) return Colors.orange;
    return Colors.red;
  }
}
