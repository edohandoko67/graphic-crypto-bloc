import 'package:crypto_fake/bloc/theme/theme_state.dart';

abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}
class SetTheme extends ThemeEvent {
  final AppTheme theme;
  SetTheme(this.theme);
}