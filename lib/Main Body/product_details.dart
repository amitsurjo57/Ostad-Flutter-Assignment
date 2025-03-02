import 'dart:async';
import 'package:e_commerce_project/App%20Assets/app_assets.dart';
import 'package:e_commerce_project/App%20Utils/Cart%20and%20Wish%20List/cart_list_update_controller.dart';
import 'package:e_commerce_project/App%20Utils/Cart%20and%20Wish%20List/wish_list_update_controller.dart';
import 'package:e_commerce_project/App%20Utils/app_utils.dart';
import 'package:e_commerce_project/App%20Widgets/product_card.dart';
import 'package:e_commerce_project/App%20Widgets/product_cart_widget.dart';
import 'package:e_commerce_project/Main%20Body/review_screen.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  static const String route = "product_details";

  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _currentPage = 0;

  int _currentColor = 0;

  int _currentSize = 0;

  final String _productDetails =
      "Reference site about Lorem lpsum, giving information on its"
      "origins, as well a random Lpsum generator Reference site"
      "about Lorem lpsum, giving information on its origins, as well as"
      "a random Lpsum generator";

  final CartListUpdateController _listUpdateController =
      CartListUpdateController();
  final WishListUpdateController _wishListUpdateController =
      WishListUpdateController();
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _slidingProduct();
  }

  void _slidingProduct() {
    Timer.periodic(
      const Duration(seconds: 2),
      (_) {
        if (_pageController.page == 3) {
          _pageController.jumpToPage(_pageController.initialPage);
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNavBar(context),
      body: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            _productImages(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _productProperties(context),
                  _productColor(context),
                  _productSize(context),
                  _productDescription(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildBottomNavBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(32),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Price\n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "\$1000",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                _listUpdateController.addCart(
                  widget: const ProductCartWidget(),
                );
              },
              color: Theme.of(context).colorScheme.primary,
              child: const Text(
                "Add To Cart",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Product Details"),
      forceMaterialTransparency: true,
      titleTextStyle: const TextStyle(
        backgroundColor: Colors.transparent,
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

  Widget _productDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
        ),
        Text(
          _productDetails,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        )
      ],
    );
  }

  Column _productSize(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
        ),
        Row(
          spacing: 12,
          children: [
            for (int i = 0; i < AppUtils.listOfProductSize.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentSize = i;
                  });
                },
                child: CircleAvatar(
                  radius: 16,
                  foregroundColor:
                      _currentSize == i ? Colors.white : Colors.black,
                  backgroundColor: _currentSize == i
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade200,
                  child: Text(
                    AppUtils.listOfProductSize[i],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }

  Column _productColor(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
        ),
        Row(
          spacing: 12,
          children: [
            for (int i = 0; i < AppUtils.listOfProductColor.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentColor = i;
                  });
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppUtils.listOfProductColor[i],
                  child: _currentColor == i
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
          ],
        )
      ],
    );
  }

  Widget _productProperties(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Happy New Year Special Deal\nSave 30%",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              spacing: 12,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  color: Theme.of(context).colorScheme.primary,
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "01",
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  width: 24,
                  height: 24,
                  color: Theme.of(context).colorScheme.primary,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          spacing: 16,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.star,
                  size: 28,
                  color: Colors.orangeAccent,
                ),
                Text(
                  "4.8",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ReviewScreen.route);
              },
              child: const Text(
                "Reviews",
                style: TextStyle(fontSize: 16),
              ),
            ),
            InkWell(
              onTap: () {
                _wishListUpdateController.addWish(
                  widget: const ProductCard(
                    productImage: AppAssets.shoeImage,
                    productName: "New Year Special shoe 30",
                    productPrice: 100,
                    rating: 4.8,
                  ),
                );
              },
              child: Container(
                width: 24,
                height: 24,
                color: Theme.of(context).colorScheme.primary,
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_outline,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productImages(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return Image.network(AppAssets.shoeImage);
            },
          ),
          Positioned(
            top: 200,
            left: MediaQuery.sizeOf(context).width / 4,
            child: Row(
              spacing: 12,
              children: [
                for (int i = 0; i < 4; i++)
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    height: 6,
                    width: 40,
                    decoration: BoxDecoration(
                      color: _currentPage == i
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      
                      borderRadius: BorderRadius.circular(30)
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
