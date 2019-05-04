import 'package:flutter/material.dart';

class IconTitle extends StatelessWidget {
  Text title;
  Icon icon;
  Color backgroundColor;
  GestureTapCallback onTap;

  IconTitle(
      {Key key,
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
              Expanded(flex: 2, child: title),
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

  Buttom(
      {Key key,
      @required this.children,
      this.onTap,
      this.backgroundColor,
      this.decoration})
      : assert(children != null),
        super(key: key);

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

class CustomerButton extends MaterialButton {
  const CustomerButton({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    double height,
    double minWidth,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    double elevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration,
    Widget child,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        super(
          key: key,
          onPressed: onPressed,
          onHighlightChanged: onHighlightChanged,
          textTheme: textTheme,
          textColor: textColor,
          height: height,
          minWidth: minWidth,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          elevation: elevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          padding: padding,
          shape: shape,
          clipBehavior: clipBehavior,
          materialTapTargetSize: materialTapTargetSize,
          animationDuration: animationDuration,
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ButtonThemeData buttonTheme = ButtonTheme.of(context);
    return RawMaterialButton(
      onPressed: onPressed,
      onHighlightChanged: onHighlightChanged,
      fillColor: color,
      textStyle: theme.textTheme.button.copyWith(color: buttonTheme.getTextColor(this)),
      highlightColor: highlightColor ?? theme.highlightColor,
      splashColor: splashColor ?? theme.splashColor,
      elevation: buttonTheme.getElevation(this),
      highlightElevation: buttonTheme.getHighlightElevation(this),
      padding: buttonTheme.getPadding(this),
      constraints: buttonTheme.getConstraints(this).copyWith(
        minWidth: minWidth,
        minHeight: height,
      ),
      shape: buttonTheme.getShape(this),
      clipBehavior: clipBehavior ?? Clip.none,
      animationDuration: buttonTheme.getAnimationDuration(this),
      child: child,
      materialTapTargetSize: materialTapTargetSize ?? theme.materialTapTargetSize,
    );
  }
}
