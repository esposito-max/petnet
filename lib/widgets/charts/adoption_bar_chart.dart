import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AdoptionBarChart extends StatelessWidget {
  const AdoptionBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the bar color based on your design (blue-ish)
    const Color barColor = Color(0xFF508CBB);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
        // Hide the borders/grid lines to match the clean design
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(color: Colors.grey, fontSize: 12);
                String text;
                switch (value.toInt()) {
                  case 0: text = 'Jan'; break;
                  case 1: text = 'Fev'; break;
                  case 2: text = 'Mar'; break;
                  case 3: text = 'Abr'; break;
                  case 4: text = 'Mai'; break;
                  case 5: text = 'Jun'; break;
                  default: text = '';
                }
                return SideTitleWidget(axisSide: meta.axisSide, child: Text(text, style: style));
              },
            ),
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: false), // Hide grid lines
        barGroups: [
          _makeGroupData(0, 8, barColor),
          _makeGroupData(1, 12, barColor),
          _makeGroupData(2, 18, barColor), // The tallest one
          _makeGroupData(3, 12, barColor),
          _makeGroupData(4, 6, barColor),
          _makeGroupData(5, 8, barColor),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 20, // Width of the bars
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }
}