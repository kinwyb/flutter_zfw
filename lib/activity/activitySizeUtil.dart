import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/component.dart';

ActivitySizeUtil _activitySizeUtil;

ActivitySizeUtil getActivitySizeUtil() {
  if (_activitySizeUtil == null || isDebug) {
    _activitySizeUtil = new ActivitySizeUtil();
  }
  return _activitySizeUtil;
}

class ActivitySizeUtil {
  final titleContainerPadding = EdgeInsets.all(Adapt.px(20));
  final titleContainerMargin = EdgeInsets.only(bottom: Adapt.px(20));
  final titleContainerCollectHeight = Adapt.px(100);
  final titleContainerCollectPadding = EdgeInsets.only(top: Adapt.px(10));
  final titleContainerCollectTextStyle = TextStyle(fontSize: Adapt.px(26));
  final titleContainerNamePadding = EdgeInsets.only(bottom: Adapt.px(10));
  final titleContainerNameTextStyle = TextStyle(
    fontSize: Adapt.px(36),
    fontWeight: FontWeight.w600,
  );
  final titleContainerSellingPointTextStyle = TextStyle(
    fontSize: Adapt.px(26),
    color: Colors.black45,
  );
  final titleContainerPrefixPriceTextStyle = TextStyle(
      fontSize: Adapt.px(36),
      color: Colors.red[500],
      fontWeight: FontWeight.w600);
  final titleContainerPriceTextStyle = TextStyle(
    fontSize: Adapt.px(50),
  );
  final titleContainerMarkPriceTextStyle = TextStyle(
    color: Colors.black45,
    fontSize: Adapt.px(26),
    decoration: TextDecoration.lineThrough,
    decorationStyle: TextDecorationStyle.solid,
  );
  final titleContainerTagPadding =
      EdgeInsets.fromLTRB(Adapt.px(20), Adapt.px(6), Adapt.px(20), Adapt.px(6));
  final titleContainerTagMargin =
      EdgeInsets.only(top: Adapt.px(20), right: Adapt.px(20));
  final titleContainerTagTextStyle = TextStyle(
    color: Colors.red,
    fontSize: Adapt.px(26),
  );
  final imgContainerHeight = Adapt.px(680);

  final bottomIconTextStyle = TextStyle(fontSize: Adapt.px(20));
  final bottomIconSize = Adapt.px(40);
  final bottomHeight = Adapt.px(100);
  final bottomButtonTextStyle =
      TextStyle(color: Colors.white, fontSize: Adapt.px(30));

  final templateTextStyle =
      TextStyle(fontSize: Adapt.px(28), color: Colors.grey[700]);
  final templateShowModalPadding = EdgeInsets.fromLTRB(
      Adapt.px(20), Adapt.px(40), Adapt.px(20), Adapt.px(60));
  final templateContainerPadding = EdgeInsets.all(Adapt.px(20));
  final templateContainerMargin = EdgeInsets.only(bottom: Adapt.px(20));
  final templateContainerIconWidth = Adapt.px(40);
  final templateShowModalContainerPadding =
      EdgeInsets.only(bottom: Adapt.px(20));
  final templateShowModalContainerMargin =
      EdgeInsets.only(bottom: Adapt.px(10));
  final templateShowModalContainerTitleTextStyle =
      TextStyle(fontSize: Adapt.px(44));
  final templateShowModalContainerContentMargin =
      EdgeInsets.only(top: Adapt.px(10), bottom: Adapt.px(10));
  final templateShowModalContainerContentTitlePadding = EdgeInsets.fromLTRB(
      Adapt.px(20), Adapt.px(20), Adapt.px(20), Adapt.px(10));
  final templateShowModalContainerContentTitleTextStyle =
      TextStyle(fontSize: Adapt.px(36), color: Colors.black);
  final templateShowModalContainerContentDataTextStyle =
      TextStyle(fontSize: Adapt.px(32), color: Colors.grey);
  final templateShowModalContainerContentDataPadding =
      EdgeInsets.fromLTRB(Adapt.px(44), 0, Adapt.px(44), 0);
  final tabBarHeight = Adapt.px(72);
}
