import 'package:flutter/material.dart';

import '../../../shared/mixins/navigation_helper.dart';
import '../../../shared/widgets/quick_access_card.dart';
import '../../saude/module_medico/pages/consultas_page.dart';
import '../../saude/module_medico/pages/pacientes_page.dart';
import '../../saude/module_medico/pages/receitas_page.dart';

class MedicoDashboardWidget extends StatelessWidget with NavigationHelper {
  final bool isMobile;
  const MedicoDashboardWidget({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final atalhosCards = [
      _MedicoCardData(
        icon: Icons.receipt_long,
        title: 'Receitas',
        description: 'Gerencie receitas',
        color: Colors.blue,
        onTap: () => navigateWithType(ReceitasPage.route),
      ),
      _MedicoCardData(
        icon: Icons.calendar_today,
        title: 'Consultas',
        description: 'Veja suas consultas',
        color: Colors.green,
        onTap: () => navigateWithType(ConsultasPage.route),
      ),
      _MedicoCardData(
        icon: Icons.people,
        title: 'Pacientes',
        description: 'Gerencie pacientes',
        color: Colors.deepPurple,
        onTap: () => navigateWithType(PacientesPage.route),
      ),
    ];

    double cardHeight = isMobile ? 100 : 120;

    Widget responsiveInfoCards(List<_MedicoInfoCardOld> cards) {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children:
            cards.map((card) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300, minWidth: 200),
                child: card,
              );
            }).toList(),
      );
    }

    Widget responsiveAtalhosCards(List<_MedicoCardData> cards) {
      return LayoutBuilder(
        builder: (context, constraints) {
          double localCardWidth =
              isMobile ? (constraints.maxWidth / 2) - 14 : 200;
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children:
                cards.map((card) {
                  return SizedBox(
                    width: localCardWidth,
                    height: 120,
                    child: _MedicoAtalhoCard(
                      icon: card.icon,
                      title: card.title,
                      description: card.description,
                      color: card.color,
                      height: cardHeight,
                      onTap: card.onTap,
                    ),
                  );
                }).toList(),
          );
        },
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 12 : 32),
      child:
          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Dashboard ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Cards de atendimentos
                  responsiveInfoCards([
                    _MedicoInfoCardOld(
                      title: 'Atendimentos do Dia',
                      value: '8',
                      color: Colors.green,
                      icon: Icons.today,
                    ),
                    _MedicoInfoCardOld(
                      title: 'Semana',
                      value: '32',
                      color: Colors.orange,
                      icon: Icons.calendar_view_week,
                    ),
                    _MedicoInfoCardOld(
                      title: 'Mês',
                      value: '120',
                      color: Colors.blue,
                      icon: Icons.calendar_month,
                    ),
                  ]),
                  SizedBox(height: 16),
                  // Classificação de risco
                  Text(
                    'Classificação de Risco',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  responsiveInfoCards([
                    _MedicoInfoCardOld(
                      title: 'Verde',
                      value: '10',
                      color: Colors.green,
                      icon: Icons.circle,
                    ),
                    _MedicoInfoCardOld(
                      title: 'Amarelo',
                      value: '0',
                      color: Colors.yellow,
                      icon: Icons.circle,
                    ),
                    _MedicoInfoCardOld(
                      title: 'Laranja',
                      value: '5',
                      color: Colors.orange,
                      icon: Icons.circle,
                    ),
                    _MedicoInfoCardOld(
                      title: 'Vermelho',
                      value: '2',
                      color: Colors.red,
                      icon: Icons.circle,
                    ),
                  ]),
                  SizedBox(height: 24),
                  // Acesso rápido para mobile
                  Text(
                    'Acesso Rápido',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  responsiveAtalhosCards(atalhosCards),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coluna principal (esquerda)
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Dashboard ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        // Cards de atendimentos
                        responsiveInfoCards([
                          _MedicoInfoCardOld(
                            title: 'Atendimentos do Dia',
                            value: '8',
                            color: Colors.green,
                            icon: Icons.today,
                          ),
                          _MedicoInfoCardOld(
                            title: 'Semana',
                            value: '32',
                            color: Colors.orange,
                            icon: Icons.calendar_view_week,
                          ),
                          _MedicoInfoCardOld(
                            title: 'Mês',
                            value: '120',
                            color: Colors.blue,
                            icon: Icons.calendar_month,
                          ),
                        ]),
                        SizedBox(height: 24),
                        // Classificação de risco
                        Text(
                          'Classificação de Risco',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        responsiveInfoCards([
                          _MedicoInfoCardOld(
                            title: 'Verde',
                            value: '10',
                            color: Colors.green,
                            icon: Icons.circle,
                          ),
                          _MedicoInfoCardOld(
                            title: 'Amarelo',
                            value: '0',
                            color: Colors.yellow,
                            icon: Icons.circle,
                          ),
                          _MedicoInfoCardOld(
                            title: 'Laranja',
                            value: '5',
                            color: Colors.orange,
                            icon: Icons.circle,
                          ),
                          _MedicoInfoCardOld(
                            title: 'Vermelho',
                            value: '2',
                            color: Colors.red,
                            icon: Icons.circle,
                          ),
                        ]),
                      ],
                    ),
                  ),
                  // Coluna lateral direita (acesso rápido)
                  SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 48), // Alinhar com o título
                        Text(
                          'Acesso Rápido',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 16),
                        Card(
                          elevation: 4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.grey.shade50, Colors.white],
                              ),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...atalhosCards.map(
                                  (card) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: QuickAccessCard(
                                      icon: card.icon,
                                      title: card.title,
                                      description: card.description,
                                      color: card.color,
                                      onTap: card.onTap,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}

class _MedicoInfoCardOld extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  const _MedicoInfoCardOld({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.02),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MedicoCardData {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final void Function()? onTap;
  _MedicoCardData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.onTap,
  });
}

class _MedicoAtalhoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final double height;
  final void Function()? onTap;
  const _MedicoAtalhoCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.height,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.05),
                color.withValues(alpha: 0.02),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF222222),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 11, color: Color(0xFF888888)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
