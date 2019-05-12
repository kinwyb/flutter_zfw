import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/order/createOrderSizeUtil.dart';

final _loadMorePadding = EdgeInsets.all(Adapt.px(20));

// 加载更多
Widget loadMoreWidget() {
  return Center(
    child: Padding(
      padding: _loadMorePadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '加载中...     ',
            style: defaultFontText,
          ),
          CircularProgressIndicator(
            strokeWidth: 1.0,
          )
        ],
      ),
    ),
  );
}

// 加载中...
Widget loading(BuildContext context, bool showLoading,
    Widget Function(BuildContext) callBack) {
  if (showLoading) {
    return Center(
      child: Padding(
        padding: _loadMorePadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...     ',
              style: defaultFontText,
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  } else {
    return callBack(context);
  }
}

// 全部加载完了
Widget noMoreWidget() {
  return Center(
    child: Padding(
      padding: _loadMorePadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '没有更多了     ',
            style: defaultFontText,
          )
        ],
      ),
    ),
  );
}
