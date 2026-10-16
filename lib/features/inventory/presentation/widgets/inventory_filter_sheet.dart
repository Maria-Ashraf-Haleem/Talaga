import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';

class InventoryFilterSheet extends StatefulWidget {
  final String initialCategory;
  final String initialSort;

  const InventoryFilterSheet({
    super.key,
    this.initialCategory = 'All',
    this.initialSort = 'Name (A - Z)',
  });

  @override
  State<InventoryFilterSheet> createState() => _InventoryFilterSheetState();
}

class _InventoryFilterSheetState extends State<InventoryFilterSheet> {
  late String _selectedCategory;
  late String _selectedSort;

  final List<_CategoryOption> _categories = const [
    _CategoryOption('All', '⊞', Color(0xFFE6F2EC), isGridIcon: true),
    _CategoryOption('Fruits', '🍎', Color(0xFFFFEBEE)),
    _CategoryOption('Vegetables', '🥦', Color(0xFFE8F5E9)),
    _CategoryOption('Dairy', '🥛', Color(0xFFE3F2FD)),
    _CategoryOption('Meat', '🥩', Color(0xFFFCE4EC)),
    _CategoryOption('Grains', '🍞', Color(0xFFFFF8E1)),
    _CategoryOption('Beverages', '🧃', Color(0xFFE0F7FA)),
    _CategoryOption('Other', '📦', Color(0xFFF3E5F5)),
  ];

  final List<_SortOption> _sortOptions = const [
    _SortOption('Name (A - Z)', Icons.sort_by_alpha_rounded),
    _SortOption('Name (Z - A)', Icons.sort_by_alpha_rounded),
    _SortOption('Expiry Date (Soonest)', Icons.schedule_rounded),
    _SortOption('Expiry Date (Latest)', Icons.update_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _selectedSort = widget.initialSort;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Search bar + Cancel
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: AppColors.textHint,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              // Categories 3-Column Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat.label;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = cat.label;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.softGreenBg
                            : AppColors.scaffoldBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 1.4,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (cat.isGridIcon)
                            Icon(
                              Icons.grid_view_rounded,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              size: 24,
                            )
                          else
                            Text(
                              cat.emoji,
                              style: const TextStyle(fontSize: 22),
                            ),
                          const SizedBox(height: 5),
                          Text(
                            cat.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
              const Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),

              // Sort By Options List
              ..._sortOptions.map((option) {
                final isSelected = _selectedSort == option.label;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedSort = option.label;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Row(
                      children: [
                        Icon(
                          option.icon,
                          size: 19,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option.label,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.primary,
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 18),
              PrimaryButton(
                text: 'Apply',
                onPressed: () {
                  Navigator.pop(context, {
                    'category': _selectedCategory,
                    'sort': _selectedSort,
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryOption {
  final String label;
  final String emoji;
  final Color bgColor;
  final bool isGridIcon;

  const _CategoryOption(
      this.label,
      this.emoji,
      this.bgColor, {
        this.isGridIcon = false,
      });
}

class _SortOption {
  final String label;
  final IconData icon;

  const _SortOption(this.label, this.icon);
}