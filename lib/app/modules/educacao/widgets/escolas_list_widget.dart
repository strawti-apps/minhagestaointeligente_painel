import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../educacao_controller.dart';

class EscolasListWidget extends StatelessWidget {
  const EscolasListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EducacaoController>();
    if (controller.creatingEditing == 'escola') {
      return Center(
        child: Card(
          elevation: 0.5,
          color: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    controller.isEditing
                        ? 'Editar Escola/Creche'
                        : 'Nova Escola/Creche',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  AppTextFormField(
                    controller: controller.escolaNomeController,
                    hintText: 'Nome da escola ou creche',
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    controller: controller.escolaTipoController,
                    hintText: 'Tipo (Escola ou Creche)',
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    controller: controller.escolaEnderecoController,
                    hintText: 'Endereço',
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppButtonDefault(
                          text: 'Cancelar',
                          onTap: controller.closeForm,
                          borderColor: AppColors.textPrimary,
                          buttonColor: AppColors.card,
                          textColor: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: AppButtonDefault(
                          text: controller.isEditing ? 'Salvar' : 'Criar',
                          onTap:
                              controller.isEditing
                                  ? controller.updateEscola
                                  : controller.createEscola,
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
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppTextFormField(
                  hintText: 'Pesquisar Escolas/Creches',
                  prefixIcon: Icon(Icons.search),
                  onChanged: controller.searchEscolas,
                  optional: true,
                ),
              ),
              SizedBox(width: 40),
              AppButtonDefault(
                width: 180,
                usingJustPadding: false,
                onTap: controller.openCreateEscola,
                icon: Icons.add,
                text: 'Nova Escola/Creche',
              ),
            ],
          ),
        ),
        Expanded(
          child:
              controller.filteredEscolas.isEmpty
                  ? const Center(
                    child: Text('Nenhuma escola ou creche encontrada.'),
                  )
                  : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children:
                            controller.filteredEscolas.map((escola) {
                              return ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 320,
                                  maxWidth: 380,
                                ),
                                child: Card(
                                  elevation: 2,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                escola.nome,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed:
                                                      () => controller
                                                          .openEditEscola(
                                                            escola,
                                                          ),
                                                  tooltip: 'Editar',
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed:
                                                      () => controller
                                                          .deleteEscola(escola),
                                                  tooltip: 'Remover',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          escola.tipo,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Endereço: ${escola.endereco}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        const Icon(
                                          Icons.school,
                                          size: 32,
                                          color: Colors.blueAccent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }
}
