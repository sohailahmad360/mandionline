/// UI row for trades lists (mock or parsed from API later).
class TradeRow {
  const TradeRow({
    required this.id,
    required this.side,
    required this.product,
    required this.trader,
    required this.qty,
    required this.price,
    required this.status,
    required this.date,
    required this.imageUrl,
  });

  final String id;
  final String side;
  final String product;
  final String trader;
  final String qty;
  final String price;
  final String status;
  final String date;
  final String imageUrl;

  static TradeRow fromMap(Map<String, dynamic> m) {
    return TradeRow(
      id: m['id']?.toString() ?? '',
      side: m['side']?.toString() ?? '',
      product: m['product']?.toString() ?? '',
      trader: m['trader']?.toString() ?? '',
      qty: m['qty']?.toString() ?? '',
      price: m['price']?.toString() ?? '',
      status: m['status']?.toString() ?? '',
      date: m['date']?.toString() ?? '',
      imageUrl: m['img']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'side': side,
        'product': product,
        'trader': trader,
        'qty': qty,
        'price': price,
        'status': status,
        'date': date,
        'img': imageUrl,
      };
}
