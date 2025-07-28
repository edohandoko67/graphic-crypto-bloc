import 'dart:math';

import 'package:interactive_chart/interactive_chart.dart';

class MockDataTesla {
  static List<CandleData> get candles {
    final random = Random();
    final start = DateTime.now();
    double lastClose = 0.1;

    return List.generate(100, (index) {
      final time = start.subtract(Duration(hours: 100 - index));

      final volatility = 200 + random.nextDouble() * 1300;
      final naik = random.nextDouble() < 0.7;
      final change = (naik ? 1.0 : -1.0) * random.nextDouble() * volatility;

      final open = lastClose;
      final close = (open + change).clamp(0.01, 100000.0);
      final high = max(open, close) + random.nextDouble() * 100;
      final low = min(open, close) - random.nextDouble() * 100;
      final volume = (100 + random.nextInt(900)).toDouble();

      lastClose = close;

      return CandleData(
        timestamp: time.millisecondsSinceEpoch,
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume,
      );
    });
  }
}


class MockDataXRP {
  static List<CandleData> get candlesXRP {
    final random = Random();
    final now = DateTime.now();
    double lastClose = 0.6;

    return List.generate(100, (index) {
      final time = now.subtract(Duration(hours: 100 - index));

      final volatility = 0.01 + random.nextDouble() * 0.05;
      final naik = random.nextDouble() < 0.6;
      final change = (naik ? 1.0 : -1.0) * random.nextDouble() * volatility;

      final open = lastClose;
      final close = (open + change).clamp(0.2, 1.5);
      final high = max(open, close) + random.nextDouble() * 0.02;
      final low = min(open, close) - random.nextDouble() * 0.02;
      final volume = (1000 + random.nextInt(5000)).toDouble();

      lastClose = close;

      return CandleData(
        timestamp: time.millisecondsSinceEpoch,
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume,
      );
    });
  }
}