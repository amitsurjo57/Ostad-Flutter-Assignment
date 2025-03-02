import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListUpdateController extends GetxController {
  static final List<Widget> _cartList = [];

  void addCart({required Widget widget}) {
    _cartList.add(widget);
    update();
  }

  void removeCart({required int index}) {
    _cartList.removeAt(index);
    update();
  }

  int getCartListLength() {
    return _cartList.length;
  }

  Widget getCart({required int index}) {
    return _cartList[index];
  }
}
