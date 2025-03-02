import 'package:e_commerce_project/App%20Assets/app_assets.dart';
import 'package:e_commerce_project/App%20Widgets/product_card.dart';
import 'package:flutter/material.dart';

class ElectronicsScreen extends StatelessWidget {
  static const route = "electronic-screen";

  const ElectronicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Electronics"),
      ),
      body: GridView.builder(
        itemCount: 15,
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 120,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) => const ProductCard(
          productImage: AppAssets.shoeImage,
          productName: "New Year Special shoe 30",
          productPrice: 100,
          rating: 4.8,
        ),
      ),
    );
  }
}
