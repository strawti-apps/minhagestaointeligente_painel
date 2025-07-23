import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_button_default.dart';
import '../../../shared/widgets/app_text_form_field.dart';
import '../../../themes/app_colors.dart';
import '../educacao_controller.dart';
import 'escola_card_widget.dart';

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

                  // Nome da escola
                  AppTextFormField(
                    controller: controller.escolaNomeController,
                    hintText: 'Nome da escola ou creche',
                  ),
                  const SizedBox(height: 16),

                  // Tipo
                  AppTextFormField(
                    controller: controller.escolaTipoController,
                    hintText: 'Tipo (Escola ou Creche)',
                  ),
                  const SizedBox(height: 16),

                  // Endereço
                  AppTextFormField(
                    controller: controller.escolaEnderecoController,
                    hintText: 'Endereço completo',
                  ),
                  const SizedBox(height: 16),

                  // Telefone e Email
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormField(
                          controller: controller.escolaTelefoneController,
                          hintText: 'Telefone',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextFormField(
                          controller: controller.escolaEmailController,
                          hintText: 'Email',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Capacidade e Turnos
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormField(
                          controller: controller.escolaCapacidadeController,
                          hintText: 'Capacidade (número de alunos)',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextFormField(
                          controller: controller.escolaTurnosController,
                          hintText: 'Turnos (Matutino, Vespertino, Integral)',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // URL da imagem
                  AppTextFormField(
                    controller: controller.escolaImagemController,
                    hintText: 'URL da imagem da escola (opcional)',
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
                  : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: controller.filteredEscolas.length,
                    itemBuilder: (context, index) {
                      final escola = controller.filteredEscolas[index];
                      return EscolaCardWidget(
                        escola: escola,
                        controller: controller,
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
