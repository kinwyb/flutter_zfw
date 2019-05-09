import 'package:flutter/material.dart';
import 'package:zfw/components/api/beans/shoppingCart.dart';
import 'package:zfw/components/api/shoppingCart.dart';
import 'package:zfw/components/checkBox.dart';
import 'package:zfw/components/component.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Shop extends StatefulWidget {
  final ShoppingCartShop data;
  final CheckBoxTree allCheckBoxTree;
  final Function(FocusNode) focusNodeChange;
  final ValueChanged<ShoppingCartShop> removed;

  Shop(
      {Key key,
      this.data,
      this.allCheckBoxTree,
      this.focusNodeChange,
      this.removed})
      : super(key: key);

  //移除
  bool _remove() {
    if (removed != null && data.items.length < 1) {
      removed(data);
      return true;
    } else {
      return false;
    }
  }

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> with AutomaticKeepAliveClientMixin {
  @protected
  bool get wantKeepAlive => true;

  final _topContainerPadding = EdgeInsets.all(10);
  bool _edit = false;
  final _topContainerDecoration = BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)));

  CheckBoxTree<ShoppingCartProduct> _shopCheckBox;

  @override
  void dispose() {
    super.dispose();
    _shopCheckBox?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_shopCheckBox == null) {
      _shopCheckBox = CheckBoxTree<ShoppingCartProduct>(
        value: widget.allCheckBoxTree.value,
        activeColor: widget.allCheckBoxTree.activeColor,
        childActiveColor: widget.allCheckBoxTree.childActiveColor,
        parent: widget.allCheckBoxTree,
        onChanged: widget.allCheckBoxTree.onChanged,
      );
    }
    Column column = Column(
      children: <Widget>[
        Container(
          padding: _topContainerPadding,
          decoration: _topContainerDecoration,
          height: 60,
          child: Row(
            children: <Widget>[
              _shopCheckBox,
              Text(widget.data.shopName),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: onTap(Text('编辑'), () {
                    _edit = !_edit;
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    for (var p in widget.data.items) {
      column.children.add(
        new Slidable(
          delegate: new SlidableDrawerDelegate(),
          actionExtentRatio: 0.25,
          child: new Container(
            color: Colors.white,
            child: _ShoppingCartProductCard(
              product: p,
              focusNodeChange: widget.focusNodeChange,
              shopCheckBox: _shopCheckBox,
            ),
          ),
          secondaryActions: <Widget>[
            new IconSlideAction(
              caption: '删除',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                int index = widget.data.items.indexOf(p);
                if (index > -1) {
                  widget.data.items.removeAt(index);
                }
                //todo: 这里可以创建一个动画
                widget.data.items.remove(p);
                if (!widget._remove()) {
                  _update();
                }
              },
            ),
          ],
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      color: Colors.white,
      child: column,
    );
  }

  void _update() {
    if (mounted) {
      setState(() {});
    }
  }
}

class _ShoppingCartProductCard extends StatefulWidget {
  final ShoppingCartProduct product;
  final Function(FocusNode) focusNodeChange;
  final CheckBoxTree<ShoppingCartProduct> shopCheckBox;
  _ShoppingCartProductCard(
      {Key key, this.product, this.focusNodeChange, this.shopCheckBox})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _ShoppingCartProductCardState();
}

class _ShoppingCartProductCardState extends State<_ShoppingCartProductCard> {
  NumInput _numInput;

  final _orderItemProductNameTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  final _orderItemProductMargin = EdgeInsets.only(top: 10, bottom: 10);
  final _orderItemProductPadding = EdgeInsets.only(left: 10, right: 10);
  final _orderItemProductTitleContainerMargin = EdgeInsets.only(left: 10);
  final _orderItemProductAttrTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 12,
  );
  final _orderItemProductPriceIconTextStyle = TextStyle(
    color: Colors.red,
  );
  final _orderItemProductPriceTextStyle = TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  CheckBoxTree<ShoppingCartProduct> _checkBox;

  void _numChange(String value) {
    widget.product.num = int.parse(value);
    _checkBox?.onChanged(false);
  }

  @override
  void dispose() {
    super.dispose();
    _checkBox?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_numInput == null) {
      _numInput = _numInput = new NumInput(
        text: widget.product.num.toString(),
        maxNum: widget.product.stock,
        focusNodeValueFunc: widget.focusNodeChange,
        onChangeed: _numChange,
      );
    }
    if (_checkBox == null) {
      _checkBox = CheckBoxTree<ShoppingCartProduct>(
        value: widget.shopCheckBox.value,
        activeColor: widget.shopCheckBox.activeColor,
        childActiveColor: widget.shopCheckBox.childActiveColor,
        data: widget.product,
        parent: widget.shopCheckBox,
        onChanged: widget.shopCheckBox.onChanged,
      );
    }
    return Container(
      height: 110,
      margin: _orderItemProductMargin,
      padding: _orderItemProductPadding,
      child: Row(
        children: <Widget>[
          _checkBox,
          Image.network(widget.product.productImage),
          Expanded(
            child: Container(
              margin: _orderItemProductTitleContainerMargin,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 40,
                    child: Text(
                      widget.product.productName,
                      style: _orderItemProductNameTextStyle,
                      maxLines: 2,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    height: 40,
//                    color: Colors.grey,
                    child: Text.rich(
                      TextSpan(
                        text: " ¥",
                        style: _orderItemProductPriceIconTextStyle,
                        children: [
                          TextSpan(
                            text: widget.product.price.toStringAsFixed(2),
                            style: _orderItemProductPriceTextStyle,
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
                            widget.product.spacValue,
                            style: _orderItemProductAttrTextStyle,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          width: 100,
                          child: _numInput,
                        )
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
