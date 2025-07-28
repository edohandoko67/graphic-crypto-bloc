import 'package:interactive_chart/interactive_chart.dart';

CandleData cloneCandleWithTrends(CandleData candle, List<double?> trends) {
  return CandleData(
    timestamp: candle.timestamp,
    open: candle.open,
    high: candle.high,
    low: candle.low,
    close: candle.close,
    volume: candle.volume,
    trends: trends,
  );
}
