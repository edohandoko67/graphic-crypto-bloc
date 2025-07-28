import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MAChart extends StatelessWidget {
  final List<double?> ma7;
  final List<double?> ma30;
  final List<double?> ma90;

  const MAChart({
    super.key,
    required this.ma7,
    required this.ma30,
    required this.ma90,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          _buildLine(ma7, Colors.blue),
          _buildLine(ma30, Colors.orange),
          _buildLine(ma90, Colors.red),
        ],
        titlesData: const FlTitlesData(show: false),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  LineChartBarData _buildLine(List<double?> ma, Color color) {
    final spots = <FlSpot>[];
    for (int i = 0; i < ma.length; i++) {
      final y = ma[i];
      if (y != null) {
        spots.add(FlSpot(i.toDouble(), y));
      }
    }
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
    );
  }
}
