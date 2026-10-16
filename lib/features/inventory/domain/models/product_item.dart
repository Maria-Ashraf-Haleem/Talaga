import 'package:flutter/material.dart';

class ProductItem {
  final String id;
  final String name;
  final String category;
  final String quantity;
  final String unit;
  final String minQuantity;
  final String expiryText;
  final String expiryDateFormatted;
  final int daysLeft;
  final String notes;
  final String emoji;
  final Color bgColor;

  const ProductItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.minQuantity,
    required this.expiryText,
    required this.expiryDateFormatted,
    required this.daysLeft,
    required this.notes,
    required this.emoji,
    required this.bgColor,
  });

  String get fullQuantity => '$quantity $unit';
}

const List<ProductItem> dummyInventoryItems = [
  ProductItem(
    id: '1',
    name: 'Tomatoes',
    category: 'Fruits',
    quantity: '1.5',
    unit: 'kg',
    minQuantity: '1 kg',
    expiryText: 'Expires in 5 days',
    expiryDateFormatted: 'Oct 20, 2026 (5 days)',
    daysLeft: 5,
    notes: 'Keep in fridge drawer',
    emoji: '🍅',
    bgColor: Color(0xFFFFEBEE),
  ),
  ProductItem(
    id: '2',
    name: 'Milk',
    category: 'Dairy',
    quantity: '1',
    unit: 'liter',
    minQuantity: '1 liter',
    expiryText: 'Expires in 3 days',
    expiryDateFormatted: 'Oct 18, 2026 (3 days)',
    daysLeft: 3,
    notes: 'Store on middle shelf',
    emoji: '🥛',
    bgColor: Color(0xFFE3F2FD),
  ),
  ProductItem(
    id: '3',
    name: 'Eggs',
    category: 'Dairy',
    quantity: '12',
    unit: 'pieces',
    minQuantity: '6 pieces',
    expiryText: 'Expires in 10 days',
    expiryDateFormatted: 'Oct 25, 2026 (10 days)',
    daysLeft: 10,
    notes: 'Top door tray',
    emoji: '🥚',
    bgColor: Color(0xFFFFF8E1),
  ),
  ProductItem(
    id: '4',
    name: 'Cheese',
    category: 'Dairy',
    quantity: '200',
    unit: 'g',
    minQuantity: '100 g',
    expiryText: 'Expires in 15 days',
    expiryDateFormatted: 'Oct 30, 2026 (15 days)',
    daysLeft: 15,
    notes: 'Keep sealed after opening',
    emoji: '🧀',
    bgColor: Color(0xFFFFF3E0),
  ),
  ProductItem(
    id: '5',
    name: 'Lettuce',
    category: 'Vegetables',
    quantity: '1',
    unit: 'piece',
    minQuantity: '1 piece',
    expiryText: 'Expires in 2 days',
    expiryDateFormatted: 'Oct 17, 2026 (2 days)',
    daysLeft: 2,
    notes: 'Keep in crisper drawer',
    emoji: '🥬',
    bgColor: Color(0xFFE8F5E9),
  ),
];