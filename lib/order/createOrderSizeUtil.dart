import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/component.dart';

CreateOrderSizeUtil _createOrderSizeUtil;

CreateOrderSizeUtil getCreateOrderSizeUtil() {
  if (_createOrderSizeUtil == null || isDebug) {
    _createOrderSizeUtil = new CreateOrderSizeUtil();
  }
  return _createOrderSizeUtil;
}

// 尺寸大小类
class CreateOrderSizeUtil {
  //区块底部间距
  var containerMargin = EdgeInsets.only(bottom: Adapt.px(20));

  //顶部提醒
  var topPadding = EdgeInsets.only(
      left: Adapt.px(40), top: Adapt.px(20), bottom: Adapt.px(20));
  var topPaddingFontSize = Adapt.px(30);

  //地址模块
  var addrPadding = EdgeInsets.fromLTRB(
      Adapt.px(40), Adapt.px(20), Adapt.px(40), Adapt.px(20));
  var addrFontText = TextStyle(
    fontSize: Adapt.px(32),
    fontWeight: FontWeight.bold,
  );
  var addrNamePhoneMargin = EdgeInsets.only(bottom: Adapt.px(10));

  //地址模块默认按钮
  var addrDefPadding =
      EdgeInsets.fromLTRB(Adapt.px(20), Adapt.px(4), Adapt.px(20), Adapt.px(4));
  var addrDefMargin =
      EdgeInsets.fromLTRB(0, Adapt.px(10), Adapt.px(60), Adapt.px(10));

  // 底部按钮栏
  var bottomHeight = Adapt.px(120);
  var bottomPadding = EdgeInsets.only(left: Adapt.px(40));
  var bottomLeftTextStyle = TextStyle(fontSize: Adapt.px(36));
  var bottomRightButtonPadding = EdgeInsets.all(Adapt.px(16));
  var bottomRightTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: Adapt.px(36),
  );

  // 优惠卷
  var couponHeight = Adapt.px(70);
  var couponLeftTextMargin =
      EdgeInsets.only(left: Adapt.px(40), right: Adapt.px(20));
  var couponCenterPadding = EdgeInsets.only(right: Adapt.px(20));
  var couponPadding = EdgeInsets.only(right: Adapt.px(20));

  // 店铺
  var shopPadding = EdgeInsets.only(
      left: Adapt.px(40),
      top: Adapt.px(20),
//      bottom: Adapt.px(20),
      right: Adapt.px(40));
  var shopNamePadding = EdgeInsets.only(bottom: Adapt.px(20));
  final shopProductNameTextStyle = TextStyle(
    fontSize: Adapt.px(30),
    fontWeight: FontWeight.bold,
  );
  final shopProductHeight = Adapt.px(220);
  final shopProductMargin = EdgeInsets.only(bottom: Adapt.px(20));
  final shopProductPadding = EdgeInsets.all(Adapt.px(20));
  final shopProductTitleContainerMargin = EdgeInsets.only(left: Adapt.px(20));
  final shopProductTitleHeight = Adapt.px(80);
  final shopProductAttrTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: Adapt.px(26),
  );
  final shopProductPriceHeight = Adapt.px(60);
  final shopProductPriceIconTextStyle = TextStyle(
    color: Colors.red,
  );
  final shopProductPriceTextStyle = TextStyle(
    color: Colors.red,
    fontSize: Adapt.px(30),
    fontWeight: FontWeight.bold,
  );
  final shopExtensionContainerHeight = Adapt.px(76);
  final shopExtensionContainerDecoration = BoxDecoration(
    border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[300])),
  );
  final shopMemoTextFieldMargin = EdgeInsets.only(left: Adapt.px(20));
  final shopLicensesHeight = Adapt.px(40);
  final shopLicensesTextStyle = TextStyle(
    fontSize: Adapt.px(28),
    color: Colors.blue,
  );
  final shopLicensesCheckBoxWidth = Adapt.px(28);
}
