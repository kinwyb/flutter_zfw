import 'package:flutter/material.dart';
import './productCard.dart';
import '../components/api/category.dart';
import '../components/refresh.dart';

class ProductList extends StatefulWidget {
  String categoryName;
  ProductList({Key key, this.categoryName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ProductListState();
}

class ProductListState extends State<ProductList> {
  List<ProductInfo> products = [];
  int _page = 1; //第一页
  bool isLoad = false;
  bool isEnd = false;
  int _maxLength = 0;
  ScrollController _controller = new ScrollController();

  ProductListState() {
    _controller.addListener(_controllerListen);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_controllerListen);
    _controller.dispose();
  }

  void _controllerListen() {
    if (!isEnd && !isLoad) {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
        //加载数据
        loadData();
      }
    }
  }

  void loadData() {
    isLoad = true;
    if (widget.categoryName != null && widget.categoryName.trim() != "") {
      loadCategory();
    }
  }

  // 加载分类列表
  void loadCategory() async {
    CategoryInfoResp info = await CategoryAPI.info(widget.categoryName, _page);
    if (info.page != null) {
      _maxLength = info.page.total;
    }
    if (info.data == null) {
      isEnd = true;
    }else if (info.data.Activitys == null || info.data.Activitys.length < 1) {
      isEnd = true;
    } else {
      for (var i in info.data.Activitys) {
        ProductInfo p = new ProductInfo();
        p.productName = i.Name;
        p.productImg = i.Img;
        p.productNo = i.ProductNo;
        p.activityCode = i.ActivityCode;
        p.price = i.Price;
        p.markPrice = i.MarketPrice;
        p.oemName = i.OemName;
        products.add(p);
      }
      _page++;
      if (products.length >= _maxLength) {
        isEnd = true;
      }
      isLoad = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Container(
        padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView.builder(
          controller: _controller,
          itemCount: products.length + 1,
          itemBuilder: _item,
        ),
      ),
    );
  }

  Widget _item(BuildContext context, int index) {
    if (index >= products.length) {
      if (isEnd) {
        return noMoreWidget();
      } else {
        return loadMoreWidget();
      }
    } else {
      return new ProductCard(
        productInfo: products[index],
      );
    }
  }
}
