import 'package:flutter/material.dart';
import 'package:zfw/components/api/beans/user.dart';
import 'package:zfw/components/api/shoppingCart.dart';

export './iconTitle.dart';
export './input.dart';
export './bottomNavigationBar.dart';
export './refresh.dart';
export './modal.dart';
export './checkBox.dart';
export 'package:zfw/components/api/beans/user.dart';
export 'package:zfw/components/api/shoppingCart.dart';

// 是否显示性能图
final bool showPerformanceOverlay = false;
final Duration toastDuration = Duration(seconds: 3);

UserAddressInfo addrInfo; //地址信息
bool shoppingCartOrder = false; //购物车订单
ShoppingCartOrderAddReq orderReq; // 订单信息

TextStyle textStyleColor(Color color) {
  return TextStyle(color: color);
}

// 点击
Widget onTap(Widget child, [GestureTapCallback onTap = null]) {
  return GestureDetector(
    onTap: onTap,
    child: child,
  );
}
