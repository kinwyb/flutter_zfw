import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:core';
import 'package:zfw/components/component.dart';
import 'package:zfw/components/router/routers.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/order/blocs/bloc.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

import 'createOrderSizeUtil.dart';

// 订单来源
enum OrderFrom {
  ShoppingCart, // 购物车
  DirectBuy, // 直购
}

class OrderCreate extends StatefulWidget {
  final OrderFrom from;
  OrderCreate({Key key, this.from = OrderFrom.DirectBuy}) : super(key: key) {
//    String val =
//        '{"AddrCode":null,"Oem":[{"ActivityCode":"c110d2ca40ca11e9941b00163e136d45","AddrCode":null,"InvoiceCode":"","InvoiceCompanyName":"","InvoiceCompanyVerifyCode":"","InvoicePersonalName":"","Memo":"","OemName":"北极绒制造商","Products":[{"ActivityCode":"c110d2ca40ca11e9941b00163e136d45","price":10.2,"SkuID":"aa416ba840ca11e9941b00163e136d45","Num":2,"productImg":"https://qiniu.zhifangw.cn/19030717349388963815436830.jpg?filename=QN-MTkwMzA3MTczNDkzODg5NjM4MTU0MzY4MzAuanBn","productName":"女式弹力棉修身立体职场女神内搭基础必备衬衫","attr":"白色,L","Gift":null}],"UserCouponCode":null}],"UserCouponCode":null}';
//    orderReq = ShoppingCartOrderAddReq.fromJson(json.decode(val));
  }

  @override
  _OrderCreateState createState() => _OrderCreateState();
}

class _OrderCreateState extends State<OrderCreate> {
  final CreateOrderSizeUtil _size = getCreateOrderSizeUtil();
  final CreateorderbottomBloc _bottomBloc = new CreateorderbottomBloc();

