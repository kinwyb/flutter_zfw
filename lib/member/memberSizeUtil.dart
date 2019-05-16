import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/component.dart';

MemberSizeUtil _memberSizeUtil;

MemberSizeUtil getMemberSizeUtil() {
  if (_memberSizeUtil == null || isDebug) {
    _memberSizeUtil = new MemberSizeUtil();
  }
  return _memberSizeUtil;
}

class MemberSizeUtil {
  final defaultFontSizeTextStyle = TextStyle(
    fontSize: Adapt.px(28),
    color: Colors.grey[700],
  );
  final defaultContainerMargin = EdgeInsets.only(bottom: Adapt.px(20));

  final fontTitleTextStyle = TextStyle(
    fontSize: Adapt.px(32),
    fontWeight: FontWeight.bold,
  );
  final orderWidgetBottomBorder = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 1,
        color: Colors.grey,
      ),
    ),
  );
  // 顶部top
  final topContainerHeight = Adapt.px(300);
  final topContainerPadding = EdgeInsets.all(Adapt.px(20));
  final topContainerPortraitHeight = Adapt.px(140);
  final topContainerPortraitMargin = EdgeInsets.only(left: Adapt.px(40));
  final topContainerUserNameMargin =
      EdgeInsets.only(left: Adapt.px(20), top: Adapt.px(54));
  final topContainerWaitSettliementMoneyMargin =
      EdgeInsets.only(left: Adapt.px(20), top: Adapt.px(10));
  final topContainerPhoneMargin =
      EdgeInsets.only(top: Adapt.px(50), right: Adapt.px(30));
  final topContainerPhoneIconSize = Adapt.px(24);
  final topContainerUserNameTextStyle = TextStyle(
    fontSize: Adapt.px(36),
    fontWeight: FontWeight.bold,
  );
  final topContainerPriceTextStyle = TextStyle(
    fontSize: Adapt.px(30),
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
  // 提现
  final withdrawContainerHeight = Adapt.px(180);
  final withdrawContainerPadding = EdgeInsets.fromLTRB(
      Adapt.px(40), Adapt.px(20), Adapt.px(40), Adapt.px(30));
  final withdrawContainerTopLabelPadding =
      EdgeInsets.only(top: Adapt.px(20), bottom: Adapt.px(10));
  final withdrawContainerButtonHeight = Adapt.px(60);
  final withdrawContainerButtonWidth = Adapt.px(140);
  final withdrawContainerButtonMargin = EdgeInsets.only(top: Adapt.px(26));
  // 订单
  final orderContainerPadding = EdgeInsets.only(
      left: Adapt.px(40), right: Adapt.px(40), bottom: Adapt.px(20));
  final orderContainerTopLabelPadding =
      EdgeInsets.only(top: Adapt.px(30), bottom: Adapt.px(10));
  final orderContainerTopLabelMargin = EdgeInsets.only(bottom: Adapt.px(10));
  final orderContainerIconTitleHeight = Adapt.px(120);
  // 底部icons
  final bottomIconsContainerMargin = EdgeInsets.only(bottom: Adapt.px(40));
  final bottomIconsContainerPadding = EdgeInsets.all(Adapt.px(20));
  final bottomIconSize = Adapt.px(50);
}
