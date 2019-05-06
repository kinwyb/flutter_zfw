import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/component.dart';
import '../components/api/category.dart';
import '../components/router/routers.dart';

const TextStyle _topNameTextStyle = TextStyle(fontSize: 20);

class CategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<CategoryListBean> categorys;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    this.categorys = await CategoryAPI.list();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('全部分类'),
      ),
      body: loading(context, categorys == null, _body),
    );
  }

  Widget _body(BuildContext context) {
    return ListView.builder(
//      shrinkWrap: true,
      itemBuilder: _bodyItem,
      itemCount: categorys.length,
    );
  }

  Widget _bodyItem(BuildContext context, int index) {
    CategoryListBean category = categorys[index];
    Column ret = Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[700]))),
                child: Text(category.name, style: _topNameTextStyle),
              ),
            )
          ],
        )
      ],
    );
    if (category.children != null && category.children.length > 0) {
      ret.children.add(Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: GridView.builder(
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return new _CategoryIcon(
                category: category.children[index],
              );
            },
            itemCount: category.children.length,
            padding: new EdgeInsets.all(5.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 1.0,
              crossAxisCount: 4,
            )),
      ));
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: ret,
    );
  }
}

@immutable
class _CategoryIcon extends StatelessWidget {
  final CategoryListBean category;

  final bool showList;

  _CategoryIcon({Key key, this.category, this.showList = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: Center(
        child: Column(
          children: <Widget>[
            _buildIcon(),
            Text(
              this.category.name,
            ),
          ],
        ),
      ),
      onTap: () {
        categoryNavigate(context, this.category.name);
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
          image: new NetworkImage(this.category.img),
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
