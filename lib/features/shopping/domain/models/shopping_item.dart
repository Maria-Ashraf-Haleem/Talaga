class ShoppingItem {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final String category;
  final String householdId;
  final bool isBought;
  final String? boughtByUserId;
  final String? boughtByUserName;

  ShoppingItem({
    required this.id,
    required this.name,
    required this.quantity,
    this.unit = 'piece',
    this.category = 'General',
    this.householdId = 'home_123',
    this.isBought = false,
    this.boughtByUserId,
    this.boughtByUserName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'category': category,
      'householdId': householdId,
      'isBought': isBought,
      'boughtByUserId': boughtByUserId,
      'boughtByUserName': boughtByUserName,
    };
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map, String documentId) {
    return ShoppingItem(
      id: documentId,
      name: map['name'] ?? '',
      quantity: (map['quantity'] is num)
          ? (map['quantity'] as num).toDouble()
          : double.tryParse(map['quantity']?.toString() ?? '1') ?? 1.0,
      unit: map['unit'] ?? 'piece',
      category: map['category'] ?? 'General',
      householdId: map['householdId'] ?? 'home_123',
      isBought: map['isBought'] ?? false,
      boughtByUserId: map['boughtByUserId'],
      boughtByUserName: map['boughtByUserName'],
    );
  }

  String get formattedQuantity {
    final qtyStr = quantity == quantity.roundToDouble()
        ? quantity.toInt().toString()
        : quantity.toString();
    return '$qtyStr $unit';
  }
}