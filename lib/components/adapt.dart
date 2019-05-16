import 'package:flutter/material.dart';
import 'dart:ui';

final borderRadiusCircular = BorderRadius.circular(50);
final defaultFontTextStyle = TextStyle(
  fontSize: Adapt.px(28),
);
final whiteFontTextStyle = TextStyle(
  color: Colors.white,
);
final redFontTextStyle = TextStyle(
  color: Colors.red,
);

final defaultIconSize = Adapt.px(36);

MediaQueryData mediaQuery;
double _width;
double _height;
double _topbarH;
double _botbarH;
double _pixelRatio;
double _ratio = 0;

final _uiSize = 750;

class Adapt {
  static init(int number) {
    mediaQuery = MediaQueryData.fromWindow(window);
    int uiwidth = number is int ? number : _uiSize;
    _width = mediaQuery.size.width;
    _height = mediaQuery.size.height;
    _topbarH = mediaQuery.padding.top;
    _botbarH = mediaQuery.padding.bottom;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _ratio = _width / uiwidth;
  }

  static px(number) {
    if (_ratio == 0 || !(_ratio is double || _ratio is int)) {
      Adapt.init(_uiSize);
    }
    return number * (_ratio == 0 ? 0.5 : _ratio);
  }

  static onepx() {
    return 1 / _pixelRatio;
  }

  static screenW() {
    return _width;
  }

  static screenH() {
    return _height;
  }

  static padTopH() {
    return _topbarH;
  }

  static padBotH() {
    return _botbarH;
  }
}
