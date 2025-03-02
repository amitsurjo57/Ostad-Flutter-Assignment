import 'dart:async';
import 'package:e_commerce_project/App%20Assets/app_logo.dart';
import 'package:e_commerce_project/App%20Assets/app_assets.dart';
import 'package:e_commerce_project/App%20Widgets/my_circular_progress_indicator.dart';
import 'package:e_commerce_project/App%20Widgets/product_card.dart';
import 'package:e_commerce_project/App%20Widgets/product_type.dart';
import 'package:e_commerce_project/App%20Widgets/product_selled_type.dart';
import 'package:e_commerce_project/App%20Widgets/slider_widget.dart';
import 'package:e_commerce_project/Main%20Body/category_screen.dart';
import 'package:e_commerce_project/Networks/network_caller.dart';
import 'package:e_commerce_project/Networks/network_response.dart';
import 'package:e_commerce_project/Networks/network_utils.dart';
import 'package:e_commerce_project/Starting%20Body/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;

  final NetworkCaller _networkCaller = NetworkCaller();

  late PageController _pageController;

  List _listOfSlider = [];

  List _categoryListOfProduct = [];

  bool _inProgress = false;


  void _autoSlidesToNextSlider() {
    _pageController = PageController(initialPage: 0);
    Timer.periodic(
      const Duration(seconds: 2),
      (_) {
        try{
          if (_pageController.page == _listOfSlider.length - 1) {
            _pageController.jumpToPage(_pageController.initialPage);
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          }
        }catch(_){
          _autoSlidesToNextSlider();
        }
      },
    );
  }

  Future<void> _sliderList() async {
    _inProgress = true;
    setState(() {});
    NetworkResponse response =
        await _networkCaller.getRequest(NetworkUtils.sliderList);

    setState(() {
      if (response.isSuccess) {
        _listOfSlider = response.responseData['data']['results'];
        _inProgress = false;
      }
    });
  }

  Future<void> _productCategoryList() async {
    _inProgress = true;
    setState(() {});
    NetworkResponse response =
        await _networkCaller.getRequest(NetworkUtils.categoryList);

    setState(() {
      if (response.isSuccess) {
        _categoryListOfProduct = response.responseData['data'];
        _inProgress = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _sliderList();
    _autoSlidesToNextSlider();
    _productCategoryList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            AppLogo.appNavLogo,
          ),
        ),
        leadingWidth: 160,
        actions: [
          InkWell(
            onTap: () {
              // UserAuth userAuth = UserAuth();
              Navigator.pushNamed(context, SignUpScreen.route);
            },
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person_outline, size: 20),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.phone_outlined, size: 20),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.notifications_active, size: 20),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _searchBar(),
              _slider(),
              _allCategories(),
              _popularProduct(),
              _specialProduct(),
              _newProduct(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _slider() {
    return Visibility(
      visible: !_inProgress,
      replacement: const MyCircularProgressIndicator(),
      child: Column(
        spacing: 20,
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 160,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _listOfSlider.length,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SliderWidget(
                    image: _listOfSlider[index]['photo_url'],
                    onTapBuyNow: () {},
                  ),
                ),
              ),
            ),
          ),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < _listOfSlider.length; i++)
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  height: 14,
                  width: _currentPage == i ? 40 : 14,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primary.withAlpha(32),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  SearchBar _searchBar() {
    return SearchBar(
      hintText: "Search",
      leading: const Icon(Icons.search),
      constraints: const BoxConstraints(minHeight: 48),
      textInputAction: TextInputAction.search,
      padding: WidgetStateProperty.all(
        const EdgeInsets.only(left: 12),
      ),
    );
  }

  Widget _allCategories() {
    return Visibility(
      visible: !_inProgress,
      replacement: const MyCircularProgressIndicator(),
      child: ProductSelledType(
        productSelledType: "All Categories",
        onSeeAll: () {
          Navigator.pushNamed(
            context,
            CategoryScreen.route,
          );
        },
        widget: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: _categoryListOfProduct.map(
              (e) {
                return ProductType(
                  onTap: () {},
                  image: e['categoryImg'],
                  type: e['categoryName'],
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }

  Widget _popularProduct() {
    return ProductSelledType(
      onSeeAll: () {},
      productSelledType: "Popular",
      widget: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 1; i <= 3; i++)
              const ProductCard(
                productImage: AppAssets.shoeImage,
                productName: "New Year Special shoe 30",
                productPrice: 100,
                rating: 4.8,
              ),
          ],
        ),
      ),
    );
  }

  Widget _specialProduct() {
    return ProductSelledType(
      onSeeAll: () {},
      productSelledType: "Special",
      widget: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 1; i <= 3; i++)
              const ProductCard(
                productImage: AppAssets.shoeImage,
                productName: "New Year Special shoe 30",
                productPrice: 100,
                rating: 4.8,
              ),
          ],
        ),
      ),
    );
  }

  Widget _newProduct() {
    return ProductSelledType(
      onSeeAll: () {},
      productSelledType: "New",
      widget: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 1; i <= 3; i++)
              const ProductCard(
                productImage: AppAssets.shoeImage,
                productName: "New Year Special shoe 30",
                productPrice: 100,
                rating: 4.8,
              ),
          ],
        ),
      ),
    );
  }
}
