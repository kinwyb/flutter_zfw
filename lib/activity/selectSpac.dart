import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:zfw/components/api/shoppingCart.dart';
import 'package:zfw/components/component.dart';
import 'package:zfw/components/router/routers.dart';
import '../components/iconTitle.dart';
import '../components/api/activity.dart';
import '../components/input.dart';
import './sku.dart';

class ActivitySelectSpec extends StatefulWidget {
  ActivityInfo info;
  bool addShoppingCart; //是否是加入购物车
  String text;
  Color backgroundColor;
  List<ActivityProductSKU> skus;

  ActivitySelectSpec(
      {Key key,
      this.addShoppingCart,
      this.text,
      @required this.skus,
      this.backgroundColor: Colors.white,
      @required this.info})
      : assert(info != null),
        assert(skus != null),
        super(key: key) {
    if (this.text == null || this.text.trim() == "") {
      this.text = addShoppingCart ? "加入购物车" : "立即购买";
    }
  }

  @override
  State<StatefulWidget> createState() =>
      new ActivitySelectSpecState(backgroundColor);
}

// 选择规格
class ActivitySelectSpecState extends State<ActivitySelectSpec> {
  Map<String, SkuTree> resultValue = Map(); //选中的值
  Map<String, int> iconValue = Map();
  SkuTree selectedSku;
  NumInput numInput;
  final ScrollController _controller = ScrollController();
  FocusNode _focusNode = new FocusNode();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  ActivitySelectSpecState(Color backgroundColor) {
    numInput = NumInput(
      text: "0",
      backgroundColor: backgroundColor,
      focusNode: this._focusNode,
      minNum: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: _controller,
        child: Wrap(
          children: <Widget>[
            _buiTop(context),
            ActivitySKU(
              sku: widget.skus,
              backgroundColor: widget.backgroundColor,
              selectCallBack: _selectSKU,
            ),
            _buyNum(context),
            Buttom(
              onTap: () {
                if (numInput.oldNum > 0 && this.selectedSku != null) {
                  selectedSku.num = numInput.oldNum;
                  resultValue[selectedSku.attr] = selectedSku;
                }
                _selectSpecCallback(context);
                return true;
              },
              backgroundColor: Colors.red,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 按钮回调
  void _selectSpecCallback(BuildContext context) async {
    if (resultValue.length < 1) {
      Navigator.pop(context);
      return;
    }
    if (widget.addShoppingCart) {
      ShoppingCartAddReq req = ShoppingCartAddReq(
        activityCode: widget.info.ActivityCode,
        items: [],
      );
      resultValue.forEach((key, val) {
        req.items.add(ShoppingCartAddItem(
          activityCode: widget.info.ActivityCode,
          skuID: key,
          num: val.num,
        ));
      });
      StringResp resp = await ShoppingCartAPI.add(req);
      if (resp.code == 0) {
        showToast("购物车添加成功", duration: toastDuration);
      } else {
        showToast(resp.errmsg, duration: toastDuration);
      }
      Navigator.pop(context);
    } else {
      if (orderReq == null) {
        orderReq = ShoppingCartOrderAddReq(oem: []);
      } else {
        orderReq.oem.clear();
      }
      OemOrderAddReq oemOrder = OemOrderAddReq();
      oemOrder.userCouponCode = null;
      oemOrder.invoiceCode = "";
      oemOrder.invoiceCompanyName = "";
      oemOrder.invoiceCompanyVerifyCode = "";
      oemOrder.invoicePersonalName = "";
      oemOrder.memo = "";
      oemOrder.oemName = widget.info.BrandName;
      oemOrder.activityCode = widget.info.ActivityCode;
      if (oemOrder.products == null) {
        oemOrder.products = [];
      } else {
        oemOrder.products.clear();
      }
      resultValue.forEach((key, val) {
        oemOrder.products.add(OemOrderProduct(
          activityCode: widget.info.ActivityCode,
          skuID: val.skuID,
          num: val.num,
          attr: key,
          price: widget.info.SingleBuyPrice,
          productImg: widget.info.Imgs?.first?.src,
          productName: widget.info.Name,
        ));
      });
      orderReq.oem.add(oemOrder);
      print(json.encode(orderReq.toJson()));
      orderCreateNavigate(context);
    }
  }

  // 顶部控件
  Widget _buiTop(BuildContext context) {
    return Container(
      height: 100,
      padding: new EdgeInsets.fromLTRB(10, 10, 10, 5),
      // color: Colors.purple,
      color: widget.backgroundColor,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            child: Image.network(widget.info.Imgs[0].src, fit: BoxFit.fill),
          ),
          Container(
            margin: new EdgeInsets.fromLTRB(5, 0, 0, 0),
            // color: Colors.yellow,
            width: MediaQuery.of(context).size.width - 100 - 20 - 5,
            child: Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // 价格
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(text: "¥", children: [
                          TextSpan(
                              text: "${widget.info.SingleBuyPrice}",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ))
                        ]),
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    // 库存
                    _stock(context),
                    // 商品规格提示
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: new EdgeInsets.only(top: 2),
                      child: Text(
                        "请选中商品规格",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[800],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 库存
  Widget _stock(BuildContext context) {
    if (selectedSku == null || selectedSku.skuID.trim() == "") {
      return Container();
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: new EdgeInsets.only(top: 2),
      child: Text(
        "库存: ${selectedSku?.stockNum}",
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  // 购买数量
  Widget _buyNum(BuildContext context) {
    return Container(
      height: 60,
      padding: new EdgeInsets.fromLTRB(10, 5, 10, 2),
      // color: Colors.yellow,
      color: widget.backgroundColor,
      child: Row(
        children: <Widget>[
          Text('购买数量'),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Container(
                width: 100,
                // color: Colors.lightBlue,
                child: numInput,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 选中的SKU
  void _selectSKU(SkuTree sku) async {
    var _oldSKU = this.selectedSku;
    if (numInput.oldNum > 0 && _oldSKU != null) {
      _oldSKU.num = numInput.oldNum;
      resultValue[_oldSKU.attr] = _oldSKU;
    }
    if (sku != null) {
      this.selectedSku = sku;
    }
    String attr = sku != null ? sku.attr : "";
    int stockNum = sku != null ? sku.stockNum : 0;
    numInput?.setText(
        resultValue[attr] == null ? "0" : resultValue[attr].num.toString());
    numInput?.maxNum = stockNum; //设置加减最大值
    Future.delayed(Duration.zero, () => setState(() {}));
  }
}
