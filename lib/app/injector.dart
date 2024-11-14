import 'package:auto_injector/auto_injector.dart';
import 'package:minicore_arch_example/app/modules/assets_module/data/repositories/assets_repository_impl.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/repositories/assets_repository.dart';
import 'package:minicore_arch_example/app/modules/home/data/repositories/home_repository_impl.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/repositories/home_repository.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/http_client.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/uno_http_client.dart';
import 'package:minicore_arch_example/app/shared/services/local_storage/shared_preferences_service.dart';
import 'package:minicore_arch_example/app/shared/services/theme/app_theme_store.dart';
import 'package:uno/uno.dart';

final injector = AutoInjector(on: (i) {
  // services
  i.addSingleton<Uno>(Uno.new);
  i.addSingleton<HttpClient>(UnoHttpClientImpl.new);
  i.addSingleton<SharedPreferencesService>(SharedPreferencesService.new);

  // repositories
  i.add<HomeRepository>(HomeRepositoryImpl.new);
  i.add<AssetsRepository>(AssetsRepositoryImpl.new);

  // stores
  i.addSingleton<AppThemeStore>(AppThemeStore.new);
});
