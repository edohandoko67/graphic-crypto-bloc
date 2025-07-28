import 'package:crypto_fake/data/models/datacust/datacustmodel.dart';
import 'package:equatable/equatable.dart';

class DataCustState extends Equatable {
  final List<DataCustModel> customers;
  final bool isLoading;
  final String? error;

  const DataCustState({
    this.customers = const [],
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [customers, isLoading, error];

  DataCustState copyWith({
    List<DataCustModel>? customers,
    bool? isLoading,
    String? error,
  }) {
    return DataCustState(
      customers: customers ?? this.customers,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get hasError => error != null;
  bool get isEmpty => customers.isEmpty;
  bool get hasData => customers.isNotEmpty;
}