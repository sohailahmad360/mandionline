/// Temporary **static** login credentials for development.
///
/// Replace with real API auth: register [AuthHttpApiRepository] in [setupDependencies]
/// and remove [AuthStaticRepository] / this file when the backend is ready.
abstract final class StaticAuthConfig {
  static const String demoEmail = 'azhar@punjabistore.pk';
  static const String demoPassword = 'password123';

  /// Value written to secure storage as the session token for the demo user.
  static const String demoSessionToken = 'demo_static_session';
}
