import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/demo_media_urls.dart';
import '../../configs/validator/app_validator.dart';
import '../../model/trade/trade_row.dart';
import '../../view_model/trades/trades_view_model.dart';

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

String _formatRsTotal(num value) {
  final r = value.round();
  return 'Rs ${_commaInt(r)}';
}

/// Four-step new trade flow (category → quantity → pricing → review), matching product UI.
///
/// On successful publish, this route is popped with result `true` so the host (e.g. [MainShellView])
/// can switch to the Trades tab and show confirmation.
class CreateTradeView extends StatefulWidget {
  const CreateTradeView({super.key});

  @override
  State<CreateTradeView> createState() => _CreateTradeViewState();
}

class _CreateTradeViewState extends State<CreateTradeView> {
  static const _thumbUrls = [
    DemoMediaUrls.spice,
    DemoMediaUrls.dryFruit,
    DemoMediaUrls.nut,
    DemoMediaUrls.herb,
  ];

  int _step = 0;
  bool _selling = true;

  final _keys = List.generate(4, (_) => GlobalKey<FormState>());

  // Step 1 — category
  String _mainCategory = 'Spices';
  String _category = 'Cardamom';
  String _subCategory = 'Whole';
  String _productType = 'Premium';
  String _origin = 'Pakistan';
  String _cropYear = '2024';

  // Step 2 — quantity
  final _qtyKg = TextEditingController(text: '500');
  String _packaging = 'Jute bag 50kg';
  final _minOrder = TextEditingController(text: '50');
  final _availableDate = TextEditingController(text: '2026-04-25');

  // Step 3 — pricing
  final _pricePerKg = TextEditingController(text: '780');
  String _currency = 'PKR';
  String _paymentTerms = 'Cash';
  String _delivery = 'FOB Karachi';

  static const _mainCategories = ['Spices', 'Dry fruits', 'Nuts', 'Herbs'];
  static const _categoriesByMain = {
    'Spices': ['Cardamom', 'Red chilies', 'Turmeric', 'Black pepper', 'Cinnamon'],
    'Dry fruits': ['Dates', 'Walnuts', 'Raisins', 'Figs'],
    'Nuts': ['Almonds', 'Cashews', 'Pistachios'],
    'Herbs': ['Mint', 'Coriander seed', 'Fennel'],
  };
  static const _subCategories = ['Whole', 'Powder', 'Pieces', 'Bulk'];
  static const _types = ['Premium', 'Standard', 'Economy'];
  static const _origins = ['Pakistan', 'Guatemala', 'India', 'UAE', 'Iran'];
  static const _cropYears = ['2024', '2025', '2026'];
  static const _packagingOptions = [
    'Jute bag 50kg',
    'Polypropylene 25kg',
    'Bulk loose',
    'Carton 10kg',
  ];
  static const _currencies = ['PKR', 'USD'];
  static const _paymentOptions = ['Cash', 'Bank transfer', 'Credit 30 days', 'Advance 50%'];
  static const _deliveryOptions = [
    'FOB Karachi',
    'EXW Lahore',
    'CIF Port Qasim',
    'Pickup mandi',
  ];

  @override
  void dispose() {
    _qtyKg.dispose();
    _minOrder.dispose();
    _availableDate.dispose();
    _pricePerKg.dispose();
    super.dispose();
  }

  void _goBack() {
    if (_step <= 0) {
      Navigator.of(context).pop();
    } else {
      setState(() => _step--);
    }
  }

  void _next() {
    if (!(_keys[_step].currentState?.validate() ?? false)) return;
    if (_step < 3) {
      setState(() => _step++);
    }
  }

  double? _parseQty() => double.tryParse(_qtyKg.text.trim().replaceAll(',', ''));
  double? _parsePrice() => double.tryParse(_pricePerKg.text.trim().replaceAll(',', ''));

