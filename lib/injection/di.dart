import 'package:get_it/get_it.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../repository/auth_api/auth_repository.dart';
import '../repository/auth_api/auth_static_repository.dart';
import '../repository/trades_api/trades_http_api_repository.dart';
import '../repository/trades_api/trades_repository.dart';
import '../services/deep_link_service.dart';
import '../services/google_auth_service.dart';
import '../services/push_notification_service.dart';
import '../view_model/locale/locale_controller.dart';
import '../view_model/services/onboarding/onboarding_prefs.dart';
import '../view_model/services/session_manager/session_manager.dart';
import '../view_model/services/storage/local_storage.dart';

final GetIt getIt = GetIt.instance;

/// Composition root: register lazy singletons for repositories and shared services.
Future<void> setupDependencies() async {
  final storage = LocalStorage();
  await storage.init();

  getIt.registerLazySingleton<LocalStorage>(() => storage);
  getIt.registerLazySingleton<LocaleController>(() => LocaleController());
  getIt.registerLazySingleton<OnboardingPrefs>(() => OnboardingPrefs());
  getIt.registerLazySingleton<SessionManager>(
    () => SessionManager(localStorage: getIt<LocalStorage>()),
  );
  getIt.registerLazySingleton<BaseApiServices>(() => NetworkApiService());
  // TODO(api): replace [AuthStaticRepository] with AuthHttpApiRepository when login is wired to the backend.
  getIt.registerLazySingleton<AuthRepository>(() => AuthStaticRepository());
  getIt.registerLazySingleton<TradesRepository>(
    () => TradesHttpApiRepository(api: getIt<BaseApiServices>()),
  );
  getIt.registerLazySingleton<GoogleAuthService>(() => GoogleAuthService());
  getIt.registerLazySingleton<PushNotificationService>(
    () => PushNotificationService(),
  );
  getIt.registerLazySingleton<DeepLinkService>(() => DeepLinkService());
}
