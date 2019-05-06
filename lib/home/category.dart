import 'package:flutter/material.dart';
import '../components/api/home.dart';
import '../components/router/routers.dart';

const _moreText = "更多";
const _moreImg =
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556600825917&di=4058b10d1acaa57f5803b52f059db067&imgtype=0&src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F00%2F92%2F44%2F0456f220df03182.jpg";

@immutable
class HomeCategory extends StatefulWidget {
  final bool showLoadMore;

  HomeCategory({Key key, this.showLoadMore = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new HomeCategoryState();
}

class HomeCategoryState extends State<HomeCategory> {
  List<IndexCategory> categorys = new List<IndexCategory>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var categorys = await HomeAPI.categorys();
    this.categorys = categorys;
    this._addMore();
    setState(() {});
  }

  void _addMore() {
    if (widget.showLoadMore) {
      if (this.categorys != null && this.categorys.length < 8) {
        this.categorys.add(IndexCategory.fromParams(
              Img: _moreImg,
              Name: _moreText,
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: GridView.builder(
          physics: new NeverScrollableScrollPhysics(),
          itemBuilder: _buildItem,
          itemCount: this.categorys.length,
          padding: new EdgeInsets.all(20.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 20.0,
            crossAxisCount: 4,
          )),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return new _CategoryIcon(
      category: this.categorys[index],
      showList: index == this.categorys.length - 1,
    );
  }
}

@immutable
class _CategoryIcon extends StatelessWidget {
  final IndexCategory category;

  final bool showList;

  _CategoryIcon({Key key, this.category, this.showList = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Column(
        children: <Widget>[
          _buildIcon(),
          Text(this.category.Name),
        ],
      ),
      onTap: () {
        if (this.showList) {
          categoryListNavigate(context);
        } else {
          categoryNavigate(context, this.category.Name);
        }
      },
    );
  }

  Widget _buildIcon() {
    return Container(
      height: 50.0,
      width: 50.0,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        image: new DecorationImage(
          image: new NetworkImage(this.category.Img),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          new BoxShadow(
            offset: new Offset(0.0, 1.0),
            blurRadius: 2.0,
            color: const Color(0xffaaaaaa),
          ),
        ],
      ),
    );
  }
}
