import 'package:demo_proj/features/auth/screen/home/model/categoy_model.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback ontap;
  final bool isSelected;
  const CategoryCard({
    super.key,
    required this.category,
    required this.ontap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 90,
        margin: EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isSelected ? const Color(0xff4c7a3d) : Colors.white,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xff4c7a3d)
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(category.imageUrl, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 8),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xff4c7a3d) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
