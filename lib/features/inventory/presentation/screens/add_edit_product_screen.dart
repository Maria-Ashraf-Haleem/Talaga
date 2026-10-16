import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/models/product_item.dart';

class AddEditProductScreen extends StatefulWidget {
  final ProductItem? product;

  const AddEditProductScreen({
    super.key,
    this.product,
  });

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _minQuantityController;
  late TextEditingController _expiryController;
  late TextEditingController _notesController;

  String _selectedCategory = 'Fruits';
  String _selectedUnit = 'kg';

  final List<String> _categories = const [
    'Fruits',
    'Vegetables',
    'Dairy',
    'Meat',
    'Grains',
    'Beverages',
    'Other',
  ];

  final List<String> _units = const [
    'kg',
    'g',
    'liter',
    'pieces',
    'pack',
  ];

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameController = TextEditingController(text: p?.name ?? '');
    _quantityController = TextEditingController(text: p?.quantity ?? '1');
    _minQuantityController = TextEditingController(
      text: p != null ? p.minQuantity.split(' ').first : '',
    );
    _expiryController = TextEditingController(
      text: p?.expiryDateFormatted ?? '',
    );
    _notesController = TextEditingController(text: p?.notes ?? '');

    if (p != null && _categories.contains(p.category)) {
      _selectedCategory = p.category;
    }
    if (p != null && _units.contains(p.unit)) {
      _selectedUnit = p.unit;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _minQuantityController.dispose();
    _expiryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 5)),
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _expiryController.text =
        '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        isEditing ? 'Edit Product' : 'Add Product',
                        style: AppTextStyles.h2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 12),

              // Main Form Container Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add Photo Box
                    Container(
                      width: double.infinity,
                      height: 96,
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.textSecondary,
                            size: 28,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Add Photo',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Product Name
                    const _FieldLabel('Product Name'),
                    const SizedBox(height: 6),
                    CustomTextField(
                      hintText: 'e.g. Tomatoes',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 14),

                    // Category Dropdown
                    const _FieldLabel('Category'),
                    const SizedBox(height: 6),
                    _DropdownContainer(
                      value: _selectedCategory,
                      items: _categories,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedCategory = val);
                        }
                      },
                    ),
                    const SizedBox(height: 14),

                    // Quantity & Unit Row
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _FieldLabel('Quantity'),
                              const SizedBox(height: 6),
                              CustomTextField(
                                hintText: '1',
                                keyboardType: TextInputType.number,
                                controller: _quantityController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _FieldLabel('Unit'),
                              const SizedBox(height: 6),
                              _DropdownContainer(
                                value: _selectedUnit,
                                items: _units,
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() => _selectedUnit = val);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Minimum Quantity
                    const _FieldLabel('Minimum Quantity'),
                    const SizedBox(height: 6),
                    CustomTextField(
                      hintText: 'e.g. 2',
                      keyboardType: TextInputType.number,
                      controller: _minQuantityController,
                    ),
                    const SizedBox(height: 14),

                    // Expiry Date
                    const _FieldLabel('Expiry Date'),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: _pickDate,
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: 'Select date',
                          controller: _expiryController,
                          suffixIcon: const Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Notes (Optional)
                    const _FieldLabel('Notes (Optional)'),
                    const SizedBox(height: 6),
                    CustomTextField(
                      hintText: 'e.g. brand, storage place, etc.',
                      controller: _notesController,
                    ),
                    const SizedBox(height: 20),

                    // Save Product Button
                    PrimaryButton(
                      text: 'Save Product',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product saved successfully!'),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _DropdownContainer extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownContainer({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
          items: items
              .map(
                (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}