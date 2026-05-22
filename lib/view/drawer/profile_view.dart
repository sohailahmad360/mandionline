import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/components/safe_network_image.dart';
import '../../configs/demo_media_urls.dart';
import '../../configs/utils.dart';
import '../../injection/di.dart';
import '../../repository/auth_api/static_auth_config.dart';
import '../../view_model/services/storage/local_storage.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final Future<_ProfileSnap> _future = _load();

  Future<_ProfileSnap> _load() async {
    final s = getIt<LocalStorage>();
    final guest = await s.isGuestUser();
    final name = await s.readProfileName();
    return _ProfileSnap(
      isGuest: guest,
      profileName: guest ? null : name,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.screenProfileTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: FutureBuilder<_ProfileSnap>(
        future: _future,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final p = snap.data!;
          final displayName = p.isGuest
              ? l10n.drawerGuest
              : (p.profileName ?? l10n.demoProfileName);
          final email = p.isGuest
              ? l10n.profileEmailGuestPlaceholder
              : StaticAuthConfig.demoEmail;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (p.isGuest)
                Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, color: AppColors.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.profileGuestBanner,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.35,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: ClipOval(
                    child: SafeNetworkImage(
                      url: DemoMediaUrls.avatar,
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                displayName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              if (!p.isGuest) ...[
                const SizedBox(height: 4),
                Text(
                  l10n.profileStoreRole,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              const SizedBox(height: 28),
              Text(
                l10n.profileSectionAccount,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(l10n.profileLabelEmail),
                      subtitle: Text(email),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: Text(l10n.profileLabelPhone),
                      subtitle: Text(l10n.profileDemoPhone),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () =>
                    showAppSnackBar(context, l10n.profileEditComingSoon),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: Text(l10n.profileEditProfile),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfileSnap {
  const _ProfileSnap({required this.isGuest, this.profileName});
  final bool isGuest;
  final String? profileName;
}
