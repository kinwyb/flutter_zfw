import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/api/beans/shoppingCart.dart';
import 'package:zfw/components/api/shoppingCart.dart';
import 'package:zfw/components/checkBox.dart';
import 'package:zfw/components/component.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:zfw/components/router/routers.dart';
import 'package:zfw/shoppingCart/blocs/bloc.dart';

import 'shoppingCartSizeUtil.dart';

class Shop extends StatefulWidget {
  final ShoppingCartShop data;
  final CheckBoxTree allCheckBoxTree;

  Shop({Key key, this.data, this.allCheckBoxTree}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> with AutomaticKeepAliveClientMixin {
  @protected
  bool get wantKeepAlive => true;
  ShoppingCartSizeUtil get _size => getShoppingCartSizeUtil();

  bool _edit = false;
  ShoppingcartproductcardBloc _block;
  CheckBoxTree<ShoppingCartProduct> _shopCheckBox;
  @override
  void dispose() {
    super.dispose();
    _block.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_block == null) {
      _block = ShoppingcartproductcardBloc(widget.data);
    }
    _block.dispatch(ShoppingcartproductcardEvent.Load);
    final SignlebuyshoppingcartBloc _listBloc =
        BlocProvider.of<SignlebuyshoppingcartBloc>(context);
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
          padding: _size.shopTopContainerPadding,
          decoration: _size.shopTopContainerDecoration,
          height: _size.shopTopContainerHeight,
          child: Row(
            children: <Widget>[
              _shopCheckBox,
              Text(widget.data.shopName),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: onTap(Text('编辑'), () {
                    _edit = !_edit;
                    var w = Center(
                      child: Container(
                        padding: _size.shopTopEditPadding,
                        color: Colors.black.withOpacity(0.7),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: defaultIconSize,
                            ),
                            Text(
                              '添加成功',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                          mainAxisSize: MainAxisSize.min,
                        ),
                      ),
                    );
                    showToastWidget(w);
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    column.children.add(
      BlocBuilder<ShoppingcartproductcardEvent, ShoppingcartproductcardState>(
        bloc: _block,
        builder: (context, state) {
          if (state.products == null || state.products.length < 1) {
            return Container();
          }
          Column column = Column(
            children: <Widget>[],
          );
          for (var p in state.products) {
            p.oemName = widget.data.shopName;
            p.shopCode = widget.data.shopCode;
            column.children.add(new Slidable(
              delegate: new SlidableDrawerDelegate(),
              actionExtentRatio: 0.25,
              child: new Container(
                color: Colors.white,
                child: _ShoppingCartProductCard(
                  product: p,
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
                    if (widget.data.items.length < 1) {
                      _listBloc.dispatch(
                          SignlebuyshoppingcartEventRemove(widget.data));
                    } else {
                      _block.dispatch(ShoppingcartproductcardEvent.Load);
                    }
                  },
                ),
              ],
            ));
          }
          return column;
        },
      ),
    );
    return Container(
      margin: _size.shopContainerMargin,
      color: Colors.white,
      child: column,
    );
  }
}

class _ShoppingCartProductCard extends StatefulWidget {
  final ShoppingCartProduct product;
  final CheckBoxTree<ShoppingCartProduct> shopCheckBox;
  _ShoppingCartProductCard({Key key, this.product, this.shopCheckBox})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _ShoppingCartProductCardState();
}

class _ShoppingCartProductCardState extends State<_ShoppingCartProductCard> {
  NumInput _numInput;
  ShoppingCartSizeUtil get _size => getShoppingCartSizeUtil();

  CheckBoxTree<ShoppingCartProduct> _checkBox;

  void _numChange(String value) async {
    if (value.isEmpty) {
      return;
    }
    try {
      //防止value值错误
      int newNum = int.parse(value);
      StringResp resp = await ShoppingCartAPI.itemChange(
          activityCode: widget.product.activityCode,
          skuID: widget.product.skuID,
          num: newNum);
      if (resp.code == 0) {
        widget.product.num = newNum;
      } else {
        showToast(resp.errmsg, duration: Duration(seconds: 3));
      }
      _checkBox?.onChanged(false);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (_numInput == null) {
      _numInput = new NumInput(
        text: widget.product.num.toString(),
        maxNum: widget.product.stock,
        onChangeed: _numChange,
        iconSize: defaultIconSize,
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
    return GestureDetector(
      child: Container(
        height: _size.shopProductHeight,
        margin: _size.shopProductMargin,
        padding: _size.shopProductPadding,
        child: Row(
          children: <Widget>[
            _checkBox,
            Image.network(widget.product.productImage),
            Expanded(
              child: Container(
                margin: _size.shopProductTitleContainerMargin,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: _size.shopProductNameHeight,
                      child: Text(
                        widget.product.productName,
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
                              text: widget.product.price.toStringAsFixed(2),
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
                              widget.product.spacValue,
                              style: _size.shopProductAttrTextStyle,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Container(
                            width: _size.shopProductNumWidth,
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
      ),
      onTap: () {
        activityNavigate(context, widget.product.activityCode);
      },
    );
  }
}
