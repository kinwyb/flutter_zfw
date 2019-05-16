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
  runApp(Zfw());
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

class Zfw extends StatefulWidget {
  @override
  _ZfwState createState() => _ZfwState();
}

class _ZfwState extends State<Zfw> {
  // 界面
  List<Widget> _pages = [
    HomeWidget(),
    HomeHeadPage(),
    ShoppingCartPage(),
    MemberPage()
  ];

  final _ZfwBottomBloc _bloc = new _ZfwBottomBloc();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _pageController.dispose();
  }

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
      home: Scaffold(
        body: PageView.builder(
          //要点1
          physics: NeverScrollableScrollPhysics(), //禁止页面左右滑动切换
          controller: _pageController,
          itemCount: _pages.length,
          itemBuilder: (context, index) => _pages[index],
        ),
        bottomNavigationBar: bottomNavigationBar(context),
      ),
    ));
  }

  int _bottomNavigationIndex = 0;

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
    _pageController.animateToPage(index,
        duration: kThemeAnimationDuration, curve: Curves.easeIn);
    _bloc.dispatch(_ZfwBottomIndexEvent(index));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
