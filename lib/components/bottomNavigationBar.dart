import 'package:flutter/material.dart';
import '../components/router/routers.dart';

const TextStyle _iconTitleTextStyle = TextStyle(fontSize: 10.0);

int _bottomNavigationIndex = 0;

// 底部导航栏
BottomNavigationBar bottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    iconSize: 22.0,
    fixedColor: Colors.yellow[900],
    currentIndex: _bottomNavigationIndex,
    onTap: (index) {
      if (index == _bottomNavigationIndex) {
        return;
      }
      _bottomNavigationIndex = index;
      switch (index) {
        case 1:
          homeHeadNavigate(context);
          break;
        case 2:
          shoppingCartNavigate(context);
          break;
        case 3:
          memberNavigate(context);
          break;
        default:
          homeNavigate(context);
      }
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        title: Text('首页', style: _iconTitleTextStyle),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.crop_original,
        ),
        title: Text('当家', style: _iconTitleTextStyle),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_cart,
        ),
        title: Text('购物车', style: _iconTitleTextStyle),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.account_box,
        ),
        title: Text('会员', style: _iconTitleTextStyle),
      ),
    ],
    //设置显示的模式
    type: BottomNavigationBarType.fixed,
  );
}
