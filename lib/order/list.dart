import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/api/order.dart';
import 'package:zfw/components/component.dart';
import 'package:zfw/order/listSizeUtil.dart';

class OrderListPage extends StatefulWidget {
  final int orderState; //订单状态

  OrderListPage({Key key, this.orderState}) : super(key: key);

  @override
  _OrderListPageState createState() =>
      _OrderListPageState(orderStateParse(orderState));
}

class _OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ListSizeUtil get _size => getListSizeUtil();

  _OrderListPageState([OrderState state = OrderState.All]) {
    var index = 0;
    switch (state) {
      case OrderState.WaitPay:
        index = 1;
        break;
      case OrderState.Grouping:
        index = 2;
        break;
      case OrderState.WaitPendingDelivery:
        index = 3;
        break;
      case OrderState.WaitDelivery:
        index = 4;
        break;
      case OrderState.WaitAssess:
        index = 5;
        break;
      default:
        index = 0;
    }
    _tabController =
        new TabController(length: 6, initialIndex: index, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            padding: _size.tabBarPadding,
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicator: _size.tabBarIndicator,
              labelPadding: EdgeInsets.zero,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                _tabItem("全部"),
                _tabItem("待付款"),
                _tabItem("待成团"),
                _tabItem("待发货"),
                _tabItem("待收货"),
                _tabItem("待评价"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: _size.tabViewContainerPadding,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _OrderListViewPage(orderState: OrderState.All),
                  _OrderListViewPage(orderState: OrderState.WaitPay),
                  _OrderListViewPage(orderState: OrderState.Grouping),
                  _OrderListViewPage(
                      orderState: OrderState.WaitPendingDelivery),
                  _OrderListViewPage(orderState: OrderState.WaitDelivery),
                  _OrderListViewPage(orderState: OrderState.WaitAssess),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabItem(String title) {
    return Text(
      title,
      style: _size.defaultFontTextStyle,
    );
  }
}

// 订单列表
class _OrderListViewPage extends StatefulWidget {
  final OrderState orderState;

  _OrderListViewPage({Key key, this.orderState}) : super(key: key);

  @override
  _OrderListViewPageState createState() => _OrderListViewPageState();
}

class _OrderListViewPageState extends State<_OrderListViewPage>
    with AutomaticKeepAliveClientMixin {
  @protected
  bool get wantKeepAlive => true;

  List<OrderListItem> _orders;
  int _maxLength = 0;
  int _page = 1;
  bool _loading = false;
  ScrollController _controller;

  _OrderListViewPageState() {
    _controller = ScrollController();
    _controller.addListener(_controllerListen);
  }

  void _controllerListen() {
    if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
      if (_orders.length < _maxLength) {
        //加载更多
        _loadingData();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadingData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_controllerListen);
    _controller.dispose();
  }

  // 加载数据
  void _loadingData() async {
    if (_orders == null) {
      _orders = [];
    }
    if (_loading) {
      return;
    }
    _loading = true;
    var order = await OrderAPI.list(status: widget.orderState, page: _page);
    if (order.page != null) {
      _maxLength = order.page.total;
    }
    if (order.data == null) {
      _loading = false;
      return;
    }
    _orders.addAll(order.data);
    _page++;
    _loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading(context, _orders == null, (context) {
      return ListView.builder(
        controller: _controller,
        itemBuilder: (context, index) {
          if (index == _orders.length) {
            return _endWidget();
          }
          return _OrderCard(item: _orders[index]);
        },
        itemCount: _orders.length + 1,
      );
    });
  }

  // 最底部的控件
  Widget _endWidget() {
    if (_orders.length >= _maxLength) {
      return noMoreWidget();
    } else {
      return loadMoreWidget();
    }
  }
}

class _OrderCard extends StatefulWidget {
  final OrderListItem item;

  _OrderCard({Key key, @required this.item})
      : assert(item != null),
        super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard> {
  ListSizeUtil get _size => getListSizeUtil();

  @override
  Widget build(BuildContext context) {
    Column column = Column(
      children: <Widget>[
        Container(
          decoration: _size.orderTopDecoration,
          padding: _size.orderTopContainerPadding,
          child: Row(
            children: <Widget>[
              Text(
                "订单编号:${widget.item.orderNo}",
                style: _size.defaultFontTextStyle,
              ),
              Expanded(
                child: _orderStateMsg(),
              )
            ],
          ),
        )
      ],
    );
    for (var product in widget.item.products) {
      column.children.add(_orderProducts(product));
    }
    column.children.add(Container(
      alignment: Alignment.centerRight,
      margin: _size.orderTotalTextMargin,
      child: Text.rich(
        TextSpan(text: "订单总量: ", children: [
          TextSpan(
            text: "${widget.item.totalNum}",
            style: _size.orderItemProductPriceIconTextStyle,
          ),
          TextSpan(
            text: " 件   订单总额: ",
          ),
          TextSpan(
            text: widget.item.amount.toStringAsFixed(2),
            style: _size.orderItemProductPriceIconTextStyle,
          ),
        ]),
        style: _size.defaultFontTextStyle,
      ),
    ));
    column.children.add(_orderButton());
    return Container(
      margin: _size.orderCartMargin,
      child: Card(
        shape: _size.orderCartShape,
        child: Container(
          padding: _size.tabBarPadding,
          child: column,
        ),
      ),
    );
  }

  // 订单状态
  Widget _orderStateMsg() {
    return Container(
      alignment: Alignment.centerRight,
      padding: _size.orderCartStateMsgContanierMargin,
      child: Text(
        "${widget.item.statusMsg}",
        style: _size.orderStateMsgTextStyle.merge(_size.defaultFontTextStyle),
      ),
    );
  }

  // 订单按钮
  Widget _orderButton() {
//          _orderDelButton(widget.item.orderNo), // 删除订单
//          _orderExpressButton(widget.item.orderNo), // 查看物流
//          _orderCallButton(widget.item.orderNo), // 联系客服
//          _orderCallBackMoneyButton(widget.item.orderNo), // 退款详情
//          _orderAssessButton(widget.item.orderNo), // 去评价
    Row row = Row(
      children: <Widget>[
        Expanded(
          child: Container(),
        )
      ],
    );
    // 待发货按钮
    if (widget.item.status == orderStateValue(OrderState.WaitPendingDelivery)) {
      row.children.add(_orderCallButton(widget.item.orderNo));
    } else {
      row.children.add(_orderCallButton(widget.item.orderNo));
    }
    return Container(
      margin: _size.orderTotalTextMargin,
      child: row,
    );
  }

  // 订单商品
  Widget _orderProducts(OrderListItemProducts product) {
    String attr = "";
    for (var a in product.skus) {
      attr += a.attrValue + " x" + a.num.toString() + "    ";
    }
    attr = attr.trim();
    return Container(
      height: _size.orderItemProductContainerHeight,
      margin: _size.orderItemProductMargin,
      child: Row(
        children: <Widget>[
          Image.network(product.productImg),
          Expanded(
            child: Container(
              margin: _size.orderItemProductTitleContainerMargin,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      product.productName,
                      style: _size.orderItemProductNameTextStyle,
                      maxLines: 2,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        attr,
                        style: _size.orderItemProductAttrTextStyle,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Container(
                    child: Text.rich(
                      TextSpan(
                        text: "价格",
                        children: [
                          TextSpan(
                            text: " ¥",
                            style: _size.orderItemProductPriceIconTextStyle,
                          ),
                          TextSpan(
                            text: product.price.toStringAsFixed(2),
                            style: _size.orderItemProductPriceTextStyle,
                          )
                        ],
                      ),
                      style: _size.defaultFontTextStyle,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// 删除按钮
  Widget _orderDelButton(String orderNo) {
    return Container(
      height: _size.orderButtonContainerHeight,
      margin: _size.orderButtonMargin,
      child: RaisedButton(
        child: Text(
          '删除订单',
          style: _size.defaultFontTextStyle,
        ),
        color: Colors.white,
        shape: _size.orderButtonShape,
        onPressed: () {
          print(orderNo);
        },
      ),
    );
  }

// 查看物流
  Widget _orderExpressButton(String orderNo) {
    return Container(
      height: _size.orderButtonContainerHeight,
      margin: _size.orderButtonMargin,
      child: RaisedButton(
        child: Text(
          '查看物流',
          style: _size.defaultFontTextStyle,
        ),
        shape: _size.orderButtonShape,
        onPressed: () {
          print(orderNo);
        },
      ),
    );
  }

// 联系客服
  Widget _orderCallButton(String orderNo) {
    return Container(
      height: _size.orderButtonContainerHeight,
      margin: _size.orderButtonMargin,
      child: RaisedButton(
        child: Text(
          '联系客服',
          style: _size.defaultFontTextStyle,
        ),
        color: Colors.yellow[800],
        shape: _size.orderButtonShape2,
        onPressed: () {
          print(orderNo);
        },
      ),
    );
  }

// 退款详情
  Widget _orderCallBackMoneyButton(String orderNo) {
    return Container(
      height: _size.orderButtonContainerHeight,
      margin: _size.orderButtonMargin,
      child: RaisedButton(
        child: Text(
          '退款详情',
          style: _size.defaultFontTextStyle,
        ),
        color: Colors.yellow[800],
        shape: _size.orderButtonShape2,
        onPressed: () {
          print(orderNo);
        },
      ),
    );
  }

// 去评价
  Widget _orderAssessButton(String orderNo) {
    return Container(
      height: _size.orderButtonContainerHeight,
      margin: _size.orderButtonMargin,
      child: RaisedButton(
        child: Text(
          '去评价',
          style: _size.defaultFontTextStyle,
        ),
        color: Colors.yellow[800],
        shape: _size.orderButtonShape2,
        onPressed: () {
          print(orderNo);
        },
      ),
    );
  }
}
