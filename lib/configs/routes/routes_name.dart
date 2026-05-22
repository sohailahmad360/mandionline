/// Route name constants — no magic strings in [Navigator.pushNamed].
abstract final class RoutesName {
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String home = 'home';

  static const String users = 'users';

  static const String quotations = 'quotations';

  static const String bargaining = 'bargaining';

  static const String ledgers = 'ledgers';

  static const String favorites = 'favorites';

  static const String cheques = 'cheques';

  static const String profile = 'profile';
  static const String settings = 'settings';
  static const String orderHistory = 'orderHistory';
  static const String helpSupport = 'helpSupport';

  /// Full-screen list from home “View all” (categories / offers / trades).
  static const String dashboardListDetail = 'dashboardListDetail';

  /// Drawer module not yet wired (Users, Quotations, …).
  static const String modulePlaceholder = 'modulePlaceholder';
}
