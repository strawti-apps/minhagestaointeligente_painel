import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import 'saude_controller.dart';
import 'widgets/hospital_card_widget.dart';
import 'widgets/hospital_create_edit_widget.dart';
import 'widgets/hospital_header_widget.dart';
import 'widgets/medico_create_edit_widget.dart';
import 'widgets/medico_header_widget.dart';
import 'widgets/medico_search_field.dart';
import 'widgets/medicos_list_widget.dart';
import 'widgets/plantao_create_edit_widget.dart';
import 'widgets/plantao_header_widget.dart';
import 'widgets/plantao_search_field.dart';
import 'widgets/plantoes_list_widget.dart';

class SaudePage extends StatelessWidget {
  static const String routeMedicos = '/medicos';
  static const String routePlantoes = '/plantoes';

  const SaudePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<SaudeController>(
              builder: (controller) {
                switch (controller.selectedSubModule) {
                  case 'hospitais':
                    return Column(
                      children: [
                        const HospitalHeaderWidget(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.filteredHospitais.length,
                            itemBuilder: (context, index) {
                              final hospital =
                                  controller.filteredHospitais[index];
                              return HospitalCardWidget(
                                hospital: hospital,
                                controller: controller,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  case 'hospital_create':
                    return const HospitalCreateEditWidget(isEditing: false);
                  case 'hospital_edit':
                    return const HospitalCreateEditWidget(isEditing: true);
                  case 'medico_create':
                    return const MedicoCreateEditWidget(isEditing: false);
                  case 'medico_edit':
                    return const MedicoCreateEditWidget(isEditing: true);
                  case 'plantoes_list':
                    return Column(
                      children: [
                        const PlantaoHeaderWidget(),
                        const PlantaoSearchField(),
                        Expanded(
                          child: PlantoesListWidget(controller: controller),
                        ),
                      ],
                    );
                  case 'plantao_create':
                    return const PlantaoCreateEditWidget(isEditing: false);
                  case 'plantao_edit':
                    return const PlantaoCreateEditWidget(isEditing: true);
                  case 'medicos_list':
                    return Column(
                      children: [
                        const MedicoHeaderWidget(),
                        const MedicoSearchField(),
                        Expanded(
                          child: MedicosListWidget(controller: controller),
                        ),
                      ],
                    );
                  default:
                    return Column(
                      children: [
                        const MedicoHeaderWidget(),
                        const MedicoSearchField(),
                        Expanded(
                          child: MedicosListWidget(controller: controller),
                        ),
                      ],
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
