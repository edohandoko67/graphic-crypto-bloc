import 'package:crypto_fake/bloc/presentation/datacust/datacust_event.dart';
import 'package:crypto_fake/bloc/presentation/datacust/datacust_state.dart';
import 'package:crypto_fake/data/services/AuthService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataCustBloc extends Bloc<DataCustEvent, DataCustState> {
  final AuthService authService;

  DataCustBloc(this.authService) : super(const DataCustState()) {
    on<LoadDataCust>(_onLoadDataCust);
    on<RefreshDataCust>(_onRefreshDataCust);
  }

  Future<void> _onLoadDataCust(
      LoadDataCust event,
      Emitter<DataCustState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final customers = await authService.dataCust();
      emit(state.copyWith(
        customers: customers,
        isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> _onRefreshDataCust(
      RefreshDataCust event,
      Emitter<DataCustState> emit,
      ) async {
    if (!state.isLoading) {
      await _onLoadDataCust(LoadDataCust(), emit);
    }
  }
}