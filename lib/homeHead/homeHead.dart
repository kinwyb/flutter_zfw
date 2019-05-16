import 'package:flutter/material.dart';
import 'package:zfw/components/component.dart' as prefix0;
import '../components/api/user.dart';
import '../components/component.dart';
import 'homeHeadSizeUtil.dart';

class HomeHeadPage extends StatefulWidget {
  @override
  _HomeHeadPageState createState() => _HomeHeadPageState();
}

class _HomeHeadPageState extends State<HomeHeadPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool _showRecommend = false;

  UserRebateInfo rebateInfo;
  UserFansInfo fansInfo;
  HomeHeadSizeUtil get _size => getHomeHeadSizeUtil();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    rebateInfo = await UserAPI.rebateInfo();
    fansInfo = await UserAPI.fansInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('当家'),
        automaticallyImplyLeading: false,
      ),
      body: loading(context, fansInfo == null && rebateInfo == null, (context) {
        return ListView.builder(
          itemBuilder: _item,
          itemCount: 7,
        );
      }),
    );
  }

  Widget _item(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _topCard(context);
      case 1:
        return _itemRow("团队佣金");
      case 2:
        return _itemRow("佣金明细");
      case 3:
        return _itemRow("智纺图库");
      case 4:
        return _itemMyFans(context);
      case 5:
        return _itemMyRecommender(context);
      default:
        return Container();
    }
  }

  Widget _topCard(BuildContext context) {
    return Container(
      color: Colors.yellow,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Wrap(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  '当家佣金',
                  style: _size.topTextTextStyle,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('待结算'),
                    onTap(
                        Icon(
                          Icons.help,
                          size: 16,
                        ),
                        () => _rebateHelp(context)),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '¥${rebateInfo.waitSettlementMoney}',
                  style: _size.priceTextStyle,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                  color: Colors.pink,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("今日佣金"),
                          Text(
                            "¥${rebateInfo.dayRebateMoney}",
                            style: _size.priceTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("昨日佣金"),
                          Text(
                            "¥${rebateInfo.yestDayRebateMoney}",
                            style: _size.priceTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("累计总佣金"),
                          Text(
                            "¥${rebateInfo.allRebateMoney}",
                            style: _size.priceTextStyle,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemRow(String name) {
    return GestureDetector(
      onTap: () {
        print(name);
      },
      child: Container(
        height: 40,
        alignment: Alignment.centerLeft,
        decoration: _size.itemRowBoxDecoration,
//        color: Colors.green,
//      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: <Widget>[
            Text(name),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemMyFans(BuildContext context) {
    return onTap(Container(
      height: 100,
//      color: Colors.green,
      decoration: _size.itemRowBoxDecoration,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              children: <Widget>[
                Text("我的粉丝 "),
                onTap(
                    Icon(
                      Icons.help_outline,
                      size: 16,
                    ),
                    () => _fansHelp(context)),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: onTap(Text('查看详情'), () {
                      print('查看详情');
                    }),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text(
                    "${fansInfo.fansCount}人",
                    style: _size.myFansCountTextStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Text("今日"),
                        Text("${fansInfo.todayFansCount}人"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Text("昨日"),
                        Text("${fansInfo.yesterdayFansCount}人"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  // 我的推荐人
  Widget _itemMyRecommender(BuildContext context) {
    Column column = Column(
      children: <Widget>[],
    );
    Icon icon;
    if (_showRecommend) {
      icon = Icon(
        Icons.keyboard_arrow_down,
//        size: 24,
        color: Colors.grey,
      );
    } else {
      icon = Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      );
    }
    Container topContainer = Container(
      height: 40,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: <Widget>[
          Text("我的推荐人"),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: icon,
            ),
          )
        ],
      ),
    );
    column.children.add(onTap(topContainer, () {
      _showRecommend = fansInfo.recommender == null ? false : !_showRecommend;
      setState(() {});
    }));
    if (_showRecommend && fansInfo.recommender != null) {
      column.children.add(
        Container(
          height: 80,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: new CircleAvatar(
                  backgroundImage:
                      new NetworkImage(fansInfo.recommender.portrait),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Wrap(
                    children: <Widget>[
                      Text("${fansInfo.recommender.name}\n"
                          "${fansInfo.recommender.registerTime}"),
                    ],
                  ))
            ],
          ),
        ),
      );
    }
    return column;
  }

  // 粉丝帮助
  void _fansHelp(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return onTap(
            Container(
              height: 150,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      '我的粉丝说明',
                      style: _size.helpTitleTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('我的粉丝说明xxxxxxxxxx'),
                  ),
                ],
              ),
            ),
            () {
              return false;
            },
          );
        });
  }

  // 佣金帮助
  void _rebateHelp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return onTap(
          Container(
            height: 150,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    '待结算佣金说明',
                    style: _size.helpTitleTextStyle,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('待结算佣金说明xxxxxxxxxx'),
                ),
              ],
            ),
          ),
          () {
            return false;
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
