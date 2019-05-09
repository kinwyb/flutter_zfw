import 'package:flutter/material.dart';
import 'package:zfw/components/api/shoppingCart.dart';
import 'package:zfw/components/component.dart';
import 'package:zfw/shoppingCart/shop.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCartPage> {
  SignleBuyShoppingCart _shoppingCartData = SignleBuyShoppingCart(
    shops: [],
  );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _shoppingCartData = await ShoppingCartAPI.singlebuyInfo();
    _update();
  }

  void _update() {
    if (mounted) {
      setState(() {});
    }
  }

  FocusNode _focusNode;
  _BottomCount bottom = _BottomCount();

  void _focusNodeChange(focusNode) {
    _focusNode = focusNode;
  }

  void _itemRemove(ShoppingCartShop shop) {
    _shoppingCartData.shops.remove(shop);
    _update();
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
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
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
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Shop(
                    data: _shoppingCartData.shops[index],
                    allCheckBoxTree: bottom._allCheckBoxTree,
                    focusNodeChange: _focusNodeChange,
                    removed: _itemRemove,
                  );
                },
                itemCount: _shoppingCartData.shops.length,
              ),
            ),
            bottom,
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }
}

class _BottomCount extends StatefulWidget {
  CheckBoxTree<ShoppingCartProduct> _allCheckBoxTree;
  double _money = 0;

  _BottomCount() {
    _allCheckBoxTree = CheckBoxTree<ShoppingCartProduct>(
      value: false,
      childActiveColor: Colors.grey,
      child: Text('全选'),
      onChanged: _onCheckBoxValueChange,
    );
  }

  void _onCheckBoxValueChange(bool value) {
    List<ShoppingCartProduct> datas = _allCheckBoxTree.checkedDatas();
    _money = 0.0;
    for (var v in datas) {
      _money += v.price * v.num;
    }
    if (_updateChild != null) {
      _updateChild();
    }
  }

  VoidCallback _updateChild;

  @override
  _BottomCountState createState() => _BottomCountState();
}

class _BottomCountState extends State<_BottomCount> {
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

  void _update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget._updateChild == null) {
      widget._updateChild = _update;
    }
    return Container(
      height: 40,
      decoration: _bottomContainerDecoration,
      child: Row(
        children: <Widget>[
          widget._allCheckBoxTree,
          Text.rich(
            TextSpan(
              text: "     ",
              children: [
                TextSpan(text: "合计: "),
                TextSpan(
                    text: "¥${widget._money.toStringAsFixed(2)}",
                    style: _priceTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
