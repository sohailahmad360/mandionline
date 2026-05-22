/// Lifecycle of a price quotation (demo).
enum DemoQuotationStatus {
  draft,
  sent,
  accepted,
  rejected,
  expired,
}

class DemoQuotation {
  const DemoQuotation({
    required this.id,
    required this.issuedDate,
    required this.validUntilDate,
    required this.productLine,
    required this.fromParty,
    required this.toParty,
    required this.amountLine,
    required this.qtyLine,
    required this.status,
  });

  final String id;
  final String issuedDate;
  final String validUntilDate;
  final String productLine;
  final String fromParty;
  final String toParty;
  final String amountLine;
  final String qtyLine;
  final DemoQuotationStatus status;
}

List<DemoQuotation> demoQuotations() {
  return const [
    DemoQuotation(
      id: 'QT-24091',
      issuedDate: '2026-04-22',
      validUntilDate: '2026-04-29',
      productLine: 'Dried red chilies · Grade A',
      fromParty: 'Karachi Wholesale',
      toParty: 'Punjabi Store',
      amountLine: 'Rs 780 / kg',
      qtyLine: 'Up to 500 kg',
      status: DemoQuotationStatus.sent,
    ),
    DemoQuotation(
      id: 'QT-24088',
      issuedDate: '2026-04-21',
      validUntilDate: '2026-04-28',
      productLine: 'Green cardamom · 8mm',
      fromParty: 'Lahore Imports',
      toParty: 'Multan Spices Co.',
      amountLine: 'Rs 4,200 / kg',
      qtyLine: '40 kg lot',
      status: DemoQuotationStatus.accepted,
    ),
    DemoQuotation(
      id: 'QT-24070',
      issuedDate: '2026-04-18',
      validUntilDate: '2026-04-25',
      productLine: 'Premium walnuts · shelled',
      fromParty: 'Kashmir Dry Fruits',
      toParty: 'Islamabad Trading',
      amountLine: 'Rs 1,850 / kg',
      qtyLine: '200 kg',
      status: DemoQuotationStatus.rejected,
    ),
    DemoQuotation(
      id: 'QT-24055',
      issuedDate: '2026-04-10',
      validUntilDate: '2026-04-17',
      productLine: 'Aseel dates · bulk',
      fromParty: 'Sindh Traders',
      toParty: 'Lahore Imports',
      amountLine: 'Rs 620 / kg',
      qtyLine: '120 kg',
      status: DemoQuotationStatus.expired,
    ),
    DemoQuotation(
      id: 'QT-24102',
      issuedDate: '2026-04-24',
      validUntilDate: '2026-05-01',
      productLine: 'Turmeric powder · polished',
      fromParty: 'Multan Spices Co.',
      toParty: 'Karachi Wholesale',
      amountLine: 'Rs 420 / kg',
      qtyLine: '2 tons',
      status: DemoQuotationStatus.draft,
    ),
    DemoQuotation(
      id: 'QT-24095',
      issuedDate: '2026-04-23',
      validUntilDate: '2026-04-30',
      productLine: 'Black pepper · whole',
      fromParty: 'Gujranwala Traders',
      toParty: 'Punjabi Store',
      amountLine: 'Rs 1,850 / kg',
      qtyLine: '150 kg',
      status: DemoQuotationStatus.sent,
    ),
  ];
}
