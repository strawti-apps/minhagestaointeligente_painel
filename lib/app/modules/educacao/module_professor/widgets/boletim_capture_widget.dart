import 'package:flutter/material.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

class BoletimCaptureWidget extends StatelessWidget {
  final Map<String, dynamic> boletimData;

  const BoletimCaptureWidget({super.key, required this.boletimData});

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

    return Container(
      width: 600,
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho com foto, nome e média
          Row(
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
                      'Boletim de $aluno',
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Média Geral: ${mediaGeral.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: _getMediaColor(mediaGeral),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Tabela de notas
          DataTable(
            columns: const [
              DataColumn(label: Text('Matéria')),
              DataColumn(label: Text('Notas')),
              DataColumn(label: Text('Média')),
              DataColumn(label: Text('Status')),
            ],
            rows:
                boletim.entries.map((entry) {
                  final String materia = entry.key;
                  final Map<String, dynamic> dados = entry.value;
                  final List<double> notas = List<double>.from(
                    dados['notas'] ?? [],
                  );
                  final double media = dados['media'] ?? 0.0;

                  return DataRow(
                    cells: [
                      DataCell(Text(materia)),
                      DataCell(
                        Text(notas.map((n) => n.toStringAsFixed(1)).join(', ')),
                      ),
                      DataCell(
                        Text(
                          media.toStringAsFixed(2),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getMediaColor(media),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getMediaColor(media),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getStatusText(media),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getMediaColor(double media) {
    if (media >= 9.0) return Colors.green;
    if (media >= 7.0) return Colors.blue;
    if (media >= 6.0) return Colors.orange;
    return Colors.red;
  }

  String _getStatusText(double media) {
    if (media >= 9.0) return 'Excelente';
    if (media >= 7.0) return 'Bom';
    if (media >= 6.0) return 'Regular';
    return 'Baixo';
  }
}
