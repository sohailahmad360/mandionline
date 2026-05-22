import 'package:mandionline/l10n/app_localizations.dart';
import 'package:mandionline/model/notification/demo_notification_kind.dart';

class DemoNotificationCopy {
  const DemoNotificationCopy(this.title, this.body);
  final String title;
  final String body;
}

DemoNotificationCopy demoNotificationCopy(
  AppLocalizations l,
  DemoNotificationKind k,
) {
  switch (k) {
    case DemoNotificationKind.dealUpdate:
      return DemoNotificationCopy(l.notifDealUpdateTitle, l.notifDealUpdateBody);
    case DemoNotificationKind.newMessage:
      return DemoNotificationCopy(l.notifNewMessageTitle, l.notifNewMessageBody);
    case DemoNotificationKind.payment:
      return DemoNotificationCopy(l.notifPaymentTitle, l.notifPaymentBody);
    case DemoNotificationKind.shipment:
      return DemoNotificationCopy(l.notifShipmentTitle, l.notifShipmentBody);
    case DemoNotificationKind.reminder:
      return DemoNotificationCopy(l.notifReminderTitle, l.notifReminderBody);
  }
}
