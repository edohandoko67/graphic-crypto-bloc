import 'package:equatable/equatable.dart';

abstract class ChartEvent extends Equatable {
  const ChartEvent();
  @override
  List<Object> get props => [];
}

class LoadChartData extends ChartEvent {}

class ToggleDarkMode extends ChartEvent {}

class ToggleAverage extends ChartEvent {}

// abstract class OrderEvent {}
//
// class SelectOrderType extends OrderEvent {
//   final String orderType;
//   SelectOrderType(this.orderType);
// }