import 'package:flutter/material.dart';

import '../../controllers/admin_dashboard_controller.dart';
import 'dashboard_card.dart';

class DashboardStatsCards extends StatelessWidget {
  final AdminDashboardController controller;
  final bool isMobile;

  const DashboardStatsCards({
    super.key,
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        final cards = _buildCards();

        if (isSmallScreen) {
          return _StatsCardsMobileLayout(cards: cards);
        } else if (constraints.maxWidth < 900) {
          return _StatsCardsTabletLayout(cards: cards);
        } else {
          return _StatsCardsDesktopLayout(cards: cards);
        }
      },
    );
  }

  List<DashboardCard> _buildCards() {
    return [
      DashboardCard(
        title: 'Total de alunos',
        value: controller.totalStudents.toString(),
        icon: Icons.people_outline,
        color: Colors.blue,
      ),
      DashboardCard(
        title: 'Total de cursos',
        value: controller.totalCourses.toString(),
        icon: Icons.menu_book,
        color: Colors.indigo,
      ),
      DashboardCard(
        title: 'Questionários ativos',
        value: controller.totalQuizzes.toString(),
        icon: Icons.quiz,
        color: Colors.purple,
      ),
      DashboardCard(
        title: 'Progresso médio',
        value: controller.averageProgress,
        icon: Icons.bar_chart,
        color: Colors.teal,
      ),
    ];
  }
}

class _StatsCardsDesktopLayout extends StatelessWidget {
  final List<DashboardCard> cards;

  const _StatsCardsDesktopLayout({required this.cards});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          cards
              .map(
                (card) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: card,
                  ),
                ),
              )
              .toList(),
    );
  }
}

class _StatsCardsTabletLayout extends StatelessWidget {
  final List<DashboardCard> cards;

  const _StatsCardsTabletLayout({required this.cards});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: cards[0],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: cards[1],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: cards[2],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: cards[3],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatsCardsMobileLayout extends StatelessWidget {
  final List<DashboardCard> cards;

  const _StatsCardsMobileLayout({required this.cards});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          cards
              .map(
                (card) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: card,
                ),
              )
              .toList(),
    );
  }
}
