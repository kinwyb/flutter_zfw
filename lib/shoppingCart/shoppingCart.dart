import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zfw/components/api/shoppingCart.dart';
import 'package:zfw/components/component.dart';
import 'package:zfw/shoppingCart/blocs/bloc.dart';
import 'package:zfw/shoppingCart/shop.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCartPage> {
  final SignlebuyshoppingcartBloc _bloc = SignlebuyshoppingcartBloc();
  final ShoppingcartbottomAmountBloc _bottomBloc =
      ShoppingcartbottomAmountBloc();
  final _bottomContainerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border(
      top: BorderSide(
        width: 0.5,
        color: Colors.grey,
      ),
    ),
  );
  final _priceTextStyle = TextStyle(color: Colors.red);
  CheckBoxTree<ShoppingCartProduct> _allCheckBoxTree;

  _ShoppingCartState() {
    _allCheckBoxTree = CheckBoxTree<ShoppingCartProduct>(
      value: false,
      childActiveColor: Colors.grey,
      child: Text('全选'),
      onChanged: _onCheckBoxValueChange,
    );
  }

  void _onCheckBoxValueChange(bool value) {
    List<ShoppingCartProduct> datas = _allCheckBoxTree.checkedDatas();
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
  }

  FocusNode _focusNode;

  void _focusNodeChange(focusNode) {
    _focusNode = focusNode;
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBloc.dispose();
    _bloc.dispose();
    _allCheckBoxTree.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      backgroundColor: Colors.grey[200],
      body: GestureDetector(
        onTap: () {
          if (_focusNode != null && _focusNode.hasFocus) {
            _focusNode.unfocus();
          }
        },
        child: BlocProvider(
          bloc: _bloc,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
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
              ),
              Expanded(
                child: BlocBuilder<SignlebuyshoppingcartEvent,
                    SignlebuyshoppingcartState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        if (state.data.shops.length < 1) {
                          return noMoreWidget();
                        } else {
                          return Shop(
                            data: state.data.shops[index],
                            allCheckBoxTree: _allCheckBoxTree,
                            focusNodeChange: _focusNodeChange,
                          );
                        }
                      },
                      itemCount: state.data.shops.length,
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                decoration: _bottomContainerDecoration,
                child: Row(
                  children: <Widget>[
                    _allCheckBoxTree,
                    BlocBuilder<ShoppingcartbottomAmountEvent,
                        ShoppingcartbottomAmountState>(
                      bloc: _bottomBloc,
                      builder: (context, state) {
                        return Text.rich(
                          TextSpan(
                            text: "     ",
                            children: [
                              TextSpan(text: "合计: "),
                              TextSpan(
                                  text: "¥${state.amount.toStringAsFixed(2)}",
                                  style: _priceTextStyle),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }
}
