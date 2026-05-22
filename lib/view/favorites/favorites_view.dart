import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/components/safe_network_image.dart';
import '../../configs/utils.dart';
import '../../model/favorites/favorite_models.dart';
import '../../view_model/favorites/favorites_view_model.dart';

/// Saved offers, traders, and trades — filter, search, open detail, remove (demo session).
class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FavoritesViewModel>();
    if (vm.selectedItem != null) {
      return const _FavoriteDetailScaffold();
    }
    return const _FavoritesListScaffold();
  }
}

class _FavoritesListScaffold extends StatelessWidget {
  const _FavoritesListScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<FavoritesViewModel>();
    final rows = vm.filteredItems;

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.drawerItemFavorites),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              l10n.favoritesSubtitle,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: TextField(
              onChanged: vm.setSearchQuery,
              decoration: InputDecoration(
                hintText: l10n.favoritesSearchHint,
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                _FilterChip(
                  label: l10n.favoritesFilterAll,
                  selected: vm.filter == FavoriteListFilter.all,
                  onTap: () => vm.setFilter(FavoriteListFilter.all),
                ),
                _FilterChip(
                  label: l10n.favoritesFilterOffers,
                  selected: vm.filter == FavoriteListFilter.liveOffers,
                  onTap: () => vm.setFilter(FavoriteListFilter.liveOffers),
                ),
                _FilterChip(
                  label: l10n.favoritesFilterTraders,
                  selected: vm.filter == FavoriteListFilter.traders,
                  onTap: () => vm.setFilter(FavoriteListFilter.traders),
                ),
                _FilterChip(
                  label: l10n.favoritesFilterTrades,
                  selected: vm.filter == FavoriteListFilter.trades,
                  onTap: () => vm.setFilter(FavoriteListFilter.trades),
                ),
              ],
            ),
          ),
          Expanded(
            child: rows.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        vm.allItems.isEmpty
                            ? l10n.favoritesEmptyAll
                            : l10n.favoritesEmptyFilter,
                        style: const TextStyle(color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: rows.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final f = rows[i];
                      return _FavoriteListCard(
                        item: f,
                        l10n: l10n,
                        onOpen: () =>
                            context.read<FavoritesViewModel>().openItem(f),
                        onRemove: () => _confirmRemove(context, f),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  static Future<void> _confirmRemove(BuildContext context, FavoriteItem f) async {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.read<FavoritesViewModel>();
    final go = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.favoritesRemoveTitle),
        content: Text(l10n.favoritesRemoveBody(f.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.favoritesRemoveCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.favoritesRemoveConfirm),
          ),
        ],
      ),
    );
    if (go == true && context.mounted) {
      vm.removeFavorite(f.id);
      showAppSnackBar(context, l10n.favoritesSnackRemoved);
    }
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primary,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        backgroundColor: AppColors.chipInactive,
        side: const BorderSide(color: AppColors.border),
      ),
    );
  }
}

class _KindChip extends StatelessWidget {
  const _KindChip({required this.kind, required this.l10n});

  final FavoriteKind kind;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    late String label;
    late Color fg;
    late Color bg;
    switch (kind) {
      case FavoriteKind.liveOffer:
        label = l10n.favoritesKindOffer;
        fg = const Color(0xFF1565C0);
        bg = const Color(0xFFE3F2FD);
        break;
      case FavoriteKind.traderProfile:
        label = l10n.favoritesKindTrader;
        fg = AppColors.primary;
        bg = AppColors.sellingBadge;
        break;
      case FavoriteKind.tradeListing:
        label = l10n.favoritesKindTrade;
        fg = const Color(0xFF6D4C41);
        bg = AppColors.pendingBg;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: fg,
        ),
      ),
    );
  }
}

class _FavoriteListCard extends StatelessWidget {
  const _FavoriteListCard({
    required this.item,
    required this.l10n,
    required this.onOpen,
    required this.onRemove,
  });

  final FavoriteItem item;
  final AppLocalizations l10n;
  final VoidCallback onOpen;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SafeNetworkImage(
                  url: item.imageUrl,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                          icon: const Icon(Icons.favorite, color: AppColors.error),
                          onPressed: onRemove,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (item.priceLine != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.priceLine!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _KindChip(kind: item.kind, l10n: l10n),
                        const Spacer(),
                        Text(
                          l10n.favoritesSavedOn(item.savedAtLabel),
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
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

class _FavoriteDetailScaffold extends StatelessWidget {
  const _FavoriteDetailScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<FavoritesViewModel>();
    final f = vm.selectedItem!;

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: vm.closeDetail,
        ),
        title: Text(l10n.favoritesDetailTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              children: [
                LayoutBuilder(
                  builder: (context, c) {
                    final w = c.maxWidth;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: SafeNetworkImage(
                        url: f.imageUrl,
                        width: w,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _KindChip(kind: f.kind, l10n: l10n),
                const SizedBox(height: 10),
                Text(
                  f.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  f.subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (f.priceLine != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    f.priceLine!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  l10n.favoritesSavedOn(f.savedAtLabel),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Material(
            elevation: 8,
            color: AppColors.surface,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final go = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(l10n.favoritesRemoveTitle),
                          content: Text(l10n.favoritesRemoveBody(f.title)),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: Text(l10n.favoritesRemoveCancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.error,
                              ),
                              child: Text(l10n.favoritesRemoveConfirm),
                            ),
                          ],
                        ),
                      );
                      if (go == true && context.mounted) {
                        vm.removeFavorite(f.id);
                        showAppSnackBar(context, l10n.favoritesSnackRemoved);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Icons.heart_broken_outlined),
                    label: Text(l10n.favoritesRemoveFromList),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
