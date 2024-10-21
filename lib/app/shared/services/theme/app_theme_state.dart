enum ThemeType { darkTheme, lightTheme }

class AppThemeState {
  final ThemeType theme;

  const AppThemeState({required this.theme});

  factory AppThemeState.initState() {
    return const AppThemeState(theme: ThemeType.lightTheme);
  }
}
