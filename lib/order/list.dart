import 'package:flutter/material.dart';
import 'package:zfw/components/api/order.dart';
import 'package:zfw/components/component.dart';

class OrderListPage extends StatefulWidget {
  final int orderState; //订单状态

  OrderListPage({Key key, this.orderState}) : super(key: key);

  @override
  _OrderListPageState createState() =>
      _OrderListPageState(orderStateParse(orderState));
}

const _tabBarTextStyle = TextStyle(
  fontSize: 14,
//  color: Colors.grey,
);
const _tabBarPaddingAll10 = EdgeInsets.all(10);
final _tabBarIndicator = BoxDecoration(
  color: Colors.red,
  borderRadius: BorderRadius.circular(20),
);

class _OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

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
            padding: _tabBarPaddingAll10,
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicator: _tabBarIndicator,
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
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
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
      style: _tabBarTextStyle,
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

final _orderCartShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
);
final _orderCartMargin = EdgeInsets.only(bottom: 5);
final _orderStateMsgTextStyle = TextStyle(
  color: Colors.red,
);
final _orderTopDecoration = BoxDecoration(
//  color: Colors.amber,
  border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
);
final _orderItemProductNameTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
final _orderItemProductMargin = EdgeInsets.only(top: 10, bottom: 10);
final _orderItemProductTitleContainerMargin = EdgeInsets.only(left: 10);
final _orderItemProductAttrTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 12,
  height: 2,
);
final _orderItemProductPriceIconTextStyle = TextStyle(
  color: Colors.red,
);
final _orderItemProductPriceTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
final _orderTotalTextMargin = EdgeInsets.only(top: 10);
final _orderButtonTextStyle = TextStyle(
  fontSize: 12,
);
final _orderButtonMargin = EdgeInsets.only(left: 10);
final _orderButtonShape = RoundedRectangleBorder(
  side: BorderSide(
    width: 1,
    color: Colors.grey,
  ),
  borderRadius: BorderRadius.circular(20),
);
final _orderButtonShape2 = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20),
);
// 删除按钮
Widget _orderDelButton(String orderNo) {
  return Container(
    height: 25,
    width: 80,
    margin: _orderButtonMargin,
    child: RaisedButton(
      child: Text(
        '删除订单',
        style: _orderButtonTextStyle,
      ),
      color: Colors.white,
      shape: _orderButtonShape,
      onPressed: () {
        print(orderNo);
      },
    ),
  );
}

// 查看物流
Widget _orderExpressButton(String orderNo) {
  return Container(
    height: 25,
    width: 80,
    margin: _orderButtonMargin,
    child: RaisedButton(
      child: Text(
        '查看物流',
        style: _orderButtonTextStyle,
      ),
      shape: _orderButtonShape,
      onPressed: () {
        print(orderNo);
      },
    ),
  );
}

// 联系客服
Widget _orderCallButton(String orderNo) {
  return Container(
    height: 25,
    width: 80,
    margin: _orderButtonMargin,
    child: RaisedButton(
      child: Text(
        '联系客服',
        style: _orderButtonTextStyle,
      ),
      color: Colors.yellow[800],
      shape: _orderButtonShape2,
      onPressed: () {
        print(orderNo);
      },
    ),
  );
}

// 退款详情
Widget _orderCallBackMoneyButton(String orderNo) {
  return Container(
    height: 25,
    width: 80,
    margin: _orderButtonMargin,
    child: RaisedButton(
      child: Text(
        '退款详情',
        style: _orderButtonTextStyle,
      ),
      color: Colors.yellow[800],
      shape: _orderButtonShape2,
      onPressed: () {
        print(orderNo);
      },
    ),
  );
}

// 去评价
Widget _orderAssessButton(String orderNo) {
  return Container(
    height: 25,
    width: 70,
    margin: _orderButtonMargin,
    child: RaisedButton(
      child: Text(
        '去评价',
        style: _orderButtonTextStyle,
      ),
      color: Colors.yellow[800],
      shape: _orderButtonShape2,
      onPressed: () {
        print(orderNo);
      },
    ),
  );
}

class _OrderCardState extends State<_OrderCard> {
  @override
  Widget build(BuildContext context) {
    Column column = Column(
      children: <Widget>[
        Container(
          height: 30,
          decoration: _orderTopDecoration,
          child: Row(
            children: <Widget>[
              Text("订单编号:${widget.item.orderNo}"),
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
      margin: _orderTotalTextMargin,
      child: Text.rich(
        TextSpan(text: "订单总量: ", children: [
          TextSpan(
            text: "${widget.item.totalNum}",
            style: _orderItemProductPriceIconTextStyle,
          ),
          TextSpan(
            text: " 件   订单总额: ",
          ),
          TextSpan(
            text: widget.item.amount.toStringAsFixed(2),
            style: _orderItemProductPriceIconTextStyle,
          ),
        ]),
      ),
    ));
    column.children.add(_orderButton());
    return Container(
      margin: _orderCartMargin,
      child: Card(
        shape: _orderCartShape,
        child: Container(
          padding: _tabBarPaddingAll10,
          child: column,
        ),
      ),
    );
  }

  // 订单状态
  Widget _orderStateMsg() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        "${widget.item.statusMsg}",
        style: _orderStateMsgTextStyle,
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
      height: 30,
      margin: _orderTotalTextMargin,
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
      height: 100,
      margin: _orderItemProductMargin,
      child: Row(
        children: <Widget>[
          Image.network(product.productImg),
          Expanded(
            child: Container(
              margin: _orderItemProductTitleContainerMargin,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      product.productName,
                      style: _orderItemProductNameTextStyle,
                      maxLines: 2,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        attr,
                        style: _orderItemProductAttrTextStyle,
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
                            style: _orderItemProductPriceIconTextStyle,
                          ),
                          TextSpan(
                            text: product.price.toStringAsFixed(2),
                            style: _orderItemProductPriceTextStyle,
                          )
                        ],
                      ),
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
}
