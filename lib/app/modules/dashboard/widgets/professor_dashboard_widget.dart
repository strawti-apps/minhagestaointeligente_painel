import 'package:flutter/material.dart';

class ProfessorDashboardWidget extends StatelessWidget {
  final bool isMobile;
  const ProfessorDashboardWidget({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final alunosCards = [
      _ProfessorCardData(
        icon: Icons.people,
        title: 'Alunos do Dia',
        value: '5',
        description: 'Novos alunos hoje',
        color: Colors.green,
      ),
      _ProfessorCardData(
        icon: Icons.calendar_today,
        title: 'Semana',
        value: '20',
        description: 'Alunos na semana',
        color: Colors.orange,
      ),
      _ProfessorCardData(
        icon: Icons.date_range,
        title: 'Mês',
        value: '100',
        description: 'Alunos no mês',
        color: Colors.blue,
      ),
    ];

    final desempenhoCards = [
      _ProfessorCardData(
        icon: Icons.emoji_events,
        title: 'Ótimo',
        value: '8',
        description: 'Desempenho ótimo',
        color: Colors.green,
      ),
      _ProfessorCardData(
        icon: Icons.thumb_up,
        title: 'Bom',
        value: '10',
        description: 'Desempenho bom',
        color: Colors.blue,
      ),
      _ProfessorCardData(
        icon: Icons.trending_flat,
        title: 'Regular',
        value: '3',
        description: 'Desempenho regular',
        color: Colors.orange,
      ),
      _ProfessorCardData(
        icon: Icons.thumb_down,
        title: 'Ruim',
        value: '1',
        description: 'Desempenho ruim',
        color: Colors.red,
      ),
    ];

    final atalhosCards = [
      _ProfessorCardData(
        icon: Icons.class_,
        title: 'Turmas',
        value: '',
        description: 'Acesse suas turmas',
        color: Colors.deepPurple,
      ),
      _ProfessorCardData(
        icon: Icons.assignment,
        title: 'Provas',
        value: '',
        description: 'Gerencie provas',
        color: Colors.indigo,
      ),
      _ProfessorCardData(
        icon: Icons.people,
        title: 'Alunos',
        value: '',
        description: 'Gerencie alunos',
        color: Colors.teal,
      ),
    ];

    Widget responsiveCards(List<_ProfessorCardData> cards) {
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
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: _ProfessorCard(
                      icon: card.icon,
                      title: card.title,
                      value: card.value,
                      description: card.description,
                      color: card.color,
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
              Icon(
                Icons.school,
                size: isMobile ? 24 : 28,
                color: Colors.deepPurple,
              ),
              SizedBox(width: isMobile ? 8 : 12),
              Text(
                'Dashboard Professor',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 24),
          responsiveCards(alunosCards),
          SizedBox(height: isMobile ? 24 : 32),
          Text(
            'Desempenho dos Alunos',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          responsiveCards(desempenhoCards),
          SizedBox(height: isMobile ? 24 : 32),
          Text(
            'Acesso Rápido',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          responsiveCards(atalhosCards),
        ],
      ),
    );
  }
}

class _ProfessorCardData {
  final IconData icon;
  final String title;
  final String value;
  final String description;
  final Color color;
  _ProfessorCardData({
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
    required this.color,
  });
}

class _ProfessorCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String description;
  final Color color;

  const _ProfessorCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
    required this.color,
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.13),
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
            if (value.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                  letterSpacing: -1,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 4),
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
