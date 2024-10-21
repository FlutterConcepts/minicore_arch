// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:minicore_arch_example/app/shared/services/theme/theme_app_state.dart';

class AppState {
  final ThemeAppState themeState;

  AppState({required this.themeState});

  factory AppState.empty() => AppState(themeState: ThemeAppState.initState());

  AppState copyWith({
    ThemeAppState? themeState,
  }) {
    return AppState(
      themeState: themeState ?? this.themeState,
    );
  }
}
