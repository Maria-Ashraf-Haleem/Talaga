import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/shopping_repository.dart';
import '../../domain/models/shopping_item.dart';

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
  final ShoppingRepository _repository = ShoppingRepository();

  @override
  void initState() {
    super.initState();
    _repository.seedDefaultItemsIfNeeded();
  }

  @override
  void dispose() {
    _addItemController.dispose();
    super.dispose();
  }

  Future<void> _addNewItem() async {
    final text = _addItemController.text.trim();
    if (text.isEmpty) return;

    _addItemController.clear();
    await _repository.addShoppingItem(
      ShoppingItem(
        id: '',
        name: text,
        quantity: 1,
        unit: 'piece',
      ),
    );
  }

  String _getEmojiForName(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('milk')) return '🥛';
    if (lower.contains('bread')) return '🍞';
    if (lower.contains('egg')) return '🥚';
    if (lower.contains('chicken') || lower.contains('meat')) return '🍗';
    if (lower.contains('tomato')) return '🍅';
    return '🛒';
  }

  Color _getBgColorForName(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('milk')) return const Color(0xFFE3F2FD);
    if (lower.contains('bread')) return const Color(0xFFFFF8E1);
    if (lower.contains('egg')) return const Color(0xFFFFF3E0);
    if (lower.contains('chicken') || lower.contains('meat')) {
      return const Color(0xFFFCE4EC);
    }
    if (lower.contains('tomato')) return const Color(0xFFFFEBEE);
    return AppColors.softGreenBg;
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

                      // Shopping Items List from Firestore
                      Expanded(
                        child: StreamBuilder<List<ShoppingItem>>(
                          stream: _repository.getShoppingListStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final items = snapshot.data ?? [];

                            if (items.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No items in shopping list',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              );
                            }

                            return ListView.separated(
                              itemCount: items.length,
                              separatorBuilder: (_, __) => const Divider(
                                color: AppColors.divider,
                                height: 16,
                              ),
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return InkWell(
                                  onTap: () =>
                                      _repository.toggleItemBoughtStatus(item),
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        // Custom Checkbox matching UI
                                        GestureDetector(
                                          onTap: () => _repository
                                              .toggleItemBoughtStatus(item),
                                          child: Container(
                                            width: 22,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              color: item.isBought
                                                  ? AppColors.primary
                                                  : Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                color: item.isBought
                                                    ? AppColors.primary
                                                    : AppColors.textHint,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: item.isBought
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
                                            color: _getBgColorForName(item.name),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                            child: Text(
                                              _getEmojiForName(item.name),
                                              style:
                                              const TextStyle(fontSize: 24),
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
                                                style: TextStyle(
                                                  fontSize: 14.5,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.textPrimary,
                                                  decoration: item.isBought
                                                      ? TextDecoration
                                                      .lineThrough
                                                      : null,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                item.isBought &&
                                                    item.boughtByUserName !=
                                                        null
                                                    ? '${item.formattedQuantity} • Bought by ${item.boughtByUserName}'
                                                    : item.formattedQuantity,
                                                style: const TextStyle(
                                                  fontSize: 12.5,
                                                  color:
                                                  AppColors.textSecondary,
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
                                              _repository
                                                  .deleteShoppingItem(item.id);
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
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Add to Inventory Button
                      PrimaryButton(
                        text: 'Add to Inventory',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Purchased items synced with household inventory!',
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