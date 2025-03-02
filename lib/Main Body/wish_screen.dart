import 'package:e_commerce_project/App%20Assets/app_assets.dart';
import 'package:e_commerce_project/App%20Widgets/product_card.dart';
import 'package:flutter/material.dart';

class WishScreen extends StatefulWidget {
  const WishScreen({super.key});

  @override
  State<WishScreen> createState() => _WishScreenState();
}

class _WishScreenState extends State<WishScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Wish List"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 14,
        ),
        itemBuilder: (context, index) {
          return const ProductCard(
            productImage: AppAssets.shoeImage,
            productName: "New Year Special shoe 30",
            productPrice: 100,
            rating: 4.8,
          );
        },
      ),
    );
  }
}
