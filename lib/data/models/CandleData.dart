class CandleData {
  final int timestamp;
  final double open;
  final double close;
  final double high;
  final double low;
  final double volume;
  List<double> trends;

  CandleData({
    required this.timestamp,
    required this.open,
    required this.close,
    required this.high,
    required this.low,
    this.volume = 0,
    this.trends = const [],
  });

  factory CandleData.fromDateTime({
    required DateTime time,
    required double open,
    required double close,
    required double high,
    required double low,
    double volume = 0,
  }) {
    return CandleData(
      timestamp: time.millisecondsSinceEpoch,
      open: open,
      close: close,
      high: high,
      low: low,
      volume: volume,
    );
  }
}
extension CandleMA on CandleData {
  static List<double?> computeMA(List<CandleData> data, int period) {
    final List<double?> ma = List.filled(data.length, null);
    for (int i = period - 1; i < data.length; i++) {
      double sum = 0.0;
      for (int j = i - period + 1; j <= i; j++) {
        sum += data[j].close;
      }
      ma[i] = sum / period;
    }
    return ma;
  }
}


