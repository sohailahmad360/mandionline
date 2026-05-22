import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../view_model/locale/locale_controller.dart';
import '../../view_model/notifications/notifications_view_model.dart';
import '../../view_model/shell/shell_view_model.dart';
import '../../view_model/trades/trades_view_model.dart';
import '../deals/deals_tab_view.dart';
import '../home/dashboard_tab_view.dart';
import '../messages/messages_tab_view.dart';
import '../notifications/notifications_view.dart';
import '../trades/create_trade_view.dart';
import '../trades/trades_tab_view.dart';
import 'widgets/mandi_app_bar.dart';
import 'widgets/mandi_bottom_nav.dart';
import 'widgets/mandi_drawer.dart';

class MainShellView extends StatefulWidget {
  const MainShellView({super.key});

  @override
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.watch<LocaleController>();
    final shell = context.watch<ShellViewModel>();
    final notif = context.watch<NotificationsViewModel>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.screenBackground,
      drawer: MandiDrawer(),
      appBar: MandiAppBar(
        onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
        onOpenNotifications: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ChangeNotifierProvider<NotificationsViewModel>.value(
                value: context.read<NotificationsViewModel>(),
                child: const NotificationsView(),
              ),
            ),
          );
        },
        notificationUnreadCount: notif.unreadCount,
      ),
      body: IndexedStack(
        index: shell.currentIndex,
        children: [
          DashboardTabView(),
          TradesTabView(),
          DealsTabView(),
          MessagesTabView(),
        ],
      ),
      floatingActionButton: shell.currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                final tradesVm = context.read<TradesViewModel>();
                final messenger = ScaffoldMessenger.of(context);
                final l10n = AppLocalizations.of(context)!;
                const tradesTabIndex = 1;
                Navigator.of(context)
                    .push<bool>(
                  MaterialPageRoute<bool>(
                    builder: (_) =>
                        ChangeNotifierProvider<TradesViewModel>.value(
                      value: tradesVm,
                      child: const CreateTradeView(),
                    ),
                  ),
                )
                    .then((published) {
                  if (!context.mounted) return;
                  if (published != true) return;
                  context.read<ShellViewModel>().setIndex(
                        tradesTabIndex,
                        allowReselect: true,
                      );
                  messenger.showSnackBar(
                    SnackBar(content: Text(l10n.createTradeSuccess)),
                  );
                });
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: MandiBottomNav(
        currentIndex: shell.currentIndex,
        onSelect: (i) => context.read<ShellViewModel>().setIndex(i),
      ),
    );
  }
}
