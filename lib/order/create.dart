import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:core';
import 'package:zfw/components/component.dart';
import 'package:zfw/components/component.dart' as prefix0;

final _containerMargin = EdgeInsets.only(bottom: 10);

// 创建订单
class OrderCreate extends StatelessWidget {
  OrderCreate({Key key}) : super(key: key) {
    String val =
        '{"AddrCode":null,"Oem":[{"ActivityCode":"c110d2ca40ca11e9941b00163e136d45","AddrCode":null,"InvoiceCode":"","InvoiceCompanyName":"","InvoiceCompanyVerifyCode":"","InvoicePersonalName":"","Memo":"","Products":[{"ActivityCode":"c110d2ca40ca11e9941b00163e136d45","SkuID":"白色,L","Num":1,"Gift":null}],"UserCouponCode":null}],"UserCouponCode":null}';
    orderReq = ShoppingCartOrderAddReq.fromJson(json.decode(val));
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
    final List<Widget> listWidgets = [_top(), _addr(context), _coupon()];
    for (var oem in orderReq.oem) {
      listWidgets.add(_OrderOem(
        data: oem,
      ));
    }
    listWidgets.add(_licenses(context));
    return Scaffold(
      appBar: AppBar(
        title: Text("提交订单"),
      ),
      body: Container(
        color: Colors.grey,
        child: ListView(
          children: listWidgets,
        ),
      ),
      bottomNavigationBar: _bottom(context),
    );
  }

  // 顶部提醒条
  final _topPadding = EdgeInsets.only(left: 20, top: 10, bottom: 10);
  Widget _top() {
    return Container(
      padding: _topPadding,
      margin: _containerMargin,
      color: Colors.yellow[800],
      child: Row(
        children: <Widget>[
          Icon(
            Icons.notifications_active,
            size: 18,
          ),
          Text(" 请及时提交订单,商品数量有限可能会被抢空"),
        ],
      ),
    );
  }

  // 优惠卷
  Widget _coupon() {
    return Container(
      height: 40,
      margin: _containerMargin,
      color: Colors.white,
    );
  }

  final TextStyle _addrFontSize = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // 地址栏
  Widget _addr(BuildContext context) {
    if (addrInfo == null) {
      //todo:选择地址
    }
    Container def;
    def = Container(
      child: Text("默认"),
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      margin: EdgeInsets.fromLTRB(0, 5, 30, 5),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
    );
    return Container(
      color: Colors.white,
      margin: _containerMargin,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 100,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                        '王五',
                        style: _addrFontSize,
                        maxLines: 1,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                  ),
                  Wrap(
                    children: <Widget>[
                      Text(
                        '15058679668',
                        style: _addrFontSize,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: <Widget>[
                  def,
                  Expanded(
                    child: Container(
                      child: Text(
                        '浙江省义乌市苏溪镇浙江省义乌市苏溪镇浙江省义乌市苏溪镇浙江省义乌市苏溪镇浙江省义乌市苏溪镇浙江省义乌市苏溪镇',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _licenses(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 20,
    );
  }

  Widget _bottom(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(text: "合计: ", children: [
                  TextSpan(
                    text: "¥10.60",
                    style: TextStyle(color: Colors.red),
                  ),
                ]),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Buttom(
              backgroundColor: Colors.red,
              onTap: () {
                print('确认订单');
              },
              children: <Widget>[
                Text(
                  "确认订单",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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

class _OrderOem extends StatelessWidget {
  final OemOrderAddReq data;
  _OrderOem({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: _containerMargin,
      color: Colors.white,
    );
  }
}
