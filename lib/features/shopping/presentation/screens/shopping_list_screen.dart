import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class ShoppingListScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;

  const ShoppingListScreen({
    super.key,
    this.onBackToHome,
  });

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final TextEditingController _addItemController = TextEditingController();

  final List<_ShoppingItem> _items = [
    _ShoppingItem(
      name: 'Milk',
      quantity: '2 liters',
      emoji: '🥛',
      bgColor: const Color(0xFFE3F2FD),
      isChecked: false,
    ),
    _ShoppingItem(
      name: 'Bread',
      quantity: '1 pack',
      emoji: '🍞',
      bgColor: const Color(0xFFFFF8E1),
      isChecked: false,
    ),
    _ShoppingItem(
      name: 'Eggs',
      quantity: '12 pieces',
      emoji: '🥚',
      bgColor: const Color(0xFFFFF3E0),
      isChecked: true,
    ),
    _ShoppingItem(
      name: 'Chicken',
      quantity: '1 kg',
      emoji: '🍗',
      bgColor: const Color(0xFFFCE4EC),
      isChecked: false,
    ),
    _ShoppingItem(
      name: 'Tomatoes',
      quantity: '1 kg',
      emoji: '🍅',
      bgColor: const Color(0xFFFFEBEE),
      isChecked: false,
    ),
  ];

  @override
  void dispose() {
    _addItemController.dispose();
    super.dispose();
  }

  void _addNewItem() {
    final text = _addItemController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _items.insert(
        0,
        _ShoppingItem(
          name: text,
          quantity: '1 piece',
          emoji: '🛒',
          bgColor: AppColors.softGreenBg,
          isChecked: false,
        ),
      );
      _addItemController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // Top AppBar
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (widget.onBackToHome != null) {
                        widget.onBackToHome!();
                      } else if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Shopping List',
                        style: AppTextStyles.h2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 12),

              // Main White Card Container
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      // Add Item Input Row + Green Plus Button
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 44,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColors.scaffoldBg,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search_rounded,
                                    color: AppColors.textHint,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: _addItemController,
                                      onSubmitted: (_) => _addNewItem(),
                                      decoration: const InputDecoration(
                                        hintText: 'Add item...',
                                        hintStyle: TextStyle(
                                          fontSize: 13.5,
                                          color: AppColors.textHint,
                                        ),
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: _addNewItem,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Shopping Items List
                      Expanded(
                        child: ListView.separated(
                          itemCount: _items.length,
                          separatorBuilder: (_, __) => const Divider(
                            color: AppColors.divider,
                            height: 16,
                          ),
                          itemBuilder: (context, index) {
                            final item = _items[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  item.isChecked = !item.isChecked;
                                });
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    // Custom Checkbox matching UI
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          item.isChecked = !item.isChecked;
                                        });
                                      },
                                      child: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          color: item.isChecked
                                              ? AppColors.primary
                                              : Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          border: Border.all(
                                            color: item.isChecked
                                                ? AppColors.primary
                                                : AppColors.textHint,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: item.isChecked
                                            ? const Icon(
                                          Icons.check_rounded,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Item Emoji Box
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: item.bgColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          item.emoji,
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Item Name & Quantity
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            item.quantity,
                                            style: const TextStyle(
                                              fontSize: 12.5,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Drag / Action Handle Icon
                                    PopupMenuButton<String>(
                                      icon: const Icon(
                                        Icons.dehaze_rounded,
                                        color: AppColors.textHint,
                                        size: 20,
                                      ),
                                      onSelected: (value) {
                                        if (value == 'delete') {
                                          setState(() {
                                            _items.removeAt(index);
                                          });
                                        }
                                      },
                                      itemBuilder: (context) => const [
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: Text('Remove Item'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Add to Inventory Button
                      PrimaryButton(
                        text: 'Add to Inventory',
                        onPressed: () {
                          final checkedCount =
                              _items.where((e) => e.isChecked).length;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                checkedCount > 0
                                    ? '$checkedCount purchased item(s) added to Inventory!'
                                    : 'Select purchased items first to add to Inventory.',
                              ),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShoppingItem {
  final String name;
  final String quantity;
  final String emoji;
  final Color bgColor;
  bool isChecked;

  _ShoppingItem({
    required this.name,
    required this.quantity,
    required this.emoji,
    required this.bgColor,
    required this.isChecked,
  });
}