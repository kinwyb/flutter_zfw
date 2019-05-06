import 'package:flutter/material.dart';
import '../components/iconTitle.dart';
import '../components/router/routers.dart';

class ProductCard extends StatelessWidget {
  ProductInfo productInfo;

  final TextStyle _titleTextStyle =
      new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);
  final TextStyle _oemNameTextStyle =
      new TextStyle(fontSize: 9.0, color: Colors.red);
  final TextStyle _shareButtonTextStyle =
      new TextStyle(fontSize: 11.0, color: Color.fromARGB(200, 0, 0, 0));
  final BoxDecoration _shareButtonDecoration = new BoxDecoration(
    border: new Border.all(width: 1, color: Colors.red),
    borderRadius: new BorderRadius.circular(50),
  );
  final BoxDecoration _oemNameDecoration = new BoxDecoration(
    border: new Border.all(width: 1, color: Colors.red),
    borderRadius: new BorderRadius.circular(50),
  );
  final TextStyle _priceTextStyle =
      new TextStyle(fontSize: 15.0, color: Colors.red);
  final TextStyle _markPriceTextStyle = new TextStyle(
      fontSize: 9.0,
      color: Colors.grey,
      decorationStyle: TextDecorationStyle.solid,
      decoration: TextDecoration.lineThrough);

  ProductCard({Key key, @required this.productInfo})
      : assert(productInfo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        activityNavigate(context, productInfo.activityCode);
      },
      child: Card(
        margin: new EdgeInsets.fromLTRB(0, 5, 0, 5),
        // color: Colors.green,
        child: _cardItem(context),
      ),
    );
  }

  Widget _cardItem(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          child: Image.network(
            productInfo.productImg,
            fit: BoxFit.fill,
          ),
        ),
        _cardItemRight(context)
      ],
    );
  }

  // 右边部分
  Widget _cardItemRight(BuildContext context) {
    return Expanded(
      child: Container(
        // color: Colors.pink,
        padding: new EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: <Widget>[
            Container(
              // color: Colors.yellow,
              alignment: Alignment.centerLeft,
              child: Text(
                productInfo.productName,
                style: _titleTextStyle,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: new EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Container(
                // alignment: Alignment.centerLeft,
                padding: new EdgeInsets.fromLTRB(5, 3, 5, 3),
                decoration: _oemNameDecoration,
                child: Text(productInfo.oemName, style: _oemNameTextStyle),
              ),
            ),
            Row(
              children: <Widget>[
                Text('¥${productInfo.price}', style: _priceTextStyle),
                Container(
                  margin: new EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Text(
                    '¥${productInfo.markPrice}',
                    style: _markPriceTextStyle,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: CustomerButton(
                      onPressed: () {
                        print('分享赚钱');
                        // return false;
                      },
                      height: 25,
                      padding: new EdgeInsets.fromLTRB(10, 0, 10, 0),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minWidth: 10,
                      child: Text(
                        "分享赚钱",
                        style: _shareButtonTextStyle,
                      ),
                      color: Colors.yellow,
                      shape: StadiumBorder(),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 商品信息
class ProductInfo {
  String productName;
  String productImg;
  String productNo;
  String activityCode;
  String price;
  double markPrice;
  String oemName;
}
