import 'package:flutter/material.dart';
import '../components/api/activity.dart';
import '../components/api/beans/img.dart';
import '../components/refresh.dart';
import './imgs.dart';
import './title.dart';
import './template.dart';
import './bottomBar.dart';

@immutable
class Activity extends StatefulWidget {
  final String activityCode;

  Activity({Key key, this.activityCode}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ActivityState(this.activityCode);
}

class ActivityState extends State<Activity>
    with SingleTickerProviderStateMixin {
  String activityCode;

  ActivityInfo info;
  List<ActivityProductSKU> skus;

  final ActivityBottomBar bottomBar = new ActivityBottomBar();

  ActivityState(this.activityCode);

  List<String> tabList = ['详情', '质检报告'];
  TabController mController;

  void loadData() async {
    this.info = await ActivityAPI.info(activityCode);
    this.skus = await ActivityAPI.sku(activityCode, this.info.ProductNo);
    this.bottomBar.info = this.info;
    this.bottomBar.skus = skus;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  void initState() {
    super.initState();
    mController = new TabController(
      vsync: this,
      length: 2,
    );
    mController.addListener(() {
      setState(() {});
    });
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('商品详情'),
      ),
      body: body(),
      bottomNavigationBar: bottomBar,
    );
  }

  Widget body() {
    if (info == null) {
      return loadMoreWidget();
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: _item,
      );
    }
  }

  Widget _item(BuildContext context, int index) {
    if (index == 0) {
      return new ActivityImages(imgs: info.Imgs);
    } else if (index == 1) {
      return new ActivityTitle(info: info);
    } else if (index == 2) {
      return new ActivityTemplateWidget(template: info.Template);
    } else if (index == 3) {
      return Container(
        color: Colors.white,
        height: 38.0,
        child: TabBar(
          isScrollable: false,
          //是否可以滚动
          controller: mController,
          labelColor: Colors.black,
          unselectedLabelColor: Color(0xff666666),
          labelStyle: TextStyle(fontSize: 12.0),
          tabs: tabList.map((item) {
            return Container(
              width: (MediaQuery.of(context).size.width - 60) / 2,
              child: Tab(
                text: item,
              ),
            );
          }).toList(),
        ),
      );
    } else {
      if (mController.index == 0) {
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _productAttrs(),
              new ActivityDescImages(imgs: info.ProductDescription),
            ],
          ),
        );
      } else {
        var imgs = List<ImgInfo>();
        imgs.add(ImgInfo.fromParams(
            Src:
                "https://qiniu.zhifangw.cn/O-20190105152558802194096.png?filename=MjAxOTAxMDUxNTI1NTg4MDIxOTQwOTYucG5n"));
        return new ActivityDescImages(imgs: imgs);
      }
    }
  }

  // 商品规格属性
  Widget _productAttrs() {
    if (info.ProductAttrs == null || info.ProductAttrs.length < 1) {
      return Container();
    }
    List<TableRow> tableRows = [];
    for (var attr in info.ProductAttrs) {
      tableRows.add(TableRow(
        children: <Widget>[
          Container(
            height: 40,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(attr.name),
          ),
          Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(attr.value),
          ),
        ],
      ));
    }
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      color: Colors.white,
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(100.0),
          1: FixedColumnWidth(200.0),
        },
        border: TableBorder.all(
            color: Colors.grey[300], width: 1.0, style: BorderStyle.solid),
        children: tableRows,
      ),
    );
  }
}
