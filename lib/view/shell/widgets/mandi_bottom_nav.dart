import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';

import '../../../configs/color/app_colors.dart';

class MandiBottomNav extends StatelessWidget {
  const MandiBottomNav({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  final int currentIndex;
  final ValueChanged<int> onSelect;

  static const _icons = [
    _NavIcons(Icons.home_outlined, Icons.home),
    _NavIcons(Icons.inventory_2_outlined, Icons.inventory_2),
    _NavIcons(Icons.handshake_outlined, Icons.handshake),
    _NavIcons(Icons.chat_bubble_outline, Icons.chat_bubble),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labels = [
      l10n.navHome,
      l10n.navTrades,
      l10n.navDeals,
      l10n.navMessages,
    ];
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            children: [
              for (var i = 0; i < _icons.length; i++)
                Expanded(
                  child: _NavCell(
                    spec: _NavSpec(_icons[i].outline, _icons[i].filled, labels[i]),
                    selected: currentIndex == i,
                    onTap: () => onSelect(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcons {
  const _NavIcons(this.outline, this.filled);
  final IconData outline;
  final IconData filled;
}

class _NavSpec {
  const _NavSpec(this.outline, this.filled, this.label);
  final IconData outline;
  final IconData filled;
  final String label;
}

class _NavCell extends StatelessWidget {
  const _NavCell({
    required this.spec,
    required this.selected,
    required this.onTap,
  });

  final _NavSpec spec;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textSecondary;
    final icon = selected ? spec.filled : spec.outline;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            spec.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 3,
            width: selected ? 28 : 0,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
