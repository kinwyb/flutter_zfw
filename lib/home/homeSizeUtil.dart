import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/component.dart';

HomePageSizeUtil _homePageSizeUtil;

// 获取一个首页尺寸工具
HomePageSizeUtil getHomePageSizeUtil() {
  if (_homePageSizeUtil == null || isDebug) {
    _homePageSizeUtil = new HomePageSizeUtil();
  }
  return _homePageSizeUtil;
}

class HomePageSizeUtil {
  // 轮播图
  final bannerHeight = Adapt.px(360);
  // 热门品类
  final categoryIconContainerSize = Adapt.px(100);
  final categoryContainerHeight = Adapt.px(400);
  final categoryIconMargin = EdgeInsets.only(bottom: Adapt.px(10));
  final categoryGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    mainAxisSpacing: Adapt.px(20),
    crossAxisSpacing: Adapt.px(40),
    crossAxisCount: 4,
    childAspectRatio: 0.9,
  );
  final categoryGridPadding = EdgeInsets.all(Adapt.px(30));
  // 品牌
  final brandContainerHeight = Adapt.px(860);
  final brandContainerMargin = EdgeInsets.only(bottom: Adapt.px(40));
  final brandNameContainerHeight = Adapt.px(140);
  final brandImgSize = Adapt.px(100);
  final brandImgMargin =
      EdgeInsets.only(left: Adapt.px(20), right: Adapt.px(40));
  final brandShareContainerHeight = Adapt.px(60);
  final brandShareContainerWidth = Adapt.px(140);
  final brandShareMargin = EdgeInsets.only(right: Adapt.px(40));
  final brandProductContainerHeight = Adapt.px(720);
  final brandProductDefaultWidth = Adapt.px(460);
  final brandProductMargin = EdgeInsets.fromLTRB(
      Adapt.px(10), Adapt.px(20), Adapt.px(10), Adapt.px(20));
  final brandOneProductMargin = EdgeInsets.fromLTRB(
      Adapt.px(20), Adapt.px(20), Adapt.px(20), Adapt.px(20));
  final brandProductDetailHeight = Adapt.px(400);
  final brandProductTextContainerPadding = EdgeInsets.all(Adapt.px(20));
  final brandProductNameMargin = EdgeInsets.fromLTRB(0, 0, 0, Adapt.px(10));
  final brandProductNameTextStyle = TextStyle(
    fontSize: Adapt.px(30),
    fontWeight: FontWeight.bold,
  );
  final brandProductPriceTextStyle = TextStyle(
    fontSize: Adapt.px(32),
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
  final brandProductMarkPriceTextStyle = TextStyle(
    fontSize: Adapt.px(22),
    color: Colors.black26,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.lineThrough,
    decorationStyle: TextDecorationStyle.solid,
  );
  final brandProductSellingPointMargin = EdgeInsets.only(top: Adapt.px(10));
  final brandProductSellingPointPrefixTextStyle = TextStyle(
    fontSize: Adapt.px(32.0),
    color: Colors.yellow[900],
    fontWeight: FontWeight.bold,
  );
  final brandProductSellingPointTextStyle = TextStyle(
    fontSize: Adapt.px(24),
    color: Colors.black26,
    fontWeight: FontWeight.bold,
  );
}
