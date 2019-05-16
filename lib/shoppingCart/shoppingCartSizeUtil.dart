import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/component.dart';

ShoppingCartSizeUtil _shoppingCartSizeUtil;

ShoppingCartSizeUtil getShoppingCartSizeUtil() {
  if (_shoppingCartSizeUtil == null || isDebug) {
    _shoppingCartSizeUtil = new ShoppingCartSizeUtil();
  }
  return _shoppingCartSizeUtil;
}

class ShoppingCartSizeUtil {
  final bottomContainerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border(
      top: BorderSide(
        width: 0.5,
        color: Colors.grey,
      ),
    ),
  );
  final priceTextStyle = TextStyle(color: Colors.red, fontSize: Adapt.px(28));
  final tipContainerPadding = EdgeInsets.only(
      left: Adapt.px(40), top: Adapt.px(20), bottom: Adapt.px(20));
  final bottomContainerHeight = Adapt.px(100);
  final shopTopContainerPadding = EdgeInsets.all(Adapt.px(20));
  final shopTopContainerDecoration = BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)));
  final shopTopContainerHeight = Adapt.px(120);
  final shopTopEditPadding = EdgeInsets.all(Adapt.px(10));
  final shopContainerMargin = EdgeInsets.only(bottom: Adapt.px(40));
  final shopProductNameTextStyle = TextStyle(
    fontSize: Adapt.px(32),
    fontWeight: FontWeight.bold,
  );
  final shopProductMargin =
      EdgeInsets.only(top: Adapt.px(20), bottom: Adapt.px(20));
  final shopProductPadding =
      EdgeInsets.only(left: Adapt.px(20), right: Adapt.px(20));
  final shopProductTitleContainerMargin = EdgeInsets.only(left: Adapt.px(20));
  final shopProductAttrTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: Adapt.px(24),
  );
  final shopProductPriceIconTextStyle = TextStyle(
    color: Colors.red,
  );
  final shopProductPriceTextStyle = TextStyle(
    color: Colors.red,
    fontSize: Adapt.px(32),
    fontWeight: FontWeight.bold,
  );
  final shopProductHeight = Adapt.px(220);
  final shopProductNameHeight = Adapt.px(100);
  final shopProductPriceHeight = Adapt.px(80);
  final shopProductNumWidth = Adapt.px(200);
  final bottomContainerRightButtonWidth = Adapt.px(200);
  final bottomContainerRightButtonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: Adapt.px(32),
  );
}
