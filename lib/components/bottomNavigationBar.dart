import 'package:flutter/material.dart';

class BottomNavigationBarUtil {
  static const TextStyle _iconTitleTextStyle =
      TextStyle(fontSize: 7.0);

  static Widget wapped(BuildContext context, Widget wg) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height - 75,
          child: wg,
        ),
        Container(
          height: 75.0,
          child: BottomNavigationBar(
            iconSize: 20.0,
            fixedColor: Colors.black,
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
          ),
        ),
      ],
    );
  }
}
