
import 'package:crypto_fake/bloc/presentation/home/home_event.dart';
import 'package:crypto_fake/bloc/presentation/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadHomeData>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(milliseconds: 800));
      emit(state.copyWith(isLoading: false));
    });

    on<IsVisible>((event, emit) {
      emit(state.copyWith(isVisible: !state.isVisible));
    });

    on<RefreshDataMe>((event, emit) {
      // bisa isi logic refresh
    });

  }
}

