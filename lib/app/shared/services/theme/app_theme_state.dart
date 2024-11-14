enum ThemeType { darkTheme, lightTheme }

class AppThemeState {
  final ThemeType theme;

  const AppThemeState({required this.theme});

  factory AppThemeState.standard() {
    return const AppThemeState(theme: ThemeType.lightTheme);
  }
}
