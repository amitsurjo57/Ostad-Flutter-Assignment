import 'package:e_commerce_project/Main%20Body/cart_screen.dart';
import 'package:e_commerce_project/Main%20Body/category_screen.dart';
import 'package:e_commerce_project/Main%20Body/home_screen.dart';
import 'package:e_commerce_project/Main%20Body/wish_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String route = "main_screen";

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int startingIndex = 0;

  final List<Widget> listOfScreen = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const WishScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: startingIndex,
        onDestinationSelected: (index){
          setState(() {
            startingIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            label: "Category",
          ),
          NavigationDestination(
            icon: Icon(Icons.add_shopping_cart_outlined),
            label: "Cart",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline_outlined),
            label: "Wish",
          ),

        ],
      ),
      body: listOfScreen[startingIndex],
    );
  }
}
