import 'package:flutter/material.dart';
import 'package:zfw/components/api/beans/user.dart';
import 'package:zfw/components/api/shoppingCart.dart';

export './iconTitle.dart';
export './input.dart';
export './refresh.dart';
export './modal.dart';
export './checkBox.dart';
export 'package:zfw/components/api/beans/user.dart';
export 'package:zfw/components/api/shoppingCart.dart';

// 是否显示性能图
final bool showPerformanceOverlay = false;
final Duration toastDuration = Duration(seconds: 3);
final yes = 'Y';
final no = 'N';

UserAddressInfo addrInfo; //地址信息
bool shoppingCartOrder = false; //购物车订单
ShoppingCartOrderAddReq orderReq; // 订单信息

void initData() async {
  // 加载默认地址
}

TextStyle textStyleColor(Color color) {
  return TextStyle(color: color);
}

// 点击
Widget onTap(Widget child, [GestureTapCallback onTap]) {
  return GestureDetector(
    onTap: onTap,
    child: child,
  );
}
