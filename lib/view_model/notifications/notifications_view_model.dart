import 'package:flutter/foundation.dart';

import '../../model/notification/app_notification.dart';
import '../../model/notification/demo_notification_kind.dart';

class NotificationsViewModel extends ChangeNotifier {
  NotificationsViewModel() {
    final now = DateTime.now();
    _items.addAll([
      AppNotification(
        id: 'n1',
        kind: DemoNotificationKind.dealUpdate,
        createdAt: now.subtract(const Duration(minutes: 12)),
      ),
      AppNotification(
        id: 'n2',
        kind: DemoNotificationKind.newMessage,
        createdAt: now.subtract(const Duration(hours: 1)),
        read: true,
      ),
      AppNotification(
        id: 'n3',
        kind: DemoNotificationKind.payment,
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      AppNotification(
        id: 'n4',
        kind: DemoNotificationKind.shipment,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      AppNotification(
        id: 'n5',
        kind: DemoNotificationKind.reminder,
        createdAt: now.subtract(const Duration(days: 2)),
        read: true,
      ),
    ]);
  }

  final List<AppNotification> _items = [];

  List<AppNotification> get items => List.unmodifiable(_items);

  int get unreadCount => _items.where((e) => !e.read).length;

  void markRead(String id) {
    final i = _items.indexWhere((e) => e.id == id);
    if (i < 0) return;
    if (!_items[i].read) {
      _items[i].read = true;
      notifyListeners();
    }
  }

  void markAllRead() {
    var changed = false;
    for (final n in _items) {
      if (!n.read) {
        n.read = true;
        changed = true;
      }
    }
    if (changed) notifyListeners();
  }
}
