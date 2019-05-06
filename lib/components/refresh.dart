import 'package:flutter/material.dart';

// 加载更多
Widget loadMoreWidget() {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '加载中...     ',
            style: TextStyle(fontSize: 16.0),
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
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...     ',
              style: TextStyle(fontSize: 16.0),
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
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '没有更多了     ',
            style: TextStyle(fontSize: 16.0),
          )
        ],
      ),
    ),
  );
}
