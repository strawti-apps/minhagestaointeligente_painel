import 'package:flutter/material.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

class AlunoWidget extends StatelessWidget {
  final Map<String, dynamic> alunoData;
  final VoidCallback? onTap;

  const AlunoWidget({super.key, required this.alunoData, this.onTap});

  @override
  Widget build(BuildContext context) {
    final String nome = alunoData['nome'] ?? '';
    final String turma = alunoData['turma'] ?? '';
    final int idade = alunoData['idade'] ?? 0;
    final String matricula = alunoData['matricula'] ?? '';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 300,
          color: AppColors.background,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Foto do aluno
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryDark.withValues(alpha: 0.3),
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    _getAlunoFoto(nome),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: AppColors.primaryDark,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Nome do aluno
              Text(
                nome,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Informações do aluno
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.school,
                      label: 'Turma:',
                      value: turma,
                      valueColor: AppColors.primaryDark,
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.cake,
                      label: 'Idade:',
                      value: '$idade anos',
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.badge,
                      label: 'Matrícula:',
                      value: matricula,
                      valueColor: Colors.grey.shade700,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Status do aluno
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 16, color: Colors.green),
                    const SizedBox(width: 6),
                    Text(
                      'Ativo',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Botões de ação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(
                    icon: Icons.assignment,
                    label: 'Boletim',
                    onTap: () {
                      // Navegar para o boletim do aluno
                    },
                  ),
                  _ActionButton(
                    icon: Icons.check_circle_outline,
                    label: 'Frequência',
                    onTap: () {
                      // Navegar para a frequência do aluno
                    },
                  ),
                  _ActionButton(
                    icon: Icons.message,
                    label: 'Contato',
                    onTap: () {
                      // Abrir contato do responsável
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getAlunoFoto(String nome) {
    // Mapeamento de nomes para fotos de crianças
    final fotosMap = {
      'Lucas Martins':
          'https://img.freepik.com/vetores-premium/desenho-de-rosto-de-menino-bonito_18591-41511.jpg?size=626&ext=jpg',
      'Julia Rocha':
          'https://img.freepik.com/vetores-premium/desenho-de-rosto-de-menina-cute_18591-41516.jpg',
      'Pedro Henrique': 'assets/images/children/child3.jpg',
      'Ana Beatriz': 'assets/images/children/child4.jpg',
      'Carlos Eduardo': 'assets/images/children/child5.jpg',
      'Mariana Silva':
          'https://image.freepik.com/vetores-gratis/desenho-de-rosto-de-menina-cute_18591-41514.jpg',
      'Rafael Lima': 'assets/images/children/child7.jpg',
      'Isabela Fernandes':
          'https://img.freepik.com/vetores-gratis/menina-com-desenho-de-rosto-de-cabelo-vermelho_1308-141052.jpg?w=900&t=st=1694565349~exp=1694565949~hmac=dad770127057a27054e4bd3acdcf3338c2c356ff9c960a13216448b1112e7840',
      'João Pedro':
          'https://img.freepik.com/vetores-premium/desenho-de-rosto-de-menino-bonito_18591-41511.jpg?size=626&ext=jpg',
      'Laura Mendes': 'assets/images/children/child10.jpg',
    };

    return fotosMap[nome] ?? 'assets/images/children/default_child.jpg';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: valueColor ?? AppColors.textPrimary,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primaryDark.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppColors.primaryDark),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
