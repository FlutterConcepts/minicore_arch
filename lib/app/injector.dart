import 'package:auto_injector/auto_injector.dart';
import 'package:minicore_arch_example/app/modules/assets_module/data/repositories/assets_repository.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/repositories/i_assets_repository.dart';
import 'package:minicore_arch_example/app/modules/home/data/repositories/home_repository.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/repositories/i_home_repository.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/i_http_client.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/uno_http_client.dart';
import 'package:minicore_arch_example/app/shared/services/local_storage/shared_preferences_service.dart';
import 'package:minicore_arch_example/app/shared/services/theme/app_theme_store.dart';
import 'package:uno/uno.dart';

final injector = AutoInjector(on: (i) {
  // services
  i.addSingleton<Uno>(Uno.new);
  i.addSingleton<IHttpClient>(UnoHttpClient.new);
  i.addSingleton<SharedPreferencesService>(SharedPreferencesService.new);

  // repositories
  i.add<IHomeRepository>(HomeRepository.new);
  i.add<IAssetsRepository>(AssetsRepository.new);

  // stores
  i.addSingleton<AppThemeStore>(AppThemeStore.new);
});
