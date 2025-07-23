import 'package:flutter/material.dart';

import '../saude_controller.dart';

class HospitalCardWidget extends StatelessWidget {
  final HospitalModel hospital;
  final SaudeController controller;

  const HospitalCardWidget({
    super.key,
    required this.hospital,
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
              // Imagem do hospital
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
                    hospital.imagem ??
                        'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=400&h=300&fit=crop',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey.shade100,
                        child: Icon(
                          Icons.local_hospital,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),

              // Informações do hospital
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título e tipo
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            hospital.nome,
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
                            color: _getTipoColor(hospital.tipo),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            hospital.tipo ?? 'N/A',
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
                      _getDescricao(hospital),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Endereço
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            hospital.endereco,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Telefone e email
                    if (hospital.telefone != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 16,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            hospital.telefone!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],

                    if (hospital.email != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 16,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              hospital.email!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Botões de ação
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => controller.goToEditHospital(hospital),
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.deleteHospital(hospital),
                    tooltip: 'Remover',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTipoColor(String? tipo) {
    switch (tipo) {
      case 'Público':
        return Colors.blue;
      case 'Privado':
        return Colors.green;
      case 'Filantrópico':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getDescricao(HospitalModel hospital) {
    String descricao = 'Hospital ${hospital.tipo?.toLowerCase() ?? 'médico'}';

    if (hospital.capacidade != null) {
      descricao += ' com capacidade para ${hospital.capacidade} pacientes';
    }

    descricao +=
        '. Oferece atendimento de qualidade e possui uma equipe médica especializada.';

    return descricao;
  }
}
