import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/home/blocs/bloc.dart';
import '../components/api/home.dart';
import '../components/router/routers.dart';
import 'homeSizeUtil.dart';

const _moreText = "更多";
const _moreImg =
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556600825917&di=4058b10d1acaa57f5803b52f059db067&imgtype=0&src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F00%2F92%2F44%2F0456f220df03182.jpg";

@immutable
class HomeCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeCategoryState();
}

class HomeCategoryState extends State<HomeCategory> {
  final HomecategoryBloc _bloc = new HomecategoryBloc();
  HomePageSizeUtil get homeSize => getHomePageSizeUtil();

  @override
  void initState() {
    super.initState();
    _bloc.dispatch(HomecategoryEvent.Load);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: homeSize.categoryContainerHeight,
      child: BlocBuilder<HomecategoryEvent, HomecategoryState>(
        bloc: _bloc,
        builder: (context, state) {
          List<IndexCategory> categorys = state.data ?? [];
          if (categorys != null && categorys.length < 8) {
            categorys.add(IndexCategory.fromParams(
              Img: _moreImg,
              Name: _moreText,
            ));
          }
          return GridView.builder(
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return new _CategoryIcon(
                category: categorys[index],
                showList: index == categorys.length - 1,
              );
            },
            itemCount: categorys.length,
            padding: homeSize.categoryGridPadding,
            gridDelegate: homeSize.categoryGridDelegate,
          );
        },
      ),
    );
  }
}

@immutable
class _CategoryIcon extends StatelessWidget {
  HomePageSizeUtil get homeSize => getHomePageSizeUtil();
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
          Text(
            this.category.Name,
            style: defaultFontTextStyle,
          ),
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
      height: homeSize.categoryIconContainerSize,
      width: homeSize.categoryIconContainerSize,
      margin: homeSize.categoryIconMargin,
      decoration: BoxDecoration(
        color: Colors.white,
        image: new DecorationImage(
          image: new NetworkImage(this.category.Img),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
