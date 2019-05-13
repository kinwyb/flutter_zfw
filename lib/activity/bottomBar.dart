import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:zfw/activity/sku.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/api/shoppingCart.dart';
import 'package:zfw/components/component.dart';
import '../components/api/activity.dart';
import '../components/router/routers.dart';
import './selectSpac.dart';
import 'activitySizeUtil.dart';
import 'bloc.dart';

class ActivityBottomBar extends StatefulWidget {
  final ActivityInfo info;
  ActivityBottomBar({Key key, this.info}) : super(key: key);
  @override
  _ActivityBottomBarState createState() => _ActivityBottomBarState();
}

class _ActivityBottomBarState extends State<ActivityBottomBar> {
  List<ActivityProductSKU> skus;
  ActivitySizeUtil get _size => getActivitySizeUtil();
  final ActivityskuBloc _bloc = new ActivityskuBloc();

  @override
  void initState() {
    super.initState();
    _bloc.dispatch(
        ActivityskuEvent(widget.info.ActivityCode, widget.info.ProductNo));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size.bottomHeight,
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildNavigationIcon(context),
          ),
          Expanded(
            child: BlocBuilder<ActivityskuEvent, ActivityskuState>(
              bloc: _bloc,
              builder: (context, state) {
                this.skus = state.data;
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: _putShoppingCart(context),
                    ),
                    Expanded(
                      child: _buy(context),
                    )
                  ],
                );
              },
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
              return ActivitySelectSpec(
                info: widget.info,
                skus: skus,
                addShoppingCart: true,
              );
            });
      },
      children: <Widget>[Text('加入购物车', style: _size.bottomButtonTextStyle)],
    );
  }

  Widget _buy(BuildContext context) {
    return Buttom(
      backgroundColor: Colors.red,
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return ActivitySelectSpec(
                info: widget.info,
                skus: skus,
                addShoppingCart: false,
              );
            });
      },
      children: <Widget>[Text('直接购买', style: _size.bottomButtonTextStyle)],
    );
  }

  Widget _buildNavigationIcon(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconTitle(
            icon: Icon(
              Icons.home,
              size: _size.bottomIconSize,
            ),
            title: Text('首页', style: _size.bottomIconTextStyle),
            onTap: () => homeNavigate(context),
          ),
        ),
        Expanded(
          child: IconTitle(
            icon:
                Icon(Icons.supervised_user_circle, size: _size.bottomIconSize),
            title: Text('联系客服', style: _size.bottomIconTextStyle),
            onTap: () => print('联系客服'),
          ),
        ),
        Expanded(
          child: IconTitle(
            icon: Icon(Icons.shopping_cart, size: _size.bottomIconSize),
            title: Text(
              '购物车',
              style: _size.bottomIconTextStyle,
            ),
            onTap: () => shoppingCartNavigate(context),
          ),
        )
      ],
    );
  }
}
