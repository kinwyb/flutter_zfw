import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/component.dart';

AddressAddSizeUtil _addressAddSizeUtil;

AddressAddSizeUtil getAddressAddSizeUtil() {
  if (_addressAddSizeUtil == null || isDebug) {
    _addressAddSizeUtil = new AddressAddSizeUtil();
  }
  return _addressAddSizeUtil;
}

class AddressAddSizeUtil {
  final containerPadding = EdgeInsets.only(
      top: Adapt.px(10), left: Adapt.px(20), right: Adapt.px(20));
  final labelContainerWidth = Adapt.px(160);
  final lineContainerPadding =
      EdgeInsets.only(top: Adapt.px(20), bottom: Adapt.px(20));
  final lineContainerDecoration = BoxDecoration(
    border: Border(bottom: BorderSide(width: 1, color: Colors.grey[300])),
  );
  final defaultTextStyle = TextStyle(
    fontSize: Adapt.px(32),
  );

  final defaultLineContainerMargin = EdgeInsets.only(top: Adapt.px(20));
  final defaultLineContainerPadding = EdgeInsets.only(
    left: Adapt.px(20),
    top: Adapt.px(20),
    right: Adapt.px(30),
    bottom: Adapt.px(20),
  );
  final defaultSwitchWidth = Adapt.px(90);

  final cityPickerHeight = Adapt.px(400);
  final saveContainerPadding = EdgeInsets.only(right: Adapt.px(20));
}
