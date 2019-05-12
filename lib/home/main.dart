import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zfw/home/blocs/bloc.dart';
import './banner.dart';
import './category.dart';
import './brand.dart';
import '../components/api/home.dart';
import '../components/refresh.dart';
import '../components/bottomNavigationBar.dart';
import 'blocs/homebrand_bloc.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  final HomebrandBloc _bloc = new HomebrandBloc();
  ScrollController _scrollController = ScrollController(); //listview的控制器

  int _page = 1; //加载的页数
  bool isLoading = false; //是否正在加载数据
  bool isEnd = false; //是否全部加载完成

  @override
  void initState() {
    super.initState();
    isEnd = false;
    _page = 1;
    _bloc.dispatch(HomebrandEvent(1));
    _scrollController.addListener(lostenerScrollController);
  }

  void lostenerScrollController() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isEnd) {
        _getMore();
      }
    }
  }

  // 刷新界面
  Future<void> refresh() async {
    _page = 1;
    isEnd = false;
    _bloc.dispatch(HomebrandEvent(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('智纺工场'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: BlocBuilder<HomebrandEvent, HomebrandState>(
          bloc: _bloc,
          builder: (context, state) {
            isLoading = false;
            isEnd = state.isEnd;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return new HomeBanner();
                } else if (index == 1) {
                  return new HomeCategory();
                } else if (index > state.data.length + 1) {
                  if (isEnd) {
                    return noMoreWidget();
                  }
                  return loadMoreWidget();
                } else if (index > 1 && state.data.length > 0) {
                  index = index - 2;
                  return HomeBrand(brand: state.data[index]);
                }
                return Container();
              },
              itemCount: state.data.length + 3,
              controller: _scrollController,
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  // 加载更多
  Future _getMore() async {
    if (!isLoading) {
      isLoading = true;
      _page++;
      _bloc.dispatch(HomebrandEvent(_page));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _scrollController.dispose();
  }
}
