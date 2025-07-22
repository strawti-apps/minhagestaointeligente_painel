import 'package:flutter/material.dart';

import '../saude_controller.dart';

class PlantoesListWidget extends StatelessWidget {
  final SaudeController controller;
  const PlantoesListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.filteredPlantoes.isEmpty) {
      return const Center(child: Text('Nenhum plantão encontrado.'));
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 16,
          runSpacing: 16,
          children:
              controller.filteredPlantoes.map((plantao) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 320,
                    maxWidth: 380,
                  ),
                  child: Card(
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.grey.shade200, width: 1),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cabeçalho com ícone e informações principais
                            Row(
                              children: [
                                // Ícone de plantão
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: _getPlantaoColor(
                                      plantao.horario,
                                    ).withValues(alpha: 0.1),
                                    border: Border.all(
                                      color: _getPlantaoColor(
                                        plantao.horario,
                                      ).withValues(alpha: 0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.access_time,
                                    color: _getPlantaoColor(plantao.horario),
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Informações principais
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        plantao.medicoNome,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getPlantaoColor(
                                            plantao.horario,
                                          ).withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          _getPlantaoTipo(plantao.horario),
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: _getPlantaoColor(
                                              plantao.horario,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Informações de data e horário
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow(
                                    Icons.calendar_today,
                                    _formatDate(plantao.data),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                    Icons.schedule,
                                    plantao.horario,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Botões de ação
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue.shade600,
                                      size: 20,
                                    ),
                                    onPressed:
                                        () =>
                                            controller.goToEditPlantao(plantao),
                                    tooltip: 'Editar',
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade600,
                                      size: 20,
                                    ),
                                    onPressed:
                                        () => controller.deletePlantao(plantao),
                                    tooltip: 'Excluir',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getPlantaoColor(String horario) {
    // Plantão diurno: 08:00-18:00 (80% dos plantões)
    if (horario.startsWith('08:00')) {
      return Colors.orange; // Plantão diurno
    } else {
      return Colors.indigo; // Plantão noturno (18:00-06:00)
    }
  }

  String _getPlantaoTipo(String horario) {
    // Plantão diurno: 08:00-18:00 (80% dos plantões)
    if (horario.startsWith('08:00')) {
      return 'Plantão Diurno';
    } else {
      return 'Plantão Noturno';
    }
  }

  String _formatDate(String date) {
    if (date.isEmpty) return 'Data não informada';
    try {
      final parts = date.split('-');
      if (parts.length == 3) {
        return '${parts[2]}/${parts[1]}/${parts[0]}';
      }
      return date;
    } catch (e) {
      return date;
    }
  }
}
