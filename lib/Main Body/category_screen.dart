import 'package:e_commerce_project/App%20Widgets/my_circular_progress_indicator.dart';
import 'package:e_commerce_project/App%20Widgets/product_type.dart';
import 'package:e_commerce_project/Main%20Body/electronics_screen.dart';
import 'package:e_commerce_project/Networks/network_caller.dart';
import 'package:e_commerce_project/Networks/network_response.dart';
import 'package:e_commerce_project/Networks/network_utils.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const String route = "category-screen";

  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List _categoryListOfProduct = [];

  bool _inProgress = false;

  Future<void> _productCategoryList() async {
    _inProgress = true;
    setState(() {});
    NetworkResponse response =
        await NetworkCaller().getRequest(NetworkUtils.categoryList);

    setState(() {
      if (response.isSuccess) {
        _categoryListOfProduct = response.responseData['data'];
        _inProgress = false;
      }
    });
  }

  @override
  void initState() {
    _productCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: Visibility(
        visible: !_inProgress,
        replacement: const MyCircularProgressIndicator(),
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 108,
            mainAxisSpacing: 20,
          ),
          itemCount: _categoryListOfProduct.length,
          itemBuilder: (context, index) => ProductType(
            image: _categoryListOfProduct[index]['categoryImg'],
            type: _categoryListOfProduct[index]['categoryName'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ElectronicsScreen(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
