import 'package:flutter/material.dart';
import '../components/api/beans/home.dart';
import '../components/router/routers.dart';

class HomeBrand extends StatelessWidget {
  IndexBrand brand;

  HomeBrand({Key key, this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430.0,
      margin: new EdgeInsets.fromLTRB(0, 20.0, 0, 0),
      child: Column(
        children: <Widget>[
          new Container(
            height: 70.0,
            color: Colors.white,
            child: Center(
                child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Container(
                            width: 50,
                            height: 50,
                            margin: new EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Image.network(
                              this.brand.Img,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Center(child: Text(this.brand.Name)),
                    ],
                  ),
                ),
                new Container(
                  alignment: Alignment.centerRight,
                  width: 60.0,
                  height: 30.0,
                  margin: new EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: new FlatButton(
                    onPressed: () {
                      print('更多');
                    },
                    color: Colors.yellow,
                    child: Text('更多'),
                  ),
                ),
              ],
            )),
          ),
          new Container(
            height: 360.0,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: _productBuild,
              itemCount: this.brand.Products.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _productBuild(BuildContext context, int index) {
    return _brandProducts(
      product: this.brand.Products[index],
      productsLength: this.brand.Products.length,
    );
  }
}

class _brandProducts extends StatefulWidget {
  IndexBrandProduct product;
  int productsLength;

  _brandProducts({Key key, this.product, this.productsLength})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _brandProductsState(this.product, this.productsLength);
  }
}

// 商品布局
class _brandProductsState extends State<_brandProducts> {
  IndexBrandProduct product;
  int productsLength;

  _brandProductsState(this.product, this.productsLength);

  @override
  Widget build(BuildContext context) {
    var width = 230.0;
    var margin = new EdgeInsets.fromLTRB(5, 10, 5, 10);
    if (productsLength == 1) {
      width = MediaQuery.of(context).size.width - 20;
      margin = new EdgeInsets.fromLTRB(10, 10, 10, 10);
    } else if (productsLength == 2) {
      width = (MediaQuery.of(context).size.width - 40) / 2;
      margin = new EdgeInsets.fromLTRB(5, 10, 5, 10);
    }
    return Container(
      width: width,
      margin: margin,
      decoration: new BoxDecoration(
        color: Colors.grey[200],
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      child: _brandProductDetail(product: this.product),
    );
  }
}

// 商品详情
class _brandProductDetail extends StatelessWidget {
  IndexBrandProduct product;

  _brandProductDetail({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return new GestureDetector(
      onTap: () {
        activityNavigate(context, this.product.ActivityCode);
      },
      child: new Column(
        children: <Widget>[
          new Container(
            width: width,
            height: 200.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(this.product.Img),
                fit: BoxFit.fill,
              ),
              borderRadius: new BorderRadius.vertical(
                top: new Radius.circular(10.0),
                bottom: new Radius.circular(0.0),
              ),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: new EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: new EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: new Text(
                      this.product.Name,
                      style: new TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _brandProductPrice(
                    price: this.product.Price,
                    markPrice: this.product.MarketPrice,
                  ),
                  _brandProductSellingPoint(
                      sellingPoint: this.product.SellingPoint),
                ],
              )),
        ],
      ),
    );
  }
}

// 商品价格
class _brandProductPrice extends StatelessWidget {
  String price;
  double markPrice;

  _brandProductPrice({Key key, this.price, this.markPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Text(
          "¥${this.price} ",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        new Text("¥${this.markPrice}",
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.black26,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
              decorationStyle: TextDecorationStyle.solid,
            ))
      ],
    );
  }
}

// 商品买点
class _brandProductSellingPoint extends StatelessWidget {
  String sellingPoint;

  _brandProductSellingPoint({Key key, this.sellingPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: new EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: new Text.rich(
        TextSpan(
          text: "推荐理由: ",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.yellow[900],
            fontWeight: FontWeight.bold,
          ),
          children: [
            new TextSpan(
              text: this.sellingPoint,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black26,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
