import 'package:demo_proj/features/auth/screen/home/widget/shimmer_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: 6,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: index.isEven ? 70 : 0),
          child: const ShimmerProductCard(),
        );
      },
    );
  }
}
