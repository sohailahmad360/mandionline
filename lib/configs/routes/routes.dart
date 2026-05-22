import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../injection/di.dart';
import '../../repository/trades_api/trades_repository.dart';
import '../../view/drawer/help_support_view.dart';
import '../../view/drawer/order_history_view.dart';
import '../../view/drawer/profile_view.dart';
import '../../view/drawer/settings_view.dart';
import '../../view/home/dashboard_list_detail_view.dart';
import '../../view/login/login_view.dart';
import '../../view/onboarding/onboarding_view.dart';
import '../../view/shell/main_shell_view.dart';
import '../../view/shell/module_placeholder_view.dart';
import '../../view/splash/splash_view.dart';
import '../../view/bargaining/bargaining_module_view.dart';
import '../../view/ledger/ledger_module_view.dart';
import '../../view/favorites/favorites_view.dart';
import '../../view/cheques/cheques_module_view.dart';
import '../../view/quotations/quotations_view.dart';
import '../../view/users/users_view.dart';
import '../../view_model/deals/deals_view_model.dart';
import '../../view_model/home/home_view_model.dart';
import '../../view_model/messages/messages_view_model.dart';
import '../../view_model/notifications/notifications_view_model.dart';
import '../../view_model/shell/shell_view_model.dart';
import '../../view_model/bargaining/bargaining_view_model.dart';
import '../../view_model/ledger/ledger_view_model.dart';
import '../../view_model/favorites/favorites_view_model.dart';
import '../../view_model/cheques/cheques_view_model.dart';
import '../../view_model/trades/trades_view_model.dart';
import 'route_arguments.dart';
import 'routes_name.dart';

class Routes {
  Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const SplashView(),
        );
      case RoutesName.onboarding:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const OnboardingView(),
        );
      case RoutesName.login:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const LoginView(),
        );
      case RoutesName.users:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const UsersView(),
        );
      case RoutesName.quotations:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const QuotationsView(),
        );
      case RoutesName.bargaining:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (_) => BargainingViewModel(),
            child: const BargainingModuleView(),
          ),
        );
      case RoutesName.ledgers:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (_) => LedgerViewModel(),
            child: const LedgerModuleView(),
          ),
        );
      case RoutesName.favorites:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (_) => FavoritesViewModel(),
            child: const FavoritesView(),
          ),
        );
      case RoutesName.cheques:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ChequesViewModel(),
            child: const ChequesModuleView(),
          ),
        );
      case RoutesName.profile:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const ProfileView(),
        );
      case RoutesName.settings:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const SettingsView(),
        );
      case RoutesName.orderHistory:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const OrderHistoryView(),
        );
      case RoutesName.helpSupport:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HelpSupportView(),
        );
      case RoutesName.dashboardListDetail:
        final args = settings.arguments as DashboardListDetailArgs?;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => DashboardListDetailView(
            kind: args?.kind ?? DashboardListKind.categories,
            tradeRowsSnapshot: args?.tradeRowsSnapshot,
          ),
        );
      case RoutesName.modulePlaceholder:
        final args = settings.arguments as ModulePlaceholderArgs?;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => ModulePlaceholderView(
            title: args?.title ?? 'Module',
          ),
        );
      case RoutesName.home:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ShellViewModel()),
              ChangeNotifierProvider(create: (_) => HomeViewModel()),
              ChangeNotifierProvider(
                create: (_) => TradesViewModel(
                  tradesRepository: getIt<TradesRepository>(),
                ),
              ),
              ChangeNotifierProvider(create: (_) => DealsViewModel()),
              ChangeNotifierProvider(create: (_) => MessagesViewModel()),
              ChangeNotifierProvider(create: (_) => NotificationsViewModel()),
            ],
            child: const MainShellView(),
          ),
        );
      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
