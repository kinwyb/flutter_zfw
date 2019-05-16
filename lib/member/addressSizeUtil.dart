import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';

AddressSizeUtil _addressSizeUtil;

AddressSizeUtil getAddressSizeUtil() {
//  if(_addressSizeUtil == null) {
  _addressSizeUtil = new AddressSizeUtil();
//  }
  return _addressSizeUtil;
}

class AddressSizeUtil {
  final itemContainerMargin = EdgeInsets.only(top: Adapt.px(20));
  final itemContainerPadding =
      EdgeInsets.only(top: Adapt.px(30), bottom: Adapt.px(20));
  final itemContainerUpContainerDecoration = BoxDecoration(
      border: Border(bottom: BorderSide(width: 1, color: Colors.grey[300])));
  final itemContainerUpContainerPadding =
      EdgeInsets.only(left: Adapt.px(40), right: Adapt.px(40));
  final itemContainerNamePhoneTextStyle = TextStyle(
    fontSize: Adapt.px(38),
    fontWeight: FontWeight.bold,
  );
  final itemContainerNamePhoneContainerMargin =
      EdgeInsets.only(bottom: Adapt.px(20));
  final itemContainerAddrTextStyle = TextStyle(
    fontSize: Adapt.px(30),
  );
  final itemContainerAddrPadding = EdgeInsets.only(bottom: Adapt.px(20));

  final itemContainerDownPadding = EdgeInsets.only(
      top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20));
  final itemContainerDownHeight = Adapt.px(100);
  final itemContainerDownButtonWidth = Adapt.px(180);
  final itemContainerDownButtonPadding =
      EdgeInsets.fromLTRB(Adapt.px(10), Adapt.px(4), Adapt.px(10), Adapt.px(4));
  final itemContainerDownButtonEditShape = RoundedRectangleBorder(
      side: BorderSide(width: 0.5, color: Colors.grey),
      borderRadius: borderRadiusCircular);

  final bottomContainerPadding = EdgeInsets.all(Adapt.px(20));
  final bottomContainerTextStyle = TextStyle(
    color: Colors.white,
    fontSize: Adapt.px(36),
  );
}
