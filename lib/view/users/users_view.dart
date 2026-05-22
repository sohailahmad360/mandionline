import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/components/safe_network_image.dart';
import '../../data/demo_users_catalog.dart';

/// Lists counterparties and roles: stores, buyers, guests, brokers, admins (demo data).
class UsersView extends StatelessWidget {
  const UsersView({super.key});

  static String _sectionTitle(AppLocalizations l, UserCatalogKind k) {
    switch (k) {
      case UserCatalogKind.verifiedStore:
        return l.usersTypeVerifiedStores;
      case UserCatalogKind.buyerTrader:
        return l.usersTypeBuyersTraders;
      case UserCatalogKind.guest:
        return l.usersTypeGuests;
      case UserCatalogKind.broker:
        return l.usersTypeBrokers;
      case UserCatalogKind.admin:
        return l.usersTypeAdmins;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sections = demoUserSections();

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.drawerItemUsers),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                l10n.usersScreenSubtitle,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          for (final section in sections) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  _sectionTitle(l10n, section.kind),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final row = section.rows[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _UserCard(row: row),
                    );
                  },
                  childCount: section.rows.length,
                ),
              ),
            ),
          ],
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.row});

  final DemoUserRow row;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SafeNetworkImage(
                  url: row.imageUrl,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            row.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (row.showVerifiedBadge)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.sellingBadge,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              l10n.usersVerifiedBadge,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      row.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
