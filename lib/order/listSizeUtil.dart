import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zfw/components/adapt.dart';

ListSizeUtil _listSizeUtil;

ListSizeUtil getListSizeUtil() {
//  if(_listSizeUtil == null) {
  _listSizeUtil = new ListSizeUtil();
//  }
  return _listSizeUtil;
}

// 尺寸大小类
class ListSizeUtil {
  final defaultFontTextStyle = TextStyle(
    fontSize: Adapt.px(30),
  );
  final tabBarPadding = EdgeInsets.all(Adapt.px(20));
  final tabBarIndicator = BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(Adapt.px(40)),
  );
  final tabViewContainerPadding =
      EdgeInsets.fromLTRB(Adapt.px(10), Adapt.px(20), Adapt.px(10), 0);

  final orderCartStateMsgContanierMargin = EdgeInsets.only(left: Adapt.px(20));
  final orderCartShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(Adapt.px(20))),
  );
  final orderCartMargin = EdgeInsets.only(bottom: Adapt.px(10));
  final orderStateMsgTextStyle = TextStyle(
    color: Colors.red,
  );
  final orderTopDecoration = BoxDecoration(
    border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
  );
  final orderTopContainerPadding = EdgeInsets.only(bottom: Adapt.px(10));
  final orderItemProductNameTextStyle = TextStyle(
    fontSize: Adapt.px(32),
    fontWeight: FontWeight.bold,
  );
  final orderItemProductMargin =
      EdgeInsets.only(top: Adapt.px(20), bottom: Adapt.px(20));
  final orderItemProductTitleContainerMargin =
      EdgeInsets.only(left: Adapt.px(20));
  final orderItemProductAttrTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: Adapt.px(28),
  );
  final orderItemProductPriceIconTextStyle = TextStyle(
    color: Colors.red,
  );
  final orderItemProductContainerHeight = Adapt.px(200);
  final orderItemProductPriceTextStyle = TextStyle(
    color: Colors.red,
    fontSize: Adapt.px(34),
    fontWeight: FontWeight.bold,
  );
  final orderTotalTextMargin = EdgeInsets.only(top: Adapt.px(20));
  final orderButtonMargin = EdgeInsets.only(left: Adapt.px(20));
  final orderButtonShape = RoundedRectangleBorder(
    side: BorderSide(
      width: 1,
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.circular(Adapt.px(40)),
  );
  final orderButtonShape2 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Adapt.px(40)),
  );
  final orderButtonContainerHeight = Adapt.px(56);
}
