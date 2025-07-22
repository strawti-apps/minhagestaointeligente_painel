import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/navbar/navbar_desktop_widget.dart';
import '../../../../themes/app_colors.dart';
import '../controllers/pacientes_controller.dart';
import '../widgets/paciente_widget.dart';

class PacientesPage extends StatelessWidget {
  static const route = '/medico/pacientes';
  const PacientesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PacientesController());

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: Container(
              color: AppColors.background,
              child: GetBuilder<PacientesController>(
                builder: (controller) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pacientes',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 250,
                                    minWidth: 100,
                                  ),
                                  child: TextField(
                                    controller: controller.searchController,
                                    onChanged: controller.onSearchChanged,
                                    decoration: InputDecoration(
                                      hintText: 'Buscar paciente...',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Filtro por especialidade
                                PopupMenuButton<String>(
                                  onSelected: controller.onFilterChanged,
                                  itemBuilder:
                                      (context) =>
                                          controller.especialidades
                                              .map(
                                                (especialidade) =>
                                                    PopupMenuItem(
                                                      value: especialidade,
                                                      child: Text(
                                                        especialidade,
                                                      ),
                                                    ),
                                              )
                                              .toList(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.textSecondary,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          controller.selectedFilter,
                                          style: TextStyle(
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Conteúdo principal
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child:
                              controller.filteredPacientes.isEmpty
                                  ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.people_outline,
                                          size: 64,
                                          color: AppColors.textSecondary,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Nenhum paciente encontrado',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : LayoutBuilder(
                                    builder: (context, constraints) {
                                      return SingleChildScrollView(
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxHeight: constraints.maxHeight,
                                          ),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Wrap(
                                              spacing: 10,
                                              runSpacing: 10,
                                              children:
                                                  controller.filteredPacientes.map((
                                                    paciente,
                                                  ) {
                                                    return PacienteWidget(
                                                      pacienteData: paciente,
                                                      onTap:
                                                          () => controller
                                                              .showPacienteDetails(
                                                                paciente,
                                                              ),
                                                    );
                                                  }).toList(),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
