import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'configs/app_globals.dart';
import 'configs/app_url.dart';
import 'configs/color/app_colors.dart';
import 'configs/routes/routes.dart';
import 'configs/routes/routes_name.dart';
import 'injection/di.dart';
import 'view_model/locale/locale_controller.dart';
import 'view_model/services/storage/local_storage.dart';
import 'view_model/splash/splash_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: 'assets/env/.env');
  } catch (_) {
    // Asset missing in tests or misconfigured build — fall back to default URL.
  }
  final fromEnv = dotenv.env['BASE_URL']?.trim();
  if (fromEnv != null && fromEnv.isNotEmpty) {
    AppUrl.baseUrl = fromEnv;
  }
  await setupDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplashViewModel(
            localStorage: getIt<LocalStorage>(),
          ),
        ),
        ChangeNotifierProvider<LocaleController>.value(
          value: getIt<LocaleController>(),
        ),
      ],
      child: const MandionlineApp(),
    ),
  );
}

class MandionlineApp extends StatelessWidget {
  const MandionlineApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleController>();
    return MaterialApp(
      navigatorKey: appNavigatorKey,
      title: 'Mandi Online',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.surface,
        ),
        scaffoldBackgroundColor: AppColors.screenBackground,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale.locale,
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
