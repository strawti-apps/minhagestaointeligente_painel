import 'package:flutter/material.dart';

class AdminDashboardMockWidget extends StatelessWidget {
  final bool isMobile;
  const AdminDashboardMockWidget({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    // Cards separados por seção
    final List<_DashboardCardData> educacaoCards = [
      _DashboardCardData(
        icon: Icons.apartment,
        title: 'Escolas',
        value: '3',
        description: 'Total de escolas',
        color: Colors.blue,
      ),
      _DashboardCardData(
        icon: Icons.person,
        title: 'Professores',
        value: '12',
        description: 'Total de professores',
        color: Colors.deepPurple,
      ),
      _DashboardCardData(
        icon: Icons.people,
        title: 'Alunos',
        value: '200',
        description: 'Total de alunos',
        color: Colors.green,
      ),
      _DashboardCardData(
        icon: Icons.check,
        title: '% Presença Alunos',
        value: '92%',
        description: 'Presença dos alunos',
        color: Colors.teal,
      ),
      _DashboardCardData(
        icon: Icons.check_circle,
        title: '% Presença Professores',
        value: '95%',
        description: 'Presença dos professores',
        color: Colors.indigo,
      ),
      _DashboardCardData(
        icon: Icons.grade,
        title: 'Média Nota',
        value: '7.8',
        description: 'Nota média por matéria',
        color: Colors.orange,
      ),
    ];
    final List<_DashboardCardData> saudeCards = [
      _DashboardCardData(
        icon: Icons.local_hospital,
        title: 'Atendimentos',
        value: '120',
        description: 'Atendimentos realizados',
        color: Colors.red,
      ),
      _DashboardCardData(
        icon: Icons.healing,
        title: 'Cirurgias',
        value: '8',
        description: 'Cirurgias realizadas',
        color: Colors.pink,
      ),
      _DashboardCardData(
        icon: Icons.person_outline,
        title: 'Pacientes',
        value: '90',
        description: 'Total de pacientes',
        color: Colors.blueGrey,
      ),
      _DashboardCardData(
        icon: Icons.circle,
        title: 'Risco Verde',
        value: '70%',
        description: 'Classificação de risco',
        color: Colors.green,
      ),
      _DashboardCardData(
        icon: Icons.circle,
        title: 'Risco Laranja',
        value: '20%',
        description: 'Classificação de risco',
        color: Colors.orange,
      ),
      _DashboardCardData(
        icon: Icons.circle,
        title: 'Risco Vermelho',
        value: '10%',
        description: 'Classificação de risco',
        color: Colors.red,
      ),
    ];
    final List<_DashboardCardData> socialCards = [
      _DashboardCardData(
        icon: Icons.post_add,
        title: 'Posts',
        value: '50',
        description: 'Total de posts',
        color: Colors.blue,
      ),
      _DashboardCardData(
        icon: Icons.comment,
        title: 'Comentários',
        value: '120',
        description: 'Total de comentários',
        color: Colors.deepPurple,
      ),
      _DashboardCardData(
        icon: Icons.thumb_up,
        title: 'Curtidas',
        value: '300',
        description: 'Total de curtidas',
        color: Colors.green,
      ),
      _DashboardCardData(
        icon: Icons.share,
        title: 'Compartilhamentos',
        value: '40',
        description: 'Total de compartilhamentos',
        color: Colors.orange,
      ),
    ];

    int crossAxisCount =
        isMobile
            ? 2
            : (MediaQuery.of(context).size.width > 1200
                ? 5
                : MediaQuery.of(context).size.width > 900
                ? 4
                : 3);
    double cardHeight = isMobile ? 100 : 120;
    double aspectRatio = isMobile ? 1.1 : 1.25;

    Widget section(String title, List<_DashboardCardData> cards) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              double cardWidth =
                  isMobile ? (constraints.maxWidth / 2) - 14 : 220;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children:
                    cards.map((card) {
                      return SizedBox(
                        width: cardWidth,
                        height: MediaQuery.of(context).size.height * 0.28,
                        child: _DashboardCard(
                          icon: card.icon,
                          title: card.title,
                          value: card.value,
                          description: card.description,
                          color: card.color,
                          height: cardHeight,
                        ),
                      );
                    }).toList(),
              );
            },
          ),
        ],
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
                Icons.dashboard,
                size: isMobile ? 24 : 28,
                color: Colors.deepPurple,
              ),
              SizedBox(width: isMobile ? 8 : 12),
              Text(
                'Painel Geral',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 24),
          section('Educação', educacaoCards),
          SizedBox(height: isMobile ? 24 : 32),
          section('Saúde', saudeCards),
          SizedBox(height: isMobile ? 24 : 32),
          section('Social', socialCards),
        ],
      ),
    );
  }
}

class _DashboardCardData {
  final IconData icon;
  final String title;
  final String value;
  final String description;
  final Color color;
  _DashboardCardData({
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
    required this.color,
  });
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String description;
  final Color color;
  final double height;
  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
    required this.color,
    required this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200, width: 0.5),
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
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
                letterSpacing: -1,
              ),
              textAlign: TextAlign.center,
            ),
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
