import 'package:flutter/material.dart';

class IconTitle extends StatelessWidget {
  Text title;
  Icon icon;
  Color backgroundColor;
  GestureTapCallback onTap;

  IconTitle({Key key, 
  @required this.icon,
   this.title, 
   this.backgroundColor,
   this.onTap})
      : assert(icon != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    if (title == null) {
      //没有标题直接是一个Icon
      return this.icon;
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: backgroundColor,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: icon,
                ),
              ),
              Expanded(
                flex: 2,
                child: title
              ),
            ],
          ),
        ),
      );
    }
  }
}

class Buttom extends StatelessWidget {

  List<Widget> children;

  GestureTapCallback onTap;
  Color backgroundColor;
  Decoration decoration;

  Buttom({Key key,
  @required this.children,
  this.onTap,
  this.backgroundColor,
  this.decoration}):assert(children != null),super(key:key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        decoration: decoration,
        alignment: Alignment.center,
        child: Wrap(
          children: children,
        ),
      ),
    );
  }

}