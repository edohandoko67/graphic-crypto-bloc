import 'package:fl_chart/fl_chart.dart';

class WalletLine {
  final String symbol;
  final List<FlSpot> spots;
  final int colorCode;

  WalletLine({
    required this.symbol,
    required this.spots,
    required this.colorCode,
  });
}