import 'demo_notification_kind.dart';

/// One row in the notifications list.
class AppNotification {
  AppNotification({
    required this.id,
    required this.kind,
    required this.createdAt,
    this.read = false,
  });

  final String id;
  final DemoNotificationKind kind;
  final DateTime createdAt;
  bool read;
}
