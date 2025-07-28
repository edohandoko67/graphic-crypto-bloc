import 'package:crypto_fake/bloc/theme/theme_event.dart';
import 'package:crypto_fake/bloc/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(): super(ThemeState()) {
    on<ToggleTheme>(_onToggleTheme);
    on<SetTheme>(_onSetTheme);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
        theme: state.theme == AppTheme.light ? AppTheme.dark : AppTheme.light
    ));
  }

  void _onSetTheme(SetTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(theme: event.theme));
  }
}