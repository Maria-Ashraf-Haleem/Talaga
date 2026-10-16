import 'package:flutter/material.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/models/product_item.dart';
import '../widgets/inventory_filter_sheet.dart';

class FridgeInventoryScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;

  const FridgeInventoryScreen({
    super.key,
    this.onBackToHome,
  });

  @override
  State<FridgeInventoryScreen> createState() => _FridgeInventoryScreenState();
}

class _FridgeInventoryScreenState extends State<FridgeInventoryScreen> {
  String _selectedCategory = 'All';
  String _selectedSort = 'Name (A - Z)';
  String _searchQuery = '';

  final List<String> _quickCategories = const [
    'All',
    'Fruits',
    'Vegetables',
    'Dairy',
  ];

  Future<void> _openFilterModal() async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => InventoryFilterSheet(
        initialCategory: _selectedCategory,
        initialSort: _selectedSort,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedCategory = result['category'] ?? 'All';
        _selectedSort = result['sort'] ?? 'Name (A - Z)';
      });
    }
  }

  List<ProductItem> get _filteredProducts {
    return dummyInventoryItems.where((item) {
      final matchesCategory =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getExpiryColor(int daysLeft) {
    if (daysLeft <= 2) return AppColors.danger;
    if (daysLeft <= 5) return AppColors.expiring;
    return AppColors.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredProducts;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRouter.addEditProduct);
        },
        backgroundColor: AppColors.primary,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // Top AppBar Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const Text('Fridge Inventory', style: AppTextStyles.h2),
                  IconButton(
                    onPressed: _openFilterModal,
                    icon: const Icon(
                      Icons.tune_rounded,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Search Bar with Filter Icon
              Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
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
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search items...',
                          hintStyle: TextStyle(
                            fontSize: 13.5,
                            color: AppColors.textHint,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _openFilterModal,
                      child: const Icon(
                        Icons.filter_alt_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Quick Category Chips Row (All, Fruits, Vegetables, Dairy)
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _quickCategories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = _quickCategories[index];
                    final isSelected = _selectedCategory == category;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),

              // Products List Card Container
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(
                      color: AppColors.divider,
                      height: 16,
                    ),
                    itemBuilder: (context, index) {
                      final product = items[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.productDetails,
                            arguments: product,
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              // Product Image / Emoji Box
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: product.bgColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Text(
                                    product.emoji,
                                    style: const TextStyle(fontSize: 28),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Product Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      product.fullQuantity,
                                      style: const TextStyle(
                                        fontSize: 12.5,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      product.expiryText,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color:
                                        _getExpiryColor(product.daysLeft),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.textHint,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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