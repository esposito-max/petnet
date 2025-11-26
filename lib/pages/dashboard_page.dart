// lib/pages/dashboard_page.dart

import 'package:flutter/material.dart';
import '../models/user_type.dart';
import '../widgets/charts/adoption_bar_chart.dart'; // Reusing the visual chart
import '../widgets/charts/impact_pie_chart.dart'; // Reusing the visual chart

class DashboardPage extends StatelessWidget {
  final UserType userType;

  const DashboardPage({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNGO = userType == UserType.ngo;

    // --- Dynamic Labels based on User Type ---
    final String chartTitle = isNGO ? 'Adoções' : 'Vendas Mensais';
    
    final String card1Title = isNGO ? 'Número de adoções' : 'Vendas realizadas';
    final String card1Value = isNGO ? '+ 16' : '+ 42';
    final String card1Sub = isNGO ? '+8% ano passado' : '+12% mês passado';

    final String card2Title = isNGO ? 'Doações recebidas' : 'Faturamento';
    final String card2Value = isNGO ? 'R\$ 12.500' : 'R\$ 8.450'; // Example values
    final String card2Sub = isNGO ? '+11% ano passado' : '+5% mês passado';

    final String card3Title = isNGO ? 'Engajamento' : 'Novos Clientes';
    final String card3Value = isNGO ? 'v 4%' : '+ 15';
    final String card3Sub = isNGO ? '-7% ano passado' : 'Essa semana';
    final bool card3Positive = !isNGO; // Negative for NGO engagement example, positive for new clients

    return ListView(
      padding: const EdgeInsets.all(32.0),
      children: [
        // --- Header ---
        Text('Dashboard', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          isNGO 
            ? 'Acompanhe os resultados da sua Organização com o nosso sistema de impacto.'
            : 'Acompanhe o desempenho de vendas e crescimento do seu negócio.',
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),

        // --- Filters ---
        Row(
          children: [
            const Text('Filtros', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Text('Período: ', style: TextStyle(color: Colors.green)),
                  Text('Últimos 6 meses', style: TextStyle(fontWeight: FontWeight.bold)),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18)
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline, color: Colors.green),
              tooltip: 'Adicionar filtro',
            )
          ],
        ),
        const SizedBox(height: 32),

        // --- Key Metrics (Summary Cards) ---
        // Use Wrap for responsiveness
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: [
            _buildSummaryCard(
              context,
              title: card1Title,
              value: card1Value,
              percentage: card1Sub,
              isPositive: true,
            ),
            _buildSummaryCard(
              context,
              title: card2Title,
              value: card2Value,
              percentage: card2Sub,
              isPositive: true,
            ),
            _buildSummaryCard(
              context,
              title: card3Title,
              value: card3Value,
              percentage: card3Sub,
              isPositive: card3Positive,
            ),
          ],
        ),

        const SizedBox(height: 40),

        // --- Charts Section ---
        Text(chartTitle, style: theme.textTheme.titleLarge),
        const SizedBox(height: 24),
        
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 300, 
                      child: AdoptionBarChart(), // We reuse the bar chart logic
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 300,
                      child: ImpactPieChart(), // We reuse the pie chart logic
                    ),
                  ),
                ],
              );
            } else {
              return const Column(
                children: [
                  SizedBox(
                    height: 250, 
                    child: AdoptionBarChart(),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 250, 
                    child: ImpactPieChart(),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  // Helper widget for the top cards
  Widget _buildSummaryCard(BuildContext context, {
    required String title,
    required String value,
    required String percentage,
    required bool isPositive,
  }) {
    return Container(
      width: 280, 
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          const SizedBox(height: 12),
          Text(
            value, 
            style: TextStyle(
              fontSize: 32, 
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green : const Color(0xFFEA5B6A) // Green or Pink/Red
            ),
          ),
          const SizedBox(height: 8),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}