import 'package:flutter/material.dart';

export './iconTitle.dart';
export './input.dart';
export './bottomNavigationBar.dart';
export './refresh.dart';
export './modal.dart';

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
