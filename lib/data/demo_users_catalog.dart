import '../configs/demo_media_urls.dart';

/// User group shown on the Users screen (demo catalog).
enum UserCatalogKind {
  verifiedStore,
  buyerTrader,
  guest,
  broker,
  admin,
}

class DemoUserRow {
  const DemoUserRow({
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    this.showVerifiedBadge = false,
  });

  final String name;
  final String subtitle;
  final String imageUrl;
  final bool showVerifiedBadge;
}

class DemoUserSection {
  const DemoUserSection({required this.kind, required this.rows});

  final UserCatalogKind kind;
  final List<DemoUserRow> rows;
}

/// Static demo rows — replace with API models when backend is ready.
List<DemoUserSection> demoUserSections() {
  return const [
    DemoUserSection(
      kind: UserCatalogKind.verifiedStore,
      rows: [
        DemoUserRow(
          name: 'Karachi Wholesale',
          subtitle: 'Spices · Verified store · Lahore',
          imageUrl: 'https://picsum.photos/seed/mandi-user-kw/200/200',
          showVerifiedBadge: true,
        ),
        DemoUserRow(
          name: 'Punjabi Store',
          subtitle: 'Dry fruits · Verified store · Lahore',
          imageUrl: DemoMediaUrls.avatar,
          showVerifiedBadge: true,
        ),
        DemoUserRow(
          name: 'Multan Spices Co.',
          subtitle: 'Bulk spices · Verified store · Multan',
          imageUrl: 'https://picsum.photos/seed/mandi-user-ms/200/200',
          showVerifiedBadge: true,
        ),
      ],
    ),
    DemoUserSection(
      kind: UserCatalogKind.buyerTrader,
      rows: [
        DemoUserRow(
          name: 'Lahore Imports',
          subtitle: 'Buyer · Cardamom & nuts',
          imageUrl: 'https://picsum.photos/seed/mandi-user-li/200/200',
          showVerifiedBadge: true,
        ),
        DemoUserRow(
          name: 'Islamabad Trading',
          subtitle: 'Buyer · Herbs & dates',
          imageUrl: 'https://picsum.photos/seed/mandi-user-it/200/200',
          showVerifiedBadge: true,
        ),
      ],
    ),
    DemoUserSection(
      kind: UserCatalogKind.guest,
      rows: [
        DemoUserRow(
          name: 'Guest browser #1042',
          subtitle: 'Browsing only · No ledger sync',
          imageUrl: 'https://picsum.photos/seed/mandi-user-g1/200/200',
        ),
        DemoUserRow(
          name: 'Guest browser #1043',
          subtitle: 'Browsing only · Saved watchlist',
          imageUrl: 'https://picsum.photos/seed/mandi-user-g2/200/200',
        ),
      ],
    ),
    DemoUserSection(
      kind: UserCatalogKind.broker,
      rows: [
        DemoUserRow(
          name: 'Ayesha Malik',
          subtitle: 'Field broker · Punjab region',
          imageUrl: 'https://picsum.photos/seed/mandi-user-am/200/200',
        ),
        DemoUserRow(
          name: 'Hassan Raza',
          subtitle: 'Commission broker · Sindh',
          imageUrl: 'https://picsum.photos/seed/mandi-user-hr/200/200',
        ),
      ],
    ),
    DemoUserSection(
      kind: UserCatalogKind.admin,
      rows: [
        DemoUserRow(
          name: 'Mandi Support',
          subtitle: 'Platform operations · Escalations',
          imageUrl: 'https://picsum.photos/seed/mandi-user-sup/200/200',
        ),
      ],
    ),
  ];
}
