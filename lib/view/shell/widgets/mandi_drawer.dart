import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../configs/color/app_colors.dart';
import '../../../configs/components/safe_network_image.dart';
import '../../../configs/demo_media_urls.dart';
import '../../../configs/routes/routes_name.dart';
import '../../../injection/di.dart';
import '../../../view_model/services/session_manager/session_manager.dart';
import '../../../view_model/services/storage/local_storage.dart';
import '../../../view_model/shell/shell_view_model.dart';

class MandiDrawer extends StatefulWidget {
  const MandiDrawer({super.key});

  @override
  State<MandiDrawer> createState() => _MandiDrawerState();
}

class _MandiDrawerState extends State<MandiDrawer> {
  late final Future<_ProfileSnap> _profileFuture = _loadProfile();

  Future<_ProfileSnap> _loadProfile() async {
    final s = getIt<LocalStorage>();
    final guest = await s.isGuestUser();
    final name = await s.readProfileName();
    return _ProfileSnap(isGuest: guest, profileName: guest ? null : name);
  }

  void _goTab(int index) {
    final shell = context.read<ShellViewModel>();
    Navigator.pop(context);
    shell.setIndex(index);
  }

  void _openNamed(String routeName) {
    final nav = Navigator.of(context);
    Navigator.pop(context);
    nav.pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final shell = context.watch<ShellViewModel>();
    final tab = shell.currentIndex;

    return Drawer(
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: SafeArea(
        child: FutureBuilder<_ProfileSnap>(
          future: _profileFuture,
          builder: (context, snap) {
            final p = snap.data;
            final name = p == null
                ? l10n.drawerUserDefault
                : (p.isGuest
                    ? l10n.drawerGuest
                    : (p.profileName ?? l10n.demoProfileName));
            final subtitle = p?.isGuest == true
                ? l10n.drawerBrowsingGuest
                : l10n.demoStoreSubtitle;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DrawerHeader(
                  name: name,
                  subtitle: subtitle,
                  isGuest: p?.isGuest ?? true,
                  onClose: () => Navigator.pop(context),
                  onOpenProfile: () {
                    final nav = Navigator.of(context);
                    Navigator.pop(context);
                    nav.pushNamed(RoutesName.profile);
                  },
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                    children: [
                      _DrawerNavRow(
                        icon: Icons.home_outlined,
                        label: l10n.navHome,
                        selected: tab == 0,
                        onTap: () => _goTab(0),
                      ),
                      _DrawerNavRow(
                        icon: Icons.people_outline,
                        label: l10n.drawerItemUsers,
                        badge: 2,
                        onTap: () => _openNamed(RoutesName.users),
                      ),
                      _DrawerNavRow(
                        icon: Icons.work_outline,
                        label: l10n.navTrades,
                        badge: 3,
                        selected: tab == 1,
                        onTap: () => _goTab(1),
                      ),
                      _DrawerNavRow(
                        icon: Icons.description_outlined,
                        label: l10n.drawerItemQuotations,
                        onTap: () => _openNamed(RoutesName.quotations),
                      ),
                      _DrawerNavRow(
                        icon: Icons.handshake_outlined,
                        label: l10n.navDeals,
                        selected: tab == 2,
                        onTap: () => _goTab(2),
                      ),
                      _DrawerNavRow(
                        icon: Icons.local_offer_outlined,
                        label: l10n.drawerItemBargaining,
                        badge: 2,
                        onTap: () => _openNamed(RoutesName.bargaining),
                      ),
                      _DrawerNavRow(
                        icon: Icons.menu_book_outlined,
                        label: l10n.drawerItemLedgers,
                        badge: 7,
                        onTap: () => _openNamed(RoutesName.ledgers),
                      ),
                      _DrawerNavRow(
                        icon: Icons.receipt_long_outlined,
                        label: l10n.drawerItemCheques,
                        onTap: () => _openNamed(RoutesName.cheques),
                      ),
                      _DrawerNavRow(
                        icon: Icons.chat_bubble_outline,
                        label: l10n.navMessages,
                        badge: 12,
                        selected: tab == 3,
                        onTap: () => _goTab(3),
                      ),
                      _DrawerNavRow(
                        icon: Icons.favorite_border,
                        label: l10n.drawerItemFavorites,
                        onTap: () => _openNamed(RoutesName.favorites),
                      ),
                      _DrawerNavRow(
                        icon: Icons.settings_outlined,
                        label: l10n.drawerSettings,
                        onTap: () => _openNamed(RoutesName.settings),
                      ),
                      _DrawerNavRow(
                        icon: Icons.help_outline,
                        label: l10n.drawerHelp,
                        onTap: () => _openNamed(RoutesName.helpSupport),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 4, 10, 12),
                  child: _LogoutCard(
                    label: l10n.drawerLogout,
                    onTap: () async {
                      Navigator.pop(context);
                      await getIt<SessionManager>().logout();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProfileSnap {
  const _ProfileSnap({required this.isGuest, this.profileName});
  final bool isGuest;
  final String? profileName;
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    required this.name,
    required this.subtitle,
    required this.isGuest,
    required this.onClose,
    required this.onOpenProfile,
  });

  final String name;
  final String subtitle;
  final bool isGuest;
  final VoidCallback onClose;
  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 44, 20),
            child: InkWell(
              onTap: onOpenProfile,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: isGuest
                          ? Container(
                              width: 64,
                              height: 64,
                              color: Colors.white.withValues(alpha: 0.2),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 34,
                              ),
                            )
                          : SafeNetworkImage(
                              url: DemoMediaUrls.avatar,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.88),
                              fontSize: 13,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerNavRow extends StatelessWidget {
  const _DrawerNavRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.badge,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    final iconBg = selected ? AppColors.drawerSelectedGreen : AppColors.drawerIconBg;
    final iconFg = selected ? Colors.white : AppColors.primary;
    final textColor =
        selected ? AppColors.drawerSelectedGreen : AppColors.textPrimary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: selected ? AppColors.drawerSelectedRow : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: iconFg, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                ),
                if (badge != null) _CountBadge(count: badge!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 24),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.badgeRed,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _LogoutCard extends StatelessWidget {
  const _LogoutCard({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.logoutTintBg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.logout, color: AppColors.error, size: 22),
              ),
              const SizedBox(width: 14),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
