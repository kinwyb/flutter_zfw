import 'dart:core';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:zfw/activity/sku.dart';
import 'package:zfw/components/api/shoppingCart.dart';
import 'package:zfw/components/component.dart';
import '../components/api/activity.dart';
import '../components/router/routers.dart';
import './selectSpac.dart';

class ActivityBottomBar extends StatelessWidget {
  ActivityInfo info;
  List<ActivityProductSKU> skus;

  var iconTextStyle = TextStyle(fontSize: 9.0);
  final TextStyle _whiteColorTextStyle = textStyleColor(Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildNavigationIcon(context),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _putShoppingCart(context),
                ),
                Expanded(
                  child: _buy(context),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 加入购物车
  Widget _putShoppingCart(BuildContext context) {
    return Buttom(
      backgroundColor: Colors.yellow[800],
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Scaffold(
                body: ActivitySelectSpec(
                  info: info,
                  skus: skus,
                  addShoppingCart: true,
                ),
              );
            });
      },
      children: <Widget>[Text('加入购物车', style: _whiteColorTextStyle)],
    );
  }

  Widget _buy(BuildContext context) {
    return Buttom(
      backgroundColor: Colors.red,
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Scaffold(
                body: ActivitySelectSpec(
                  info: info,
                  skus: skus,
                  addShoppingCart: false,
                ),
              );
            });
      },
      children: <Widget>[Text('直接购买', style: _whiteColorTextStyle)],
    );
  }

  Widget _buildNavigationIcon(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconTitle(
            icon: Icon(Icons.home),
            title: Text('首页', style: iconTextStyle),
            onTap: () => homeNavigate(context),
          ),
        ),
        Expanded(
          child: IconTitle(
            icon: Icon(Icons.supervised_user_circle),
            title: Text('联系客服', style: iconTextStyle),
            onTap: () => print('联系客服'),
          ),
        ),
        Expanded(
          child: IconTitle(
            icon: Icon(Icons.shopping_cart),
            title: Text(
              '购物车',
              style: iconTextStyle,
            ),
            onTap: () => shoppingCartNavigate(context),
          ),
        )
      ],
    );
  }
}
