import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import 'adapt.dart';
import 'modal.dart';

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
            style: defaultFontTextStyle,
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
              style: defaultFontTextStyle,
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

// 数据提交中
Widget putDataWidget() {
  return Container(
    padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
    decoration: BoxDecoration(
      color: Color.fromARGB(200, 0, 0, 0),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Wrap(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 22),
          child: CircularProgressIndicator(
            strokeWidth: 1.0,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 5,
          ),
          alignment: Alignment.center,
          child: Text(
            '数据提交中',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              color: Colors.white,
            ),
          ),
        ),
      ],
      direction: Axis.vertical,
    ),
  );
}

void showPutData(BuildContext context, [tapClose = true]) {
  showModalPage(
      context: context,
      tapClose: tapClose,
      builder: (context, _) {
        return Stack(
          children: <Widget>[
            Positioned(
              top: (MediaQuery.of(context).size.height - 70) / 2,
              left: (MediaQuery.of(context).size.width - 90) / 2,
              child: putDataWidget(),
            )
          ],
        );
      });
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
            style: defaultFontTextStyle,
          )
        ],
      ),
    ),
  );
}
