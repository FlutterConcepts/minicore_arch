// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:minicore_arch_example/app/shared/services/theme/app_theme_state.dart';

class AppState {
  final AppThemeState themeState;

  AppState({required this.themeState});

  factory AppState.empty() => AppState(themeState: AppThemeState.initState());

  AppState copyWith({
    AppThemeState? themeState,
  }) {
    return AppState(
      themeState: themeState ?? this.themeState,
    );
  }
}
