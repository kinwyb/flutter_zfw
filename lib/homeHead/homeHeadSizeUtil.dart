import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/component.dart';

HomeHeadSizeUtil _homeHeadSizeUtil;

HomeHeadSizeUtil getHomeHeadSizeUtil() {
  if (_homeHeadSizeUtil == null || isDebug) {
    _homeHeadSizeUtil = new HomeHeadSizeUtil();
  }
  return _homeHeadSizeUtil;
}

class HomeHeadSizeUtil {
  final itemRowBoxDecoration = BoxDecoration(
    color: Colors.white,
    border: Border(
      bottom: BorderSide(width: 1, color: Colors.grey),
    ),
  );
  final myFansCountTextStyle = TextStyle(fontSize: 20);
  final topTextTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  final priceTextStyle = TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  final helpTitleTextStyle = TextStyle(
    color: Colors.red,
    fontSize: 18,
  );
}
