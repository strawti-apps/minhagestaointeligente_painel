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
      return LayoutBuilder(
        builder: (context, constraints) {
          double localCardWidth =
              isMobile ? (constraints.maxWidth / 2) - 14 : 200;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                cards.map((card) {
                  return SizedBox(
                    width: localCardWidth,
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: card,
                  );
                }).toList(),
          );
        },
      );
    }

    Widget responsiveAtalhosCards(List<_MedicoCardData> cards) {
      return LayoutBuilder(
        builder: (context, constraints) {
          double localCardWidth =
              isMobile ? (constraints.maxWidth / 2) - 14 : 200;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                cards.map((card) {
                  return SizedBox(
                    width: localCardWidth,
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: _MedicoAtalhoCard(
                      icon: card.icon,
                      title: card.title,
                      description: card.description,
                      color: card.color,
                      height: cardHeight,
                    ),
                  );
                }).toList(),
          );
        },
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 12 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Dashboard ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 24),
          // Cards de atendimentos (layout antigo, só muda cor)
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
          SizedBox(height: isMobile ? 16 : 24),
          // Classificação de risco (layout antigo, só muda cor)
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
          SizedBox(height: isMobile ? 24 : 32),
          if (!isMobile) ...[
            Text(
              'Acesso Rápido',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...atalhosCards.map(
                      (card) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
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
          ] else ...[
            // Para mobile, manter na parte inferior
            Text(
              'Acesso Rápido',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            responsiveAtalhosCards(atalhosCards),
          ],
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
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.13),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color(0xFF222222),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
