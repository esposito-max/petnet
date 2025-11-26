import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ImpactPieChart extends StatelessWidget {
  const ImpactPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // The text in the middle
        const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Percent', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text('75', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ],
        ),
        // The Chart
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 60, // Creates the "donut" hole
              startDegreeOffset: -90,
              sections: [
                // The filled part (75%)
                PieChartSectionData(
                  color: const Color(0xFF508CBB),
                  value: 75,
                  showTitle: false,
                  radius: 15,
                ),
                // The empty part (25%) - subtle gradient effect in design, here simplified
                PieChartSectionData(
                  color: const Color(0xFF60D67A).withOpacity(0.3),
                  value: 25,
                  showTitle: false,
                  radius: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}