class ShoppingItem {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final bool isBought;

  ShoppingItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    this.isBought = false,
  });

  ShoppingItem copyWith({
    String? id,
    String? name,
    double? quantity,
    String? unit,
    bool? isBought,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      isBought: isBought ?? this.isBought,
    );
  }
}