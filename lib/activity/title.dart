import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import '../components/api/activity.dart';
import 'activitySizeUtil.dart';

class ActivityTitle extends StatelessWidget {
  final ActivityInfo info;
  ActivitySizeUtil get _size => getActivitySizeUtil();

  ActivityTitle({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: _size.titleContainerPadding,
      margin: _size.titleContainerMargin,
      child: Column(
        children: <Widget>[
          // 价格&收藏
          Container(
            height: _size.titleContainerCollectHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // 价格
                _price(),
                // 收藏
                Container(
                  padding: _size.titleContainerCollectPadding,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        size: defaultIconSize,
                      ),
                      Text(
                        '收藏',
                        style: _size.titleContainerCollectTextStyle,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // 标题
          Container(
            alignment: Alignment.bottomLeft,
            margin: _size.titleContainerNamePadding,
            child: Text(
              info.Name,
              style: _size.titleContainerNameTextStyle,
              maxLines: 3,
            ),
          ),
          // 买点
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              info.SellingPoints,
              style: _size.titleContainerSellingPointTextStyle,
              maxLines: 3,
            ),
          ),
          // 标签
          Row(
            children: <Widget>[_tag("免邮"), _tag(info.BrandName)],
          )
        ],
      ),
    );
  }

  // 价格
  Widget _price() {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text.rich(TextSpan(
                text: "¥ ",
                style: _size.titleContainerPrefixPriceTextStyle,
                children: [
                  TextSpan(
                      text: "${this.info.SingleBuyPrice}",
                      style: _size.titleContainerPriceTextStyle)
                ],
              )),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "市场价 ¥${info.MarketPrice}",
                style: _size.titleContainerMarkPriceTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 标签
  Widget _tag(String value) {
    return Container(
      padding: _size.titleContainerTagPadding,
      margin: _size.titleContainerTagMargin,
      decoration: BoxDecoration(
        // color: Colors.red,
        border: new Border.all(width: 1.0, color: Colors.red),
        borderRadius: new BorderRadius.circular(100),
      ),
      child: Text(
        value,
        style: _size.titleContainerTagTextStyle,
      ),
    );
  }
}
