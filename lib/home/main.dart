import 'package:flutter/material.dart';
import './banner.dart';
import './category.dart';
import './brand.dart';
import '../components/api/home.dart';
import '../components/refresh.dart';
import '../components/bottomNavigationBar.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  List<IndexBrand> brands = new List<IndexBrand>();

  ScrollController _scrollController = ScrollController(); //listview的控制器

  int _page = 1; //加载的页数
  bool isLoading = false; //是否正在加载数据
  bool isEnd = false; //是否全部加载完成

  @override
  void initState() {
    super.initState();
    isEnd = false;
    _page = 1;
    loadData();
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

  Future loadData() async {
    if (!isEnd) {
      var brands = await HomeAPI.brands(_page);
      brands = brands ?? [];
      _page++;
      if (brands.length < 1) {
        isEnd = true;
        _scrollController.removeListener(lostenerScrollController);
      }
      setState(() {
        this.isLoading = false;
        this.brands.addAll(brands);
      });
    }
  }

  // 刷新界面
  Future<void> refresh() {
    _page = 1;
    isEnd = false;
    this.brands.clear();
    if (!_scrollController.hasListeners) {
      _scrollController.addListener(lostenerScrollController);
    }
    return this.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('智纺工场'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          itemBuilder: _buildItem,
          itemCount: brands.length + 3,
          controller: _scrollController,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == 0) {
      return new HomeBanner();
    } else if (index == 1) {
      return new HomeCategory(
        showLoadMore: true,
      );
    } else if (index > this.brands.length + 1) {
      if (isEnd) {
        return noMoreWidget();
      }
      return loadMoreWidget();
    } else if (index > 1 && this.brands.length > 0) {
      index = index - 2;
      return HomeBrand(brand: this.brands[index]);
    }
    return Container();
  }

  // 加载更多
  Future _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      loadData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
