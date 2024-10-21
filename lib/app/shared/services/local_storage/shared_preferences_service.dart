import 'package:minicore_arch_example/app/shared/services/local_storage/preferences_key_strings.dart';
import 'package:minicore_arch_example/app/shared/services/theme/app_theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> saveAppTheme({required ThemeType theme}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kThemePrefsKey, theme.name);
  }

  Future<String?> getAppTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kThemePrefsKey);
  }
}
