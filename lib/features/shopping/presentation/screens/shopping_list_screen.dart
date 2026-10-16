import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/models/shopping_item.dart';
import '../widgets/add_shopping_item_sheet.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final List<ShoppingItem> _items = [
    ShoppingItem(id: '1', name: 'Milk', quantity: 2, unit: 'liters', isBought: false),
    ShoppingItem(id: '2', name: 'Bread', quantity: 1, unit: 'pack', isBought: false),
    ShoppingItem(id: '3', name: 'Eggs', quantity: 12, unit: 'pieces', isBought: true),
    ShoppingItem(id: '4', name: 'Chicken', quantity: 1, unit: 'kg', isBought: false),
    ShoppingItem(id: '5', name: 'Tomatoes', quantity: 1, unit: 'kg', isBought: false),
  ];

  final TextEditingController _searchController = TextEditingController();

  // حساب نسبة التقدم في الشراء
  double get _purchaseProgress {
    if (_items.isEmpty) return 0.0;
    int boughtCount = _items.where((e) => e.isBought).length;
    return boughtCount / _items.length;
  }

  // ميثود لتحديد الـ Emoji المناسب بناءً على اسم المنتج (مطابق لستايل الـ Inventory)
  String _getEmojiForProduct(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('milk') || lower.contains('dairy') || lower.contains('لبن') || lower.contains('حليب')) {
      return '🥛';
    } else if (lower.contains('bread') || lower.contains('grains') || lower.contains('خبز') || lower.contains('عيش')) {
      return '🍞';
    } else if (lower.contains('egg') || lower.contains('بيض')) {
      return '🥚';
    } else if (lower.contains('chicken') || lower.contains('meat') || lower.contains('beef') || lower.contains('لحم') || lower.contains('دجاج')) {
      return '🍗';
    } else if (lower.contains('tomato') || lower.contains('vegetable') || lower.contains('خضار') || lower.contains('طماطم')) {
      return '🍎';
    } else if (lower.contains('apple') || lower.contains('fruit') || lower.contains('فاكهة') || lower.contains('تفاح')) {
      return '🍎';
    } else if (lower.contains('juice') || lower.contains('beverage') || lower.contains('عصير') || lower.contains('ماء')) {
      return '🧃';
    }
    return '📦'; // الـ Emoji الافتراضي (Other)
  }

  // ميثود لتحديد لون الخلفية الملونة المطابقة للـ Categories في الـ Inventory
  Color _getBgColorForProduct(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('milk') || lower.contains('dairy') || lower.contains('لبن') || lower.contains('حليب')) {
      return const Color(0xFFE3F2FD); // Dairy Blue
    } else if (lower.contains('bread') || lower.contains('grains') || lower.contains('خبز') || lower.contains('عيش')) {
      return const Color(0xFFFFF8E1); // Grains Yellow
    } else if (lower.contains('egg') || lower.contains('بيض')) {
      return const Color(0xFFFFFDE7); // Eggs Light Yellow
    } else if (lower.contains('chicken') || lower.contains('meat') || lower.contains('beef') || lower.contains('لحم') || lower.contains('دجاج')) {
      return const Color(0xFFFCE4EC); // Meat Pink
    } else if (lower.contains('tomato') || lower.contains('vegetable') || lower.contains('خضار') || lower.contains('طماطم')) {
      return const Color(0xFFE8F5E9); // Vegetables Green
    } else if (lower.contains('apple') || lower.contains('fruit') || lower.contains('فاكهة') || lower.contains('تفاح')) {
      return const Color(0xFFFFEBEE); // Fruits Red
    } else if (lower.contains('juice') || lower.contains('beverage') || lower.contains('عصير') || lower.contains('ماء')) {
      return const Color(0xFFE0F7FA); // Beverages Cyan
    }
    return const Color(0xFFF3E5F5); // Other Purple
  }

  void _openAddItemSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => AddShoppingItemSheet(
        onItemAdded: (newItem) {
          setState(() {
            _items.add(newItem);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = _items.length;
    int boughtItems = _items.where((e) => e.isBought).length;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: const Text(
          'Shopping List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 📊 1. كارد الـ Shopping Progress
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Shopping Progress',
                        style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '$boughtItems of $totalItems completed',
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _purchaseProgress,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 7,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 🔍 2. حقل البحث والإضافة السريعة
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Add item...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: _openAddItemSheet,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 🛒 3. قائمة العناصر بـ Emoji أصلية وخلفيات ملونة (مطابقة لـ Inventory)
            Expanded(
              child: _items.isEmpty
                  ? const Center(child: Text('Shopping list is empty!'))
                  : ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: item.isBought,
                          activeColor: AppColors.primary,
                          onChanged: (val) {
                            setState(() {
                              _items[index] = item.copyWith(isBought: val ?? false);
                            });
                          },
                        ),
                        const SizedBox(width: 4),

                        // 🍎 🥛 🥩 مربع الـ Emoji بخلفيته الملونة المطابقة للـ Inventory
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: _getBgColorForProduct(item.name),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              _getEmojiForProduct(item.name),
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  decoration: item.isBought
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: item.isBought ? Colors.grey : Colors.black87,
                                ),
                              ),
                              Text(
                                '${item.quantity % 1 == 0 ? item.quantity.toInt() : item.quantity} ${item.unit}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () {
                            setState(() {
                              _items.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🚀 4. زر إضافة المشتريات للمخزون
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final boughtCount = _items.where((e) => e.isBought).length;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$boughtCount bought items added to Inventory!'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add to Inventory',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}