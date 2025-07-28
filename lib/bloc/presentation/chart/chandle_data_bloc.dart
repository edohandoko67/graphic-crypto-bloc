
import 'package:crypto_fake/bloc/presentation/chart/chart_event.dart';
import 'package:crypto_fake/bloc/presentation/chart/chart_state.dart';
import 'package:crypto_fake/extensions/candle_data_extension.dart';
import 'package:crypto_fake/mock_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_chart/interactive_chart.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartBloc() : super(const ChartState()) {
    on<LoadChartData>(_onLoadData);
    on<ToggleDarkMode>(_onToggleDarkMode);
    on<ToggleAverage>(_onToggleAverage);
  }

  void _onLoadData(LoadChartData event, Emitter<ChartState> emit) async {
    emit(state.copyWith(loading: true));
    await Future.delayed(const Duration(milliseconds: 300));

    final candles = MockDataTesla.candles;
    final candlesXRP = MockDataXRP.candlesXRP;
    emit(state.copyWith(candles: candles, candlesXRP: candlesXRP, loading: false));
  }

  void _onToggleDarkMode(ToggleDarkMode event, Emitter<ChartState> emit) {
    emit(state.copyWith(darkMode: !state.darkMode));
  }

  void _onToggleAverage(ToggleAverage event, Emitter<ChartState> emit) {
    final show = !state.showAverage;

    final candles = List<CandleData>.from(state.candles);
    final candlesXRP = List<CandleData>.from(state.candlesXRP);

    if (show) {
      // BTC averages
      final ma7 = CandleData.computeMA(candles, 7);
      final ma30 = CandleData.computeMA(candles, 30);
      final ma90 = CandleData.computeMA(candles, 90);

      for (int i = 0; i < candles.length; i++) {
        candles[i] = candles[i].copyWith(
          trends: [ma7[i] ?? 0, ma30[i] ?? 0, ma90[i] ?? 0],
        );
      }

      // XRP averages
      final ma7x = CandleData.computeMA(candlesXRP, 7);
      final ma30x = CandleData.computeMA(candlesXRP, 30);
      final ma90x = CandleData.computeMA(candlesXRP, 90);

      for (int i = 0; i < candlesXRP.length; i++) {
        candlesXRP[i] = candlesXRP[i].copyWith(
          trends: [ma7x[i] ?? 0, ma30x[i] ?? 0, ma90x[i] ?? 0],
        );
      }
    } else {
      for (int i = 0; i < candles.length; i++) {
        candles[i] = candles[i].copyWith(trends: []);
      }
      for (int i = 0; i < candlesXRP.length; i++) {
        candlesXRP[i] = candlesXRP[i].copyWith(trends: []);
      }
    }

    emit(state.copyWith(
      showAverage: show,
      candles: candles,
      candlesXRP: candlesXRP,
    ));
  }
}

// class OrderBloc extends Bloc<OrderEvent, OrderState> {
//   OrderBloc() : super(const OrderState()) {
//     on<SelectOrderType>((event, emit) {
//       emit(state.copyWith(selectedOrderType: event.orderType));
//     });
//   }
// }