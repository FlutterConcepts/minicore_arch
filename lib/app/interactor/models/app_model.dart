import 'package:minicore_arch_example/app/shared/services/theme/app_theme_state.dart';

class AppModel {
  final AppThemeState themeState;

  AppModel({required this.themeState});

  factory AppModel.empty() => AppModel(themeState: AppThemeState.standard());

  AppModel copyWith({
    AppThemeState? themeState,
  }) {
    return AppModel(
      themeState: themeState ?? this.themeState,
    );
  }
}
