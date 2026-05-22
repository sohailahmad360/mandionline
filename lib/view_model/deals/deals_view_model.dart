import 'package:flutter/foundation.dart';

import '../../configs/demo_media_urls.dart';

enum DealPaymentStatus { paid, unpaid }

enum DealShippingStatus { delivered, pending }

enum DealInvoiceStatus { completed, pending }

class DealUiModel {
  const DealUiModel({
    required this.id,
    required this.date,
    required this.product,
    required this.location,
    required this.qtyRate,
    required this.total,
    required this.payment,
    required this.shipping,
    required this.invoice,
    required this.imageUrl,
  });

  final String id;
  final String date;
  final String product;
  final String location;
  final String qtyRate;
  final String total;
  final DealPaymentStatus payment;
  final DealShippingStatus shipping;
  final DealInvoiceStatus invoice;
  final String imageUrl;
}

class DealsViewModel extends ChangeNotifier {
  int sellingCount = 2;
  int buyingCount = 2;

  final List<DealUiModel> deals = const [
    DealUiModel(
      id: '#DL-2089',
      date: '2026-04-12',
      product: 'Dried Red Chilies',
      location: 'Karachi Wholesale',
      qtyRate: '500 kg × Rs 780',
      total: 'Rs 390,000',
      payment: DealPaymentStatus.paid,
      shipping: DealShippingStatus.delivered,
      invoice: DealInvoiceStatus.completed,
      imageUrl: DemoMediaUrls.spice,
    ),
    DealUiModel(
      id: '#DL-2090',
      date: '2026-04-10',
      product: 'Aseel Dates',
      location: 'Sindh Traders',
      qtyRate: '200 kg × Rs 620',
      total: 'Rs 124,000',
      payment: DealPaymentStatus.unpaid,
      shipping: DealShippingStatus.pending,
      invoice: DealInvoiceStatus.pending,
      imageUrl: DemoMediaUrls.dryFruit,
    ),
  ];
}
