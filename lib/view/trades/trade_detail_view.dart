import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import '../../configs/color/app_colors.dart';
import '../../configs/components/safe_network_image.dart';
import '../../configs/routes/routes_name.dart';
import '../../configs/utils.dart';
import '../../model/trade/trade_row.dart';

/// Product-style trade detail: image, specs, actions (demo).
class TradeDetailView extends StatefulWidget {
  const TradeDetailView({super.key, required this.row});

  final TradeRow row;

  @override
  State<TradeDetailView> createState() => _TradeDetailViewState();
}

class _TradeDetailViewState extends State<TradeDetailView> {
  bool _favorite = false;

  TradeRow get row => widget.row;

  int? _parseRsTotal(String price) {
    final digits = price.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return null;
    return int.tryParse(digits);
  }

  double? _parseKg(String qty) {
    final m = RegExp(r'([\d.,]+)\s*kg', caseSensitive: false).firstMatch(qty);
    if (m == null) return null;
    return double.tryParse(m.group(1)!.replaceAll(',', ''));
  }

  double? _parseTons(String qty) {
    final m = RegExp(r'([\d.,]+)\s*tons?', caseSensitive: false).firstMatch(qty);
    if (m == null) return null;
    final t = double.tryParse(m.group(1)!.replaceAll(',', ''));
    return t == null ? null : t * 1000;
  }

  /// Primary price line (prefer per kg when total + kg known).
  ({String main, String sub}) _priceLines(AppLocalizations l10n) {
    final total = _parseRsTotal(row.price);
    final kg = _parseKg(row.qty) ?? _parseTons(row.qty);
    if (total != null && kg != null && kg > 0) {
      final per = (total / kg).round();
      return (main: 'Rs ${_commaInt(per)}', sub: l10n.tradeDetailPerKg);
    }
    return (main: row.price, sub: l10n.tradeDetailPriceTotalHint);
  }

  String _commaInt(int n) {
    var s = n.abs().toString();
    final parts = <String>[];
    while (s.length > 3) {
      parts.insert(0, s.substring(s.length - 3));
      s = s.substring(0, s.length - 3);
    }
    if (s.isNotEmpty) parts.insert(0, s);
    return parts.join(',');
  }

  String _categoryLabel(AppLocalizations l10n) {
    final p = row.product.toLowerCase();
    if (p.contains('date')) return l10n.tradeDetailCategoryDryFruits;
    if (p.contains('walnut') ||
        p.contains('almond') ||
        p.contains('cashew') ||
        p.contains('pistachio') ||
        p.contains('nut')) {
      return l10n.tradeDetailCategoryNuts;
    }
    if (p.contains('herb') || p.contains('mint') || p.contains('fennel')) {
      return l10n.tradeDetailCategoryHerbs;
    }
    return l10n.tradeDetailCategorySpices;
  }

  String _originLabel() {
    final t = row.trader.toLowerCase();
    if (t.contains('sindh') || t.contains('sukkur')) return 'Sindh';
    if (t.contains('karachi')) return 'Sindh';
    if (t.contains('lahore')) return 'Punjab';
    if (t.contains('multan')) return 'Punjab';
    if (t.contains('gujranwala')) return 'Punjab';
    if (t.contains('kashmir')) return 'AJK';
    if (t.contains('guatemala')) return 'Guatemala';
    return 'Pakistan';
  }

  String _cropYear() {
    final m = RegExp(r'(20\d{2})').firstMatch(row.date);
    if (m != null) return m.group(1)!;
    return DateTime.now().year.toString();
  }

  String _availableQty() {
    final kg = _parseKg(row.qty);
    if (kg != null) return '${_commaInt(kg.round())} kg';
    final tons = _parseTons(row.qty);
    if (tons != null) return '${_commaInt(tons.round())} kg';
    return row.qty;
  }

  String _description(AppLocalizations l10n) {
    return l10n.tradeDetailDescriptionBody(
      row.product,
      row.trader,
      row.qty,
      row.price,
      _cropYear(),
    );
  }

