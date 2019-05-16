import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/api/shoppingCart.dart';
import 'package:zfw/components/component.dart';
import 'package:zfw/components/router/routers.dart';
import 'package:zfw/order/blocs/bloc.dart';
import 'package:zfw/order/create.dart';
import 'package:zfw/shoppingCart/blocs/bloc.dart';
import 'package:zfw/shoppingCart/shop.dart';

import 'shoppingCartSizeUtil.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCartPage>
    with AutomaticKeepAliveClientMixin {
  final SignlebuyshoppingcartBloc _bloc = SignlebuyshoppingcartBloc();
  final ShoppingcartbottomAmountBloc _bottomBloc =
      ShoppingcartbottomAmountBloc();
  final CreateorderinitBloc _bottonBloc = CreateorderinitBloc();
  ShoppingCartSizeUtil get _size => getShoppingCartSizeUtil();

  CheckBoxTree<ShoppingCartProduct> _allCheckBoxTree;
  SignleBuyShoppingCart _cartData;

  _ShoppingCartState() {
    _allCheckBoxTree = CheckBoxTree<ShoppingCartProduct>(
      value: false,
      childActiveColor: Colors.grey,
      child: Text(
        '全选',
        style: defaultFontTextStyle,
      ),
      onChanged: _onCheckBoxValueChange,
    );
  }

  void _onCheckBoxValueChange(bool value) {
    List<ShoppingCartProduct> datas;
    if (_cartData != null && _allCheckBoxTree.isAllChecked()) {
      datas = [];
      for (var s in _cartData.shops) {
        datas.addAll(s.items);
      }
    } else {
      datas = _allCheckBoxTree.checkedDatas();
    }
    double _money = 0.0;
    for (var v in datas) {
      _money += v.price * v.num;
    }
    _bottomBloc.dispatch(ShoppingcartbottomAmountEvent(_money));
  }

  @override
  void initState() {
    super.initState();
    _bloc.dispatch(SignlebuyshoppingcartEventLoad());
    _bottonBloc.state.listen((state) async {
      if (state.succ) {
        await orderCreateNavigate(context, OrderFrom.ShoppingCart);
        _bloc.dispatch(SignlebuyshoppingcartEventLoad());
      } else if (state.msg.isNotEmpty) {
        showToast(state.msg);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bottonBloc.dispose();
    _bottomBloc.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[200],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocProvider(
          bloc: _bloc,
          child: Column(
            children: <Widget>[
              Container(
                padding: _size.tipContainerPadding,
                color: Colors.yellow[800],
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.notifications_active,
                      size: defaultIconSize,
                    ),
                    Text(
                      " 请及时提交订单,商品数量有限可能会被抢空",
                      style: defaultFontTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<SignlebuyshoppingcartEvent,
                    SignlebuyshoppingcartState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    _cartData = state.data;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        if (state.data.shops.length < 1) {
                          return noMoreWidget();
                        } else {
                          return Shop(
                            data: state.data.shops[index],
                            allCheckBoxTree: _allCheckBoxTree,
                          );
                        }
                      },
                      itemCount: state.data.shops.length,
                    );
                  },
                ),
              ),
              Container(
                height: _size.bottomContainerHeight,
                decoration: _size.bottomContainerDecoration,
                child: Row(
                  children: <Widget>[
                    _allCheckBoxTree,
                    Expanded(
                      child: BlocBuilder<ShoppingcartbottomAmountEvent,
                          ShoppingcartbottomAmountState>(
                        bloc: _bottomBloc,
                        builder: (context, state) {
                          return Text.rich(
                            TextSpan(
                              text: "    ",
                              children: [
                                TextSpan(
                                    text: "合计: ", style: defaultFontTextStyle),
                                TextSpan(
                                    text: "¥${state.amount.toStringAsFixed(2)}",
                                    style: _size.priceTextStyle),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    onTap(
                      Container(
                        width: _size.bottomContainerRightButtonWidth,
                        color: Colors.red,
                        alignment: Alignment.center,
                        child: Text(
                          '确认提交',
                          style: _size.bottomContainerRightButtonTextStyle,
                        ),
                      ),
                      () {
                        List<ShoppingCartProduct> datas;
                        if (_cartData != null &&
                            _allCheckBoxTree.isAllChecked()) {
                          datas = [];
                          for (var s in _cartData.shops) {
                            datas.addAll(s.items);
                          }
                        } else {
                          datas = _allCheckBoxTree.checkedDatas();
                        }
                        _bottonBloc.dispatch(CreateorderinitEvent(datas));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
