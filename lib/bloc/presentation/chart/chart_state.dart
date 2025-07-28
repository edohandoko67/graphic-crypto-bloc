import 'package:equatable/equatable.dart';
import 'package:interactive_chart/interactive_chart.dart';

class ChartState extends Equatable {
  final List<CandleData> candles;
  final List<CandleData> candlesXRP;
  final bool loading;
  final bool darkMode;
  final bool showAverage;

  const ChartState({
    this.candles = const [],
    this.candlesXRP = const [],
    this.loading = false,
    this.darkMode = true,
    this.showAverage = false,
  });

  ChartState copyWith({
    List<CandleData>? candles,
    List<CandleData>? candlesXRP,
    bool? loading,
    bool? darkMode,
    bool? showAverage,
  }) {
    return ChartState(
      candles: candles ?? this.candles,
      candlesXRP: candlesXRP ?? this.candlesXRP,
      loading: loading ?? this.loading,
      darkMode: darkMode ?? this.darkMode,
      showAverage: showAverage ?? this.showAverage,
    );
  }

  @override
  List<Object?> get props => [candles, candlesXRP, loading, darkMode, showAverage];
}

// class OrderState {
//   final String selectedOrderType;
//
//   const OrderState({this.selectedOrderType = 'Limit Order'});
//
//   OrderState copyWith({String? selectedOrderType}) {
//     return OrderState(
//       selectedOrderType: selectedOrderType ?? this.selectedOrderType,
//     );
//   }
// }

