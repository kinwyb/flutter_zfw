import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const Duration _kBottomSheetDuration = Duration(milliseconds: 200);

typedef AnimationWidgetBuilder = Widget Function(
    BuildContext context, AnimationController animationController);

Future<T> showModalPage<T>({
  @required BuildContext context,
  @required AnimationWidgetBuilder builder,
}) {
  assert(context != null);
  assert(builder != null);
  assert(debugCheckHasMaterialLocalizations(context));
  return Navigator.push(
      context,
      _ModalSheetRoute<T>(
        builder: builder,
        theme: Theme.of(context, shadowThemeOnly: true),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
      ));
}

class _ModalSheetRoute<T> extends PopupRoute<T> {
  _ModalSheetRoute({
    this.builder,
    this.theme,
    this.barrierLabel,
    RouteSettings settings,
  }) : super(settings: settings);

  final AnimationWidgetBuilder builder;
  final ThemeData theme;

  @override
  Duration get transitionDuration => _kBottomSheetDuration;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // By definition, the bottom sheet is aligned to the bottom of the page
    // and isn't exposed to the top padding of the MediaQuery.
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _ModalSheet<T>(route: this),
    );
    if (theme != null) bottomSheet = Theme(data: theme, child: bottomSheet);
    return bottomSheet;
  }
}

class _ModalSheet<T> extends StatefulWidget {
  const _ModalSheet({Key key, this.route}) : super(key: key);

  final _ModalSheetRoute<T> route;

  @override
  _ModalSheetState<T> createState() => _ModalSheetState<T>();
}

class _ModalSheetState<T> extends State<_ModalSheet<T>> {
  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    String routeLabel;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        routeLabel = '';
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        routeLabel = localizations.dialogLabel;
        break;
    }

    return GestureDetector(
      excludeFromSemantics: true,
      onTap: () => Navigator.pop(context),
      child: AnimatedBuilder(
        animation: widget.route.animation,
        builder: (BuildContext context, Widget child) {
          return Semantics(
            scopesRoute: true,
            namesRoute: true,
            label: routeLabel,
            explicitChildNodes: true,
            child: widget.route
                .builder(context, widget.route._animationController),
          );
        },
      ),
    );
  }
}
