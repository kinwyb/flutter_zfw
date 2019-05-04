import 'package:flutter/material.dart';
import '../components/api/activity.dart';

class ActivityTitle extends StatelessWidget {
  ActivityInfo info;

  ActivityTitle({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.greenAccent,
      height: 150.0,
      color: Colors.white,
      padding: new EdgeInsets.all(10.0),
      margin: new EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        children: <Widget>[
          // 价格&收藏
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // 价格
                _price(),
                // 收藏
                Container(
                  padding: new EdgeInsets.fromLTRB(0, 3, 0, 0),
                  child: Column(
                    children: <Widget>[Icon(Icons.favorite_border), 
                    Text('收藏',style: TextStyle(
                      fontSize: 12.0
                    ),)],
                  ),
                )
              ],
            ),
          ),
          // 标题
          Container(
            alignment: Alignment.bottomLeft,
            margin: new EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(info.Name,style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),maxLines: 3,),
          ),
          // 买点
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(info.SellingPoints,style: TextStyle(
              fontSize: 12.0,
              color: Colors.black45,
            ),maxLines: 3,),
          ),
          // 标签
          Row(
            children: <Widget>[
              _tag("免邮"),
              _tag(info.BrandName)
            ],
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
                style: TextStyle(fontSize: 18.0, color: Colors.red[500],fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                      text: "${this.info.SingleBuyPrice}",
                      style: TextStyle(
                        fontSize: 25.0,
                      ))
                ],
              )),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "市场价 ¥${info.MarketPrice}",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12.0,
                  decoration: TextDecoration.lineThrough,
                  decorationStyle: TextDecorationStyle.solid,
                ),
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
      padding: new EdgeInsets.fromLTRB(10, 2, 10, 2),
      margin: new EdgeInsets.fromLTRB(0, 10, 10, 0),
      decoration: BoxDecoration(
        // color: Colors.red,
        border: new Border.all(width: 1.0, color: Colors.red),
        borderRadius: new BorderRadius.circular(100),
      ),
      child: Text(value,style: TextStyle(
        color: Colors.red,
        fontSize: 12.0,
      ),),
    );
  }
}
