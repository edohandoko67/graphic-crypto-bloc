import 'package:interactive_chart/interactive_chart.dart';

extension CandleDataCopyWith on CandleData {
  CandleData copyWith({
    double? open,
    double? high,
    double? low,
    double? close,
    double? volume,
    int? timestamp,
    List<double>? trends,
  }) {
    return CandleData(
      open: open ?? this.open,
      high: high ?? this.high,
      low: low ?? this.low,
      close: close ?? this.close,
      volume: volume ?? this.volume,
      timestamp: timestamp ?? this.timestamp,
      trends: trends ?? this.trends,
    );
  }
}
