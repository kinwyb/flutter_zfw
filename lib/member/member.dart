import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/api/order.dart';
import 'package:zfw/components/component.dart' as component;
import 'package:zfw/member/blocs/bloc.dart';
import '../components/router/routers.dart';
import 'memberSizeUtil.dart';

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage>
    with AutomaticKeepAliveClientMixin {
  MemberSizeUtil get _size => getMemberSizeUtil();
  final MemberBloc _bloc = new MemberBloc();

  @override
  void initState() {
    super.initState();
    _bloc.dispatch(MemberEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        itemBuilder: _item,
        itemCount: 5,
      ),
//      bottomNavigationBar: component.bottomNavigationBar(context),
    );
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
      margin: _size.defaultContainerMargin,
      color: Colors.white,
      padding: _size.withdrawContainerPadding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: _size.withdrawContainerTopLabelPadding,
                  child: Text.rich(
                    TextSpan(
                        text: "可提现余额(元)",
                        style: _size.fontTitleTextStyle,
                        children: [
                          TextSpan(
                            text: " 可提现至微信零钱",
                            style: _size.defaultFontSizeTextStyle,
                          )
                        ]),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: BlocBuilder<MemberEvent, MemberState>(
                    bloc: _bloc,
                    builder: (context, state) {
                      if (state.userInfo == null) {
                        return Container();
                      }
                      return Text(
                        state.userInfo.availableMoney.toStringAsFixed(2),
                        style: _size.topContainerPriceTextStyle,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: _size.withdrawContainerButtonWidth,
            height: _size.withdrawContainerButtonHeight,
            margin: _size.withdrawContainerButtonMargin,
            child: RaisedButton(
              color: Colors.yellow[700],
              onPressed: () {
                print('提现');
                loginNavigate(context);
              },
              child: Text(
                '提现',
                style: defaultFontTextStyle,
              ),
              shape: RoundedRectangleBorder(borderRadius: borderRadiusCircular),
            ),
          ),
        ],
      ),
    );
  }

  // 订单
  Widget _orderInfo(BuildContext context) {
    return Container(
      margin: _size.defaultContainerMargin,
      padding: _size.orderContainerPadding,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            decoration: _size.orderWidgetBottomBorder,
            padding: _size.orderContainerTopLabelPadding,
            margin: _size.orderContainerTopLabelMargin,
            alignment: Alignment.bottomLeft,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '我的订单',
                    style: _size.fontTitleTextStyle,
                  ),
                ),
                component.onTap(
                  Text(
                    '查看全部订单  ',
                    style: _size.defaultFontSizeTextStyle,
                  ),
                  () {
                    orderListNavigate(context, orderStateValue(OrderState.All));
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<MemberEvent, MemberState>(
            bloc: _bloc,
            builder: (context, state) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: _size.orderContainerIconTitleHeight,
//                  color: Colors.teal,
                      child: component.IconTitle(
                        icon: Icon(Icons.account_balance_wallet),
                        title: Text(
                          '待付款',
                          style: _size.defaultFontSizeTextStyle,
                        ),
                        num: state.dataCount?.waitPayOrder ?? 0,
                        onTap: () {
                          orderListNavigate(
                              context, orderStateValue(OrderState.WaitPay));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: _size.orderContainerIconTitleHeight,
                      child: component.IconTitle(
                          icon: Icon(Icons.reorder),
                          title: Text(
                            '待成团',
                            style: _size.defaultFontSizeTextStyle,
                          ),
                          onTap: () {
                            orderListNavigate(
                                context, orderStateValue(OrderState.Grouping));
                          }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: _size.orderContainerIconTitleHeight,
                      child: component.IconTitle(
                          icon: Icon(Icons.card_giftcard),
                          title: Text(
                            '待发货',
                            style: _size.defaultFontSizeTextStyle,
                          ),
                          num: state.dataCount?.waitSending ?? 0,
                          onTap: () {
                            orderListNavigate(
                                context,
                                orderStateValue(
                                    OrderState.WaitPendingDelivery));
                          }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: _size.orderContainerIconTitleHeight,
                      child: component.IconTitle(
                          icon: Icon(Icons.card_giftcard),
                          title: Text(
                            '待收货',
                            style: _size.defaultFontSizeTextStyle,
                          ),
                          num: state.dataCount?.waitDelivey ?? 0,
                          onTap: () {
                            orderListNavigate(context,
                                orderStateValue(OrderState.WaitDelivery));
                          }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: _size.orderContainerIconTitleHeight,
                      child: component.IconTitle(
                          icon: Icon(Icons.chat),
                          title: Text(
                            '待评价',
                            style: _size.defaultFontSizeTextStyle,
                          ),
                          num: state.dataCount?.waitAssess ?? 0,
                          onTap: () {
                            orderListNavigate(context,
                                orderStateValue(OrderState.WaitAssess));
                          }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: _size.orderContainerIconTitleHeight,
                      child: component.IconTitle(
                        icon: Icon(Icons.account_balance_wallet),
                        title: Text(
                          '售后',
                          style: _size.defaultFontSizeTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // 底部Icon
  Widget _icons(BuildContext context) {
    return Container(
      margin: _size.bottomIconsContainerMargin,
      padding: _size.bottomIconsContainerPadding,
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
        return BlocBuilder<MemberEvent, MemberState>(
          bloc: _bloc,
          builder: (context, state) {
            return Container(
//          color: Colors.green,
              child: component.IconTitle(
                icon: Icon(
                  Icons.branding_watermark,
                  size: _size.bottomIconSize,
                ),
                title: Text(
                  '优惠卷',
                  style: _size.defaultFontSizeTextStyle,
                ),
                num: state.dataCount?.coupons ?? 0,
              ),
            );
          },
        );
      case 1:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.star_border,
              size: _size.bottomIconSize,
            ),
            title: Text(
              '收藏',
              style: _size.defaultFontSizeTextStyle,
            ),
          ),
        );
      case 2:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.location_on,
              size: _size.bottomIconSize,
            ),
            title: Text(
              '收货地址',
              style: _size.defaultFontSizeTextStyle,
            ),
            onTap: () {
              memberAddressNavigate(context);
            },
          ),
        );
      case 3:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.monetization_on,
              size: _size.bottomIconSize,
            ),
            title: Text(
              '补差价',
              style: _size.defaultFontSizeTextStyle,
            ),
          ),
        );
      case 4:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.local_activity,
              size: _size.bottomIconSize,
            ),
            title: Text(
              '增值发票',
              style: _size.defaultFontSizeTextStyle,
            ),
          ),
        );
      case 5:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.supervised_user_circle,
              size: _size.bottomIconSize,
            ),
            title: Text(
              '客服',
              style: _size.defaultFontSizeTextStyle,
            ),
          ),
        );
      case 6:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.share,
              size: _size.bottomIconSize,
            ),
            title: Text(
              '分享',
              style: _size.defaultFontSizeTextStyle,
            ),
          ),
        );
      case 7:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.dialer_sip,
              size: _size.bottomIconSize,
            ),
            title: Text(
              '联系方式',
              style: _size.defaultFontSizeTextStyle,
            ),
          ),
        );
      case 8:
        return Container(
//          color: Colors.green,
          child: component.IconTitle(
            icon: Icon(
              Icons.portrait,
              size: _size.bottomIconSize,
            ),
            title: Text(
              '已绑定',
              style: _size.defaultFontSizeTextStyle,
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Widget _topCard(BuildContext context) {
    return Container(
      color: Colors.yellow[700],
      padding: _size.topContainerPadding,
      height: _size.topContainerHeight,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: BlocBuilder<MemberEvent, MemberState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state.userInfo == null || state.rebateInfo == null) {
              return Container();
            }
            return Row(
              children: <Widget>[
                Container(
                  height: _size.topContainerPortraitHeight,
                  width: _size.topContainerPortraitHeight,
                  margin: _size.topContainerPortraitMargin,
                  child: new CircleAvatar(
                    backgroundColor: Colors.pink,
                    backgroundImage: new NetworkImage(
                        "http://fsbd.test.zhifangw.cn/v1/file/read?filename=" +
                            state.userInfo.portrait),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          margin: _size.topContainerUserNameMargin,
                          child: Text(
                            state.userInfo.nickname,
                            style: _size.topContainerUserNameTextStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: _size.topContainerWaitSettliementMoneyMargin,
                          child: Text.rich(
                            TextSpan(
                              text: '待结算佣金: ',
                              style: _size.defaultFontSizeTextStyle,
                              children: [
                                TextSpan(
                                  text:
                                      "${state.rebateInfo.waitSettlementMoney}",
                                  style: _size.topContainerPriceTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: _size.topContainerPhoneMargin,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone_android,
                        size: _size.topContainerPhoneIconSize,
                      ),
                      Text(
                        '绑定手机号',
                        style: _size.defaultFontSizeTextStyle,
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
