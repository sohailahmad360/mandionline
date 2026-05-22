import 'package:flutter/widgets.dart';
import 'package:mandionline/l10n/app_localizations.dart';

String localizedTradeSide(BuildContext context, String side) {
  final l = AppLocalizations.of(context)!;
  switch (side.toUpperCase()) {
    case 'SELLING':
      return l.tradeBadgeSelling;
    case 'BUYING':
      return l.tradeBadgeBuying;
    default:
      return side;
  }
}

String localizedRowStatus(BuildContext context, String label) {
  final l = AppLocalizations.of(context)!;
  switch (label.toLowerCase()) {
    case 'active':
      return l.statusActive;
    case 'pending':
      return l.statusPending;
    case 'completed':
      return l.statusCompleted;
    default:
      return label;
  }
}
