import 'package:flutter/material.dart';
import 'package:zfw/components/api/order.dart';
import 'package:zfw/components/api/user.dart';
import 'package:zfw/components/component.dart' as component;
import '../components/router/routers.dart';

class MemberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '会员中心',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generator,
      home: new MemberPage(),
    );
  }
}

const _nickNameTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
const _priceTextStyle = TextStyle(
  fontSize: 14,
  color: Colors.red,
  fontWeight: FontWeight.bold,
);
final _fontSize12TextStyle = TextStyle(
  fontSize: 12,
  color: Colors.grey[700],
);
const _fontTitleTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
const _orderWidgetBottomBorder = BoxDecoration(
  border: Border(
    bottom: BorderSide(
      width: 1,
      color: Colors.grey,
    ),
  ),
);

const _iconSize = 30.0;

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  UserInfo userInfo;
  UserRebateInfo rebateInfo;
  UserDataCount dataCount;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // 加载数据
  void _loadData() async {
    userInfo = await UserAPI.userInfo();
    rebateInfo = await UserAPI.rebateInfo();
    dataCount = await UserAPI.dataCount();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      backgroundColor: Colors.grey[100],
      body: component.loading(context, !_loadingFinish(), (context) {
        return ListView.builder(
          itemBuilder: _item,
          itemCount: 5,
        );
      }),
      bottomNavigationBar: component.bottomNavigationBar(context),
    );
  }

  // 是否加载完成
  bool _loadingFinish() {
    return userInfo != null && rebateInfo != null && dataCount != null;
  }

  Widget _item(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _topCard(context);
      case 1:
        return _withdraw(context);
      case 2:
        return _orderInfo(context);
      case 3:
        return _icons(context);
      default:
        return Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        );
    }
  }

  // 提现
  Widget _withdraw(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Text.rich(
                    TextSpan(
                        text: "可提现余额(元)",
                        style: _fontTitleTextStyle,
                        children: [
                          TextSpan(
                            text: " 可提现至微信零钱",
                            style: _fontSize12TextStyle,
                          )
                        ]),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '46.2',
                    style: _priceTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 70,
            height: 30,
//            color: Colors.amber,
            child: RaisedButton(
              color: Colors.yellow[700],
              onPressed: () {
                print('提现');
              },
              child: Text('提现'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }

  // 订单
  Widget _orderInfo(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            decoration: _orderWidgetBottomBorder,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            alignment: Alignment.bottomLeft,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '我的订单',
                    style: _fontTitleTextStyle,
                  ),
                ),
                component.onTap(
                  Text(
                    '查看全部订单  ',
                    style: _fontSize12TextStyle,
                  ),
                  () {
                    orderListNavigate(context, orderStateValue(OrderState.All));
                  },
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 60,
//                  color: Colors.teal,
                  child: component.IconTitle(
                    icon: Icon(Icons.account_balance_wallet),
                    title: Text('待付款'),
                    num: dataCount.waitPayOrder,
                    onTap: () {
                      orderListNavigate(
                          context, orderStateValue(OrderState.WaitPay));
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  child: component.IconTitle(
                      icon: Icon(Icons.reorder),
                      title: Text('待成团'),
                      onTap: () {
                        orderListNavigate(
                            context, orderStateValue(OrderState.Grouping));
                      }),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  child: component.IconTitle(
                      icon: Icon(Icons.card_giftcard),
                      title: Text('待发货'),
                      num: dataCount.waitSending,
                      onTap: () {
                        orderListNavigate(context,
                            orderStateValue(OrderState.WaitPendingDelivery));
                      }),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  child: component.IconTitle(
                      icon: Icon(Icons.card_giftcard),
                      title: Text('待收货'),
                      num: dataCount.waitDelivey,
                      onTap: () {
                        orderListNavigate(
                            context, orderStateValue(OrderState.WaitDelivery));
                      }),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  child: component.IconTitle(
                      icon: Icon(Icons.chat),
                      title: Text('待评价'),
                      num: dataCount.waitAssess,
                      onTap: () {
                        orderListNavigate(
                            context, orderStateValue(OrderState.WaitAssess));
                      }),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  child: component.IconTitle(
                    icon: Icon(Icons.account_balance_wallet),
                    title: Text('退换/售后'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 底部Icon
  Widget _icons(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      color: Colors.white,
      child: GridView.builder(
        physics: ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 1.0,
          crossAxisCount: 4,
          childAspectRatio: 1.5,
        ),
        shrinkWrap: true,
        itemCount: 9,
        itemBuilder: _iconGridViewItemBuild,
      ),
    );
  }

  Widget _iconGridViewItemBuild(BuildContext context, int index) {
    switch (index) {
      case 0:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.branding_watermark,
              size: _iconSize,
            ),
            title: Text('优惠卷'),
            num: dataCount.coupons,
          ),
        );
      case 1:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.star_border,
              size: _iconSize,
            ),
            title: Text('收藏'),
            num: dataCount.coupons,
          ),
        );
      case 2:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.location_on,
              size: _iconSize,
            ),
            title: Text('收货地址'),
            num: dataCount.coupons,
          ),
        );
      case 3:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.monetization_on,
              size: _iconSize,
            ),
            title: Text('补差价'),
            num: dataCount.coupons,
          ),
        );
      case 4:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.local_activity,
              size: _iconSize,
            ),
            title: Text('增值发票'),
            num: dataCount.coupons,
          ),
        );
      case 5:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.supervised_user_circle,
              size: _iconSize,
            ),
            title: Text('客服'),
            num: dataCount.coupons,
          ),
        );
      case 6:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.share,
              size: _iconSize,
            ),
            title: Text('分享'),
            num: dataCount.coupons,
          ),
        );
      case 7:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.dialer_sip,
              size: _iconSize,
            ),
            title: Text('联系方式'),
            num: dataCount.coupons,
          ),
        );
      case 8:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.portrait,
              size: _iconSize,
            ),
            title: Text('已绑定'),
            num: dataCount.coupons,
          ),
        );
      default:
        return Container();
    }
    ;
  }

  Widget _topCard(BuildContext context) {
    return Container(
      color: Colors.yellow[700],
      padding: EdgeInsets.all(20),
      height: 150,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: new CircleAvatar(
                backgroundColor: Colors.pink,
                backgroundImage: new NetworkImage(
                    "http://fsbd.test.zhifangw.cn/v1/file/read?filename=" +
                        userInfo.portrait),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(10, 27, 0, 0),
//                        color: Colors.green,
                    height: 20,
                    child: Text(
                      userInfo.nickname,
                      style: _nickNameTextStyle,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
//                        color: Colors.amber,
                        height: 20,
                        margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Text.rich(
                          TextSpan(
                            text: '待结算佣金: ',
                            style: _fontSize12TextStyle,
                            children: [
                              TextSpan(
                                text: "${rebateInfo.waitSettlementMoney}",
                                style: _priceTextStyle,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.phone_android,
                    size: 12,
                  ),
                  Text(
                    '绑定手机号',
                    style: _fontSize12TextStyle,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
