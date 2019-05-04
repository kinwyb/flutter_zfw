import 'package:flutter/material.dart';
import '../components/api/home.dart';
import '../components/router/routers.dart';

class HomeCategory extends StatefulWidget {
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
    if (this.categorys != null && this.categorys.length < 8) {
      this.categorys.add(IndexCategory.fromParams(
            Img:
                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556600825917&di=4058b10d1acaa57f5803b52f059db067&imgtype=0&src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F00%2F92%2F44%2F0456f220df03182.jpg",
            Name: "更多",
          ));
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
    return new _categoryIcon(
      category: this.categorys[index],
    );
  }
}

class _categoryIcon extends StatelessWidget {
  IndexCategory category;

  _categoryIcon({Key key, this.category}) : super(key: key);

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
        categoryNavigate(context, this.category.Name);
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
