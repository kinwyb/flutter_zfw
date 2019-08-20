import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zfw/components/component.dart';
import './home/main.dart';
import './components/router/routers.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

import 'components/adapt.dart';
import 'homeHead/homeHead.dart';
import 'member/member.dart';
import 'shoppingCart/shoppingCart.dart';

void main() {
  fluwx.register(appId: "wxdc079d97fd7b8b73");
  routerInit();
  initData();
  runApp(ZFW());
}

class ZFW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return toast(MaterialApp(
      title: '智纺工场',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: showPerformanceOverlay,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generator,
      home: MainPage(0),
    ));
  }
}

class _ZfwBottomIndexEvent {
  final int index;
  _ZfwBottomIndexEvent(this.index);
}

class _ZfwBottomBloc extends Bloc<_ZfwBottomIndexEvent, _ZfwBottomIndexEvent> {
  @override
  _ZfwBottomIndexEvent get initialState => _ZfwBottomIndexEvent(0);

  @override
  Stream<_ZfwBottomIndexEvent> mapEventToState(
    _ZfwBottomIndexEvent event,
  ) async* {
    yield event;
  }
}

class MainPage extends StatefulWidget {
  final int _bottomNavigationIndex;

  MainPage(this._bottomNavigationIndex);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 界面
  List<Widget> _pages = [
    Home(),
    HomeHeadPage(),
    ShoppingCartPage(),
    MemberPage()
  ];

  final _ZfwBottomBloc _bloc = new _ZfwBottomBloc();
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _bottomNavigationIndex = widget._bottomNavigationIndex;
    _pageController = PageController(
      initialPage: widget._bottomNavigationIndex,
    );
    _bloc.dispatch(_ZfwBottomIndexEvent(widget._bottomNavigationIndex));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(), //禁止页面左右滑动切换
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (context, index) => _pages[index],
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  int _bottomNavigationIndex;

  final _bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      title: Text('首页', style: defaultFontTextStyle),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.crop_original,
      ),
      title: Text('当家', style: defaultFontTextStyle),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.shopping_cart,
      ),
      title: Text('购物车', style: defaultFontTextStyle),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.account_box,
      ),
      title: Text('会员', style: defaultFontTextStyle),
    ),
  ];

// 底部导航栏
  Widget bottomNavigationBar(BuildContext context) {
    return BlocBuilder<_ZfwBottomIndexEvent, _ZfwBottomIndexEvent>(
      bloc: _bloc,
      builder: (context, state) {
        return BottomNavigationBar(
          iconSize: Adapt.px(46),
          fixedColor: Colors.yellow[900],
          currentIndex: state.index,
          onTap: _bottomItemTap,
          items: _bottomItems,
          //设置显示的模式
          type: BottomNavigationBarType.fixed,
        );
      },
    );
  }

  void _bottomItemTap(index) {
    if (index == _bottomNavigationIndex) {
      return;
    }
    _bottomNavigationIndex = index;
    _pageController.jumpToPage(index);
//    _pageController.animateToPage(index,
//        duration: kThemeAnimationDuration, curve: Curves.easeIn);
    _bloc.dispatch(_ZfwBottomIndexEvent(index));
  }
}
