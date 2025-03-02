import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListUpdateController extends GetxController {
  static final List<Widget> _wishList = [];

  void addWish({required Widget widget}) {
    _wishList.add(widget);
    update();
  }

  void removeWish({required int index}) {
    _wishList.removeAt(index);
    update();
  }

  Widget getWish({required int index}) {
    return _wishList[index];
  }

  int getWishListLength() {
    return _wishList.length;
  }
}