  String _shareText() {
    return '${row.product} · ${row.trader} · ${row.qty} · ${row.price} · #${row.id}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final priceLines = _priceLines(l10n);
    final category = _categoryLabel(l10n);

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, size: 20, color: AppColors.textSecondary),
                label: Text(
                  l10n.tradeDetailBack,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeroImage(
                      row: row,
                      favorite: _favorite,
                      onFavorite: () {
                        setState(() => _favorite = !_favorite);
                        showAppSnackBar(
                          context,
                          _favorite
                              ? l10n.tradeDetailFavoriteOn
                              : l10n.tradeDetailFavoriteOff,
                        );
                      },
                      onShare: () async {
                        await Clipboard.setData(ClipboardData(text: _shareText()));
                        if (context.mounted) {
                          showAppSnackBar(context, l10n.snackCopiedToClipboard);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          child: _Pill(
                            label: category,
                            fg: AppColors.primary,
                            bg: AppColors.sellingBadge,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: _Pill(
                            label: l10n.tradeDetailRatingReviews('4.6', '248'),
                            fg: const Color(0xFF5D4037),
                            bg: AppColors.ratingBg,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      row.product,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.35,
                        ),
                        children: [
                          TextSpan(text: l10n.tradeDetailSoldByPrefix),
                          TextSpan(
                            text: row.trader,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          priceLines.main,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          priceLines.sub,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _SpecCard(
                            label: l10n.tradeDetailSpecOrigin,
                            value: _originLabel(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _SpecCard(
                            label: l10n.tradeDetailSpecCropYear,
                            value: _cropYear(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _SpecCard(
                            label: l10n.tradeDetailSpecAvailable,
                            value: _availableQty(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _ActionGrid(
                      row: row,
                      l10n: l10n,
                    ),
                    const SizedBox(height: 20),
                    _TrustRow(l10n: l10n),
                    const SizedBox(height: 20),
                    _DetailsCard(text: _description(l10n), l10n: l10n),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({
    required this.row,
    required this.favorite,
    required this.onFavorite,
    required this.onShare,
  });

  final TradeRow row;
  final bool favorite;
  final VoidCallback onFavorite;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final h = w * 0.92;
        return ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              SafeNetworkImage(
                url: row.imageUrl,
                width: w,
                height: h,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Column(
                  children: [
                    _RoundIconButton(
                      icon: favorite ? Icons.favorite : Icons.favorite_border,
                      iconColor: favorite ? AppColors.error : AppColors.textPrimary,
                      onPressed: onFavorite,
                    ),
                    const SizedBox(height: 10),
                    _RoundIconButton(
                      icon: Icons.share_outlined,
                      onPressed: onShare,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: Colors.black26,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 22, color: iconColor ?? AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.fg,
    required this.bg,
  });

  final String label;
  final Color fg;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: fg,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _SpecCard extends StatelessWidget {
  const _SpecCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.row, required this.l10n});

  final TradeRow row;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final selling = row.side == 'SELLING';
    final primaryA = selling ? l10n.tradeDetailBuyCash : l10n.tradeDetailOfferCash;
    final primaryB = selling ? l10n.tradeDetailBuyCredit : l10n.tradeDetailOfferCredit;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () => showAppSnackBar(context, l10n.tradeDetailActionDemo),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(primaryA, textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: () => showAppSnackBar(context, l10n.tradeDetailActionDemo),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accentOrange,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(primaryB, textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(RoutesName.quotations),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary, width: 1.4),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(l10n.tradeDetailSendQuotation),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(RoutesName.bargaining),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: AppColors.accentOrange, width: 1.4),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(l10n.tradeDetailStartBargaining),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TrustRow extends StatelessWidget {
  const _TrustRow({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    Widget item(IconData i, String t) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(i, size: 18, color: AppColors.primary),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                t,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        item(Icons.local_shipping_outlined, l10n.tradeDetailTrustShipping),
        item(Icons.verified_user_outlined, l10n.tradeDetailTrustQuality),
        item(Icons.chat_bubble_outline, l10n.tradeDetailTrustChat),
      ],
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.text, required this.l10n});

  final String text;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.tradeDetailDetailsTitle,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.45,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