  @override
  void initState() {
    super.initState();
    double amount = 0.0;
    for (var oem in orderReq.oem) {
      for (var p in oem.products) {
        amount += p.price * p.num;
      }
    }
    _bottomBloc.dispatch(CreateorderbottomEventAmountValue(amount));
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (orderReq == null || orderReq.oem == null || orderReq.oem.length < 1) {
      Future.delayed(
          Duration.zero,
          () => showToast("无订单信息请检查", duration: toastDuration, onDismiss: () {
                Navigator.pop(context);
              }));
      return Container(
        color: Colors.white,
      );
    }
    final List<Widget> listWidgets = [_top(), _OrderAddress(), _OrderCoupons()];
    for (var oem in orderReq.oem) {
      listWidgets.add(_OrderOem(
        data: oem,
      ));
    }
    listWidgets.add(_licenses());
    return BlocProvider<CreateorderbottomBloc>(
      bloc: _bottomBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("提交订单"),
        ),
        body: Container(
          color: Colors.grey[200],
          child: ListView(
            children: listWidgets,
          ),
        ),
        bottomNavigationBar: _OrderCreateBottom(
          from: widget.from,
        ),
      ),
    );
  }

  // 顶部提醒条
  Widget _top() {
    return Container(
      padding: _size.topPadding,
      margin: _size.containerMargin,
      color: Colors.yellow[800],
      child: Row(
        children: <Widget>[
          Icon(
            Icons.notifications_active,
            size: _size.topPaddingFontSize,
          ),
          Text(
            " 请及时提交订单,商品数量有限可能会被抢空",
            style: defaultFontTextStyle,
          ),
        ],
      ),
    );
  }

  // 协议栏
  Widget _licenses() {
    return Container(
      margin: _size.containerMargin,
      height: _size.shopLicensesHeight,
      child: Row(
        children: <Widget>[
          new CustomerCheckbox(
            value: true,
            width: _size.shopLicensesCheckBoxWidth,
            onChanged: (val) {
              _bottomBloc.dispatch(CreateorderbottomEventCheckBoxValue(val));
            },
          ),
          Container(
            child: onTap(
                Text(
                  "智纺购物协议",
                  style: _size.shopLicensesTextStyle,
                ), () {
              webViewNavigate(context, "https://www.baidu.com");
            }),
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }
}

// 地址
class _OrderAddress extends StatefulWidget {
  @override
  __OrderAddressState createState() => __OrderAddressState();
}

class __OrderAddressState extends State<_OrderAddress> {
  CreateOrderSizeUtil get _size => getCreateOrderSizeUtil();
  @override
  Widget build(BuildContext context) {
    Widget body;
    if (addrInfo == null) {
      body = Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "请选择地址",
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: defaultIconSize,
              color: Colors.grey,
            )
          ],
        ),
      );
    } else {
      Container def;
      if (addrInfo.isDefault == yes) {
        def = Container(
          child: Text(
            "默认",
            style: defaultFontTextStyle,
          ),
          padding: _size.addrDefPadding,
          margin: _size.addrDefMargin,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: borderRadiusCircular,
          ),
        );
      } else {
        def = Container();
      }
      body = Wrap(
        children: <Widget>[
          Container(
            margin: _size.addrNamePhoneMargin,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      addrInfo.contactsName,
                      style: _size.addrFontText,
                    ),
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    Text(
                      addrInfo.contactsPhone,
                      style: _size.addrFontText,
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                def,
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      addrInfo.provinceName +
                          addrInfo.cityName +
                          addrInfo.districtName +
                          addrInfo.address,
                      style: defaultFontTextStyle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
    return onTap(
      Container(
        color: Colors.white,
        margin: _size.containerMargin,
        padding: _size.addrPadding,
        child: Wrap(
          children: <Widget>[body],
        ),
      ),
      () async {
        await memberAddressNavigate(context, true);
        if (mounted) {
          setState(() {});
        }
      },
    );
  }
}

// 底部确认栏
class _OrderCreateBottom extends StatefulWidget {
  final OrderFrom from;
  _OrderCreateBottom({Key key, this.from}) : super(key: key);
  @override
  _OrderCreateBottomState createState() => _OrderCreateBottomState();
}

class _OrderCreateBottomState extends State<_OrderCreateBottom> {
  CreateOrderSizeUtil get _size => getCreateOrderSizeUtil();
  bool _checkBoxValue = true;
  CreateorderpostBloc _postBloc = new CreateorderpostBloc();

  @override
  void initState() {
    super.initState();
    fluwx.responseFromPayment.listen((response) {
      print('微信支付返回:' + response.toString());
    });
    _postBloc.state.listen((state) {
      if (state.isInit) {
        return;
      } else if (state.data.data != null && state.data.data.payValue != null) {
        Map<String, dynamic> payinfo = state.data.data.payValue;
        var result = fluwx.pay(
          appId: payinfo["appId"],
          partnerId: '1481486922',
          prepayId: 'wx16102048029213bccead1ae80567080797',
          packageValue: 'Sign=WXPay',
          nonceStr: payinfo["nonceStr"],
          timeStamp: int.parse(payinfo["timeStamp"]),
          sign: payinfo["sign"],
          signType: payinfo["signType"],
        );
        print(result.toString());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _postBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CreateorderbottomBloc _bloc =
        BlocProvider.of<CreateorderbottomBloc>(context);
    return Container(
      height: _size.bottomHeight,
      padding: _size.bottomPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: BlocBuilder<CreateorderbottomEvent, CreateorderbottomState>(
              bloc: _bloc,
              builder: (context, state) {
                _checkBoxValue = state.checkBoxValue;
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(text: "合计: ", children: [
                      TextSpan(
                        text: "¥" + state.amount.toStringAsFixed(2),
                        style: TextStyle(color: Colors.red),
                      ),
                    ]),
                    style: _size.bottomLeftTextStyle,
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Buttom(
              backgroundColor: Colors.red,
              onTap: () {
                print('确认订单');
                if (!_checkBoxValue) {
                  showToast("请确认购物协议");
                  return;
                } else {
                  _postBloc.dispatch(CreateorderpostEvent.DirectBuy);
                }
              },
              children: <Widget>[
                Padding(
                  padding: _size.bottomRightButtonPadding,
                  child: Center(
                    child: Text(
                      "确认订单",
                      style: _size.bottomRightTextStyle,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 店铺商品信息
class _OrderOem extends StatelessWidget {
  static CreateOrderSizeUtil get _size => getCreateOrderSizeUtil();
  final OemOrderAddReq data;
  _OrderOem({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> wgs = [
      Container(
        padding: _size.shopNamePadding,
        alignment: Alignment.centerLeft,
        child: Text(
          data.oemName,
          style: defaultFontTextStyle,
        ),
      )
    ];
    double amount = 0.0;
    for (var p in data.products) {
      wgs.add(_product(context, p));
      amount += p.price * p.num;
    }
    // 商品总价
    wgs.add(
      Container(
        height: _size.shopExtensionContainerHeight,
        decoration: _size.shopExtensionContainerDecoration,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '商品总价',
                  style: defaultFontTextStyle,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                '¥' + amount.toStringAsFixed(2),
                style: defaultFontTextStyle,
              ),
            )
          ],
        ),
      ),
    );
    // 运费
    wgs.add(
      Container(
        height: _size.shopExtensionContainerHeight,
        decoration: _size.shopExtensionContainerDecoration,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '运费',
                  style: defaultFontTextStyle,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                '免邮 ',
                style: defaultFontTextStyle,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: defaultIconSize,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
    // 我要开票
    wgs.add(
      Container(
        height: _size.shopExtensionContainerHeight,
        decoration: _size.shopExtensionContainerDecoration,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '我要开票',
                  style: defaultFontTextStyle,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                '无 ',
                style: defaultFontTextStyle,
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: defaultIconSize, color: Colors.grey),
          ],
        ),
      ),
    );
    // 支付方式
    wgs.add(
      Container(
        height: _size.shopExtensionContainerHeight,
        decoration: _size.shopExtensionContainerDecoration,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '支付方式',
                  style: defaultFontTextStyle,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                '微信支付 ',
                style: defaultFontTextStyle,
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: defaultIconSize, color: Colors.grey),
          ],
        ),
      ),
    );
    // 买家留言
    wgs.add(
      Container(
        height: _size.shopExtensionContainerHeight,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '买家留言:',
                style: defaultFontTextStyle,
              ),
            ),
            Expanded(
              child: Container(
                margin: _size.shopMemoTextFieldMargin,
                child: TextField(
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: '留言备注',
                    hintStyle: defaultFontTextStyle,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                  style: defaultFontTextStyle,
                  cursorWidth: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        color: Colors.white,
        padding: _size.shopPadding,
        margin: _size.containerMargin,
        child: Column(
          children: wgs,
        ),
      ),
    );
  }

  // 商品信息
  Widget _product(BuildContext context, OemOrderProduct product) {
    return Container(
      height: _size.shopProductHeight,
      margin: _size.shopProductMargin,
      padding: _size.shopProductPadding,
//      decoration: BoxDecoration(
//        border: Border(
//          bottom: BorderSide(width: 0.5, color: Colors.grey),
//          top: BorderSide(width: 0.5, color: Colors.grey),
//        ),
//      ),
      child: Row(
        children: <Widget>[
          Image.network(product.productImg),
          Expanded(
            child: Container(
              margin: _size.shopProductTitleContainerMargin,
              child: Column(
                children: <Widget>[
                  Container(
                    height: _size.shopProductTitleHeight,
                    child: Text(
                      product.productName,
                      style: _size.shopProductNameTextStyle,
                      maxLines: 2,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    height: _size.shopProductPriceHeight,
//                    color: Colors.grey,
                    child: Text.rich(
                      TextSpan(
                        text: " ¥",
                        style: _size.shopProductPriceIconTextStyle,
                        children: [
                          TextSpan(
                            text: product.price.toStringAsFixed(2),
//                            text: product.productImg.toStringAsFixed(2),
                            style: _size.shopProductPriceTextStyle,
                          )
                        ],
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            product.attr,
                            style: _size.shopProductAttrTextStyle,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "x" + product.num.toString(),
                              style: _size.shopProductAttrTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 优惠卷
class _OrderCoupons extends StatefulWidget {
  @override
  __OrderCouponsState createState() => __OrderCouponsState();
}

class __OrderCouponsState extends State<_OrderCoupons> {
  CreateOrderSizeUtil get _size => getCreateOrderSizeUtil();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size.couponHeight,
      margin: _size.containerMargin,
      padding: _size.couponPadding,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            margin: _size.couponLeftTextMargin,
            child: Text(
              '优惠卷',
              style: defaultFontTextStyle,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: _size.couponCenterPadding,
              child: Text(
                '暂无可用',
                style: defaultFontTextStyle,
              ),
            ),
          ),
          Container(
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: defaultIconSize,
            ),
          )
        ],
      ),
    );
  }
}
