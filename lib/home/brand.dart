import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import '../components/api/beans/home.dart';
import '../components/router/routers.dart';
import 'homeSizeUtil.dart';

class HomeBrand extends StatelessWidget {
  HomePageSizeUtil get homeSize => new HomePageSizeUtil();
  final IndexBrand brand;

  HomeBrand({Key key, this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: homeSize.brandContainerHeight,
      margin: homeSize.brandContainerMargin,
      child: Column(
        children: <Widget>[
          new Container(
            height: homeSize.brandNameContainerHeight,
            color: Colors.white,
            child: Center(
                child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                              width: homeSize.brandImgSize,
                              height: homeSize.brandImgSize,
                              margin: homeSize.brandImgMargin,
                              child: Image.network(
                                this.brand.Img,
                                fit: BoxFit.fill,
                              )),
                        ),
                        Center(
                            child: Text(
                          this.brand.Name,
                          style: defaultFontTextStyle,
                        )),
                      ],
                    ),
                  ),
                ),
                new Container(
                  alignment: Alignment.centerRight,
                  width: homeSize.brandShareContainerWidth,
                  height: homeSize.brandShareContainerHeight,
                  margin: homeSize.brandShareMargin,
                  child: new FlatButton(
                    onPressed: () {
                      print('更多');
                    },
                    color: Colors.yellow,
                    child: Text(
                      '更多',
                      style: defaultFontTextStyle,
                    ),
                  ),
                ),
              ],
            )),
          ),
          new Container(
            height: homeSize.brandProductContainerHeight,
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
    return _BrandProducts(
      product: this.brand.Products[index],
      productsLength: this.brand.Products.length,
    );
  }
}

class _BrandProducts extends StatefulWidget {
  final IndexBrandProduct product;
  final int productsLength;

  _BrandProducts({Key key, this.product, this.productsLength})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BrandProductsState(this.product, this.productsLength);
  }
}

// 商品布局
class _BrandProductsState extends State<_BrandProducts> {
  IndexBrandProduct product;
  int productsLength;
  HomePageSizeUtil get homeSize => getHomePageSizeUtil();

  _BrandProductsState(this.product, this.productsLength);

  @override
  Widget build(BuildContext context) {
    var width = homeSize.brandProductDefaultWidth;
    var margin = homeSize.brandProductMargin;
    if (productsLength == 1) {
      width = MediaQuery.of(context).size.width - Adapt.px(40);
      margin = homeSize.brandOneProductMargin;
    } else if (productsLength == 2) {
      var _width = (MediaQuery.of(context).size.width - Adapt.px(80)) / 2;
      if (_width > width) {
        width = _width;
      }
    }
    return Container(
      width: width,
      margin: margin,
      decoration: new BoxDecoration(
        color: Colors.grey[200],
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      child: _BrandProductDetail(product: this.product),
    );
  }
}

// 商品详情
class _BrandProductDetail extends StatelessWidget {
  final IndexBrandProduct product;
  HomePageSizeUtil get homeSize => getHomePageSizeUtil();

  _BrandProductDetail({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        activityNavigate(context, this.product.ActivityCode);
      },
      child: new Column(
        children: <Widget>[
          new Container(
            height: homeSize.brandProductDetailHeight,
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
              padding: homeSize.brandProductTextContainerPadding,
              child: new Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: homeSize.brandProductNameMargin,
                    child: new Text(
                      this.product.Name,
                      style: homeSize.brandProductNameTextStyle,
                    ),
                  ),
                  _BrandProductPrice(
                    price: this.product.Price,
                    markPrice: this.product.MarketPrice,
                  ),
                  _BrandProductSellingPoint(
                      sellingPoint: this.product.SellingPoint),
                ],
              )),
        ],
      ),
    );
  }
}

// 商品价格
class _BrandProductPrice extends StatelessWidget {
  final String price;
  final double markPrice;
  HomePageSizeUtil get homeSize => getHomePageSizeUtil();

  _BrandProductPrice({Key key, this.price, this.markPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Text(
          "¥${this.price} ",
          style: homeSize.brandProductPriceTextStyle,
        ),
        new Text("¥${this.markPrice}",
            style: homeSize.brandProductMarkPriceTextStyle)
      ],
    );
  }
}

// 商品买点
class _BrandProductSellingPoint extends StatelessWidget {
  HomePageSizeUtil get homeSize => getHomePageSizeUtil();
  final String sellingPoint;

  _BrandProductSellingPoint({Key key, this.sellingPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: homeSize.brandProductSellingPointMargin,
      child: new Text.rich(
        TextSpan(
          text: "推荐理由: ",
          style: homeSize.brandProductSellingPointPrefixTextStyle,
          children: [
            new TextSpan(
              text: this.sellingPoint,
              style: homeSize.brandProductSellingPointTextStyle,
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