  void _publish() {
    final l10n = AppLocalizations.of(context)!;
    // Only one [Form] is mounted at a time (`key: _keys[_step]`). Inactive step keys
    // have no [FormState], so a loop over all keys wrongly treats them as invalid
    // and jumps to step 0. Validate the current step only; prior steps were
    // validated on "Next", and numeric checks below guard the payload.
    final form = _keys[_step].currentState;
    if (form != null && !form.validate()) {
      return;
    }
    final qty = _parseQty();
    final ppk = _parsePrice();
    if (qty == null || ppk == null || qty <= 0 || ppk <= 0) return;

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final date = _availableDate.text.trim().isNotEmpty
        ? _availableDate.text.trim()
        : DateTime.now().toIso8601String().split('T').first;
    final side = _selling ? 'SELLING' : 'BUYING';
    final img = _thumbUrls[_mainCategory.hashCode.abs() % _thumbUrls.length];

    final product =
        '$_mainCategory · $_category · $_subCategory ($_productType)';
    final trader = l10n.newTradeMarketplaceLabel;
    final qtyLine =
        '${_qtyKg.text.trim()} kg · $_packaging · min ${_minOrder.text.trim()} kg';
    final total = qty * ppk;

    final row = TradeRow(
      id: id.length > 8 ? id.substring(id.length - 8) : id,
      side: side,
      product: product,
      trader: trader,
      qty: qtyLine,
      price: _formatRsTotal(total),
      status: 'Active',
      date: date,
      imageUrl: img,
    );

    context.read<TradesViewModel>().addUserTrade(row);
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = DateTime.tryParse(_availableDate.text.trim()) ?? now;
    final d = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
      initialDate: initial,
    );
    if (d != null && mounted) {
      setState(() {
        _availableDate.text =
            '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
      });
    }
  }

  List<String> get _categoriesForMain =>
      _categoriesByMain[_mainCategory] ?? _categoriesByMain['Spices']!;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.inputFill,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 12, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _goBack,
                  icon: const Icon(Icons.arrow_back, size: 20, color: AppColors.textSecondary),
                  label: Text(
                    l10n.newTradeBack,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.createTradeTitle,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.createTradeSubtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.35,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _SellBuyToggle(
                selling: _selling,
                l10n: l10n,
                onChanged: (v) => setState(() => _selling = v),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _StepperRow(currentStep: _step),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Material(
                  color: AppColors.surface,
                  elevation: 2,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                    child: Form(
                      key: _keys[_step],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildStepHeader(l10n),
                          const SizedBox(height: 18),
                          _buildStepFields(l10n),
                          const Divider(height: 32),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: _goBack,
                                icon: const Icon(Icons.arrow_back, size: 18),
                                label: Text(l10n.newTradeBack),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.textPrimary,
                                ),
                              ),
                              const Spacer(),
                              if (_step < 3)
                                FilledButton.icon(
                                  onPressed: _next,
                                  icon: const Icon(Icons.arrow_forward, size: 18),
                                  label: Text(l10n.newTradeNext),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: AppColors.onPrimary,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                )
                              else
                                FilledButton(
                                  onPressed: _publish,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: AppColors.onPrimary,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(l10n.newTradePublish),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepHeader(AppLocalizations l10n) {
    late String stepLabel;
    late String section;
    switch (_step) {
      case 0:
        stepLabel = l10n.newTradeStep1;
        section = l10n.newTradeSectionCategory;
        break;
      case 1:
        stepLabel = l10n.newTradeStep2;
        section = l10n.newTradeSectionQuantity;
        break;
      case 2:
        stepLabel = l10n.newTradeStep3;
        section = l10n.newTradeSectionPricing;
        break;
      default:
        stepLabel = l10n.newTradeStep4;
        section = l10n.newTradeSectionReview;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepLabel,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          section,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStepFields(AppLocalizations l10n) {
    switch (_step) {
      case 0:
        return _step1Category(l10n);
      case 1:
        return _step2Quantity(l10n);
      case 2:
        return _step3Pricing(l10n);
      default:
        return _step4Review(l10n);
    }
  }

  InputDecoration _fieldDec({required String label}) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: AppColors.surfaceMuted,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
      ),
    );
  }

  Widget _dropdownField<T>({
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return InputDecorator(
      key: ValueKey<Object>('$label-$value'),
      decoration: _fieldDec(label: label).copyWith(
        suffixIcon: const Icon(Icons.unfold_more, color: AppColors.textSecondary),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          items: items
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(e.toString()),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _step1Category(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _dropdownField<String>(
          label: l10n.newTradeMainCategory,
          value: _mainCategory,
          items: _mainCategories,
          onChanged: (v) {
            if (v == null) return;
            setState(() {
              _mainCategory = v;
              if (!_categoriesForMain.contains(_category)) {
                _category = _categoriesForMain.first;
              }
            });
          },
        ),
        const SizedBox(height: 14),
        _dropdownField<String>(
          label: l10n.newTradeCategory,
          value: _categoriesForMain.contains(_category)
              ? _category
              : _categoriesForMain.first,
          items: _categoriesForMain,
          onChanged: (v) => setState(() => _category = v ?? _categoriesForMain.first),
        ),
        const SizedBox(height: 14),
        _dropdownField<String>(
          label: l10n.newTradeSubCategory,
          value: _subCategory,
          items: _subCategories,
          onChanged: (v) => setState(() => _subCategory = v ?? _subCategories.first),
        ),
        const SizedBox(height: 14),
        _dropdownField<String>(
          label: l10n.newTradeType,
          value: _productType,
          items: _types,
          onChanged: (v) => setState(() => _productType = v ?? _types.first),
        ),
        const SizedBox(height: 14),
        _dropdownField<String>(
          label: l10n.newTradeOrigin,
          value: _origin,
          items: _origins,
          onChanged: (v) => setState(() => _origin = v ?? _origins.first),
        ),
        const SizedBox(height: 14),
        _dropdownField<String>(
          label: l10n.newTradeCropYear,
          value: _cropYear,
          items: _cropYears,
          onChanged: (v) => setState(() => _cropYear = v ?? _cropYears.first),
        ),
      ],
    );
  }

  Widget _step2Quantity(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _qtyKg,
          keyboardType: TextInputType.number,
          decoration: _fieldDec(label: l10n.newTradeQuantityKg),
          validator: (v) {
            final r = AppValidator.required(v, l10n.newTradeQuantityKg);
            if (r != null) return r;
            if (_parseQty() == null || _parseQty()! <= 0) {
              return l10n.newTradeInvalidNumber;
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        _dropdownField<String>(
          label: l10n.newTradePackaging,
          value: _packaging,
          items: _packagingOptions,
          onChanged: (v) => setState(() => _packaging = v ?? _packagingOptions.first),
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _minOrder,
          keyboardType: TextInputType.number,
          decoration: _fieldDec(label: l10n.newTradeMinOrder),
          validator: (v) => AppValidator.required(v, l10n.newTradeMinOrder),
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _availableDate,
          readOnly: true,
          onTap: _pickDate,
          decoration: _fieldDec(label: l10n.newTradeAvailableDate).copyWith(
            suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
          ),
          validator: (v) => AppValidator.required(v, l10n.newTradeAvailableDate),
        ),
      ],
    );
  }

  Widget _step3Pricing(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _pricePerKg,
          keyboardType: TextInputType.number,
          decoration: _fieldDec(label: l10n.newTradePricePerKg),
          validator: (v) {
            final r = AppValidator.required(v, l10n.newTradePricePerKg);
            if (r != null) return r;
            if (_parsePrice() == null || _parsePrice()! <= 0) {
              return l10n.newTradeInvalidNumber;
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        _dropdownField<String>(
          label: l10n.newTradeCurrency,
          value: _currency,
          items: _currencies,
          onChanged: (v) => setState(() => _currency = v ?? _currencies.first),
        ),
        const SizedBox(height: 14),
        _dropdownField<String>(
          label: l10n.newTradePaymentTerms,
          value: _paymentTerms,
          items: _paymentOptions,
          onChanged: (v) => setState(() => _paymentTerms = v ?? _paymentOptions.first),
        ),
        const SizedBox(height: 14),
        _dropdownField<String>(
          label: l10n.newTradeDelivery,
          value: _delivery,
          items: _deliveryOptions,
          onChanged: (v) => setState(() => _delivery = v ?? _deliveryOptions.first),
        ),
      ],
    );
  }

  Widget _step4Review(AppLocalizations l10n) {
    final qty = _parseQty() ?? 0;
    final ppk = _parsePrice() ?? 0;
    final total = qty * ppk;
    final typeLine = _selling ? l10n.createTradeSelling : l10n.createTradeBuying;
    final categoryLine = '$_mainCategory > $_category';
    final originLine = '$_origin $_cropYear';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.newTradeReviewHint,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 16),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _reviewRow(l10n.newTradeReviewType, typeLine),
                _reviewRow(l10n.newTradeReviewCategory, categoryLine),
                _reviewRow(l10n.newTradeReviewOrigin, originLine),
                _reviewRow(
                  l10n.newTradeReviewQuantity,
                  '${_qtyKg.text.trim()} kg',
                ),
                _reviewRow(
                  l10n.newTradeReviewPrice,
                  '${_formatRsTotal(ppk)}/kg',
                ),
                const Divider(height: 20),
                _reviewRow(l10n.newTradeReviewTotal, _formatRsTotal(total), emphasize: true),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _reviewRow(String label, String value, {bool emphasize = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 88,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: emphasize ? AppColors.textPrimary : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: emphasize ? 16 : 14,
                fontWeight: emphasize ? FontWeight.w900 : FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SellBuyToggle extends StatelessWidget {
  const _SellBuyToggle({
    required this.selling,
    required this.l10n,
    required this.onChanged,
  });

  final bool selling;
  final AppLocalizations l10n;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TogglePill(
            label: l10n.createTradeSelling,
            selected: selling,
            onTap: () => onChanged(true),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TogglePill(
            label: l10n.createTradeBuying,
            selected: !selling,
            onTap: () => onChanged(false),
          ),
        ),
      ],
    );
  }
}

class _TogglePill extends StatelessWidget {
  const _TogglePill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.primary : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.border,
          width: 1.2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: selected ? AppColors.onPrimary : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepperRow extends StatelessWidget {
  const _StepperRow({required this.currentStep});

  /// 0-based index (0 = step 1 on UI).
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < 4; i++) ...[
          if (i > 0) Expanded(child: _Connector(done: i <= currentStep)),
          _StepCircle(
            index: i,
            currentStep: currentStep,
          ),
        ],
      ],
    );
  }
}

class _Connector extends StatelessWidget {
  const _Connector({required this.done});

  final bool done;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          color: done ? AppColors.primary : AppColors.border,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({
    required this.index,
    required this.currentStep,
  });

  final int index;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final completed = index < currentStep;
    final active = index == currentStep;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: completed || active ? AppColors.primary : AppColors.chipInactive,
      ),
      alignment: Alignment.center,
      child: completed
          ? const Icon(Icons.check, color: AppColors.onPrimary, size: 20)
          : Text(
              '${index + 1}',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: active ? AppColors.onPrimary : AppColors.textSecondary,
              ),
            ),
    );
  }
}
