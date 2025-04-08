import 'package:flutter/material.dart';
import 'package:st4_tuan5_trancongmanh/model/SpendingEntry.dart';

class CategoryFilter extends StatelessWidget {
  final SpendingCategory? selectedCategory;
  final Function(SpendingCategory?) onCategorySelected;

  const CategoryFilter({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildCategoryItem(context, null, 'All', Icons.apps, Colors.grey),
          ...SpendingCategory.values.map((category) {
            final entry = SpendingEntry(
              content: '',
              amount: 0,
              category: category,
              date: DateTime.now(),
            );

            return _buildCategoryItem(
              context,
              category,
              category.toString().split('.').last,
              entry.categoryIcon,
              entry.categoryColor,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    SpendingCategory? category,
    String label,
    IconData icon,
    Color color,
  ) {
    final isSelected =
        category == selectedCategory ||
        (category == null && selectedCategory == null);

    return GestureDetector(
      onTap: () {
        onCategorySelected(category);
      },
      child: Container(
        width: 80,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? color : color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : color,
                size: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? color : Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
