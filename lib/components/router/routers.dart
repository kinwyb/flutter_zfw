import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:zfw/homeHead/homeHead.dart';
import 'package:zfw/member/address.dart';
import 'package:zfw/member/addressAdd.dart';
import 'package:zfw/member/member.dart';
import 'package:zfw/order/create.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:zfw/shoppingCart/shoppingCart.dart';
import '../api/request.dart';
import '../../activity/main.dart';
import '../../productList/main.dart';
import '../../categorys/categoryList.dart';
import '../../member/login.dart';
import '../../main.dart';
import '../../order/list.dart';

final router = Router();
final _checkLoginPath = [
  "/member",
  "/homeHead",
  "/shoppingCart",
  "/order/create",
];

void routerInit() {
  login("15058679668", "www123");
  _registerHome(); //首页
  _registerActivity(); //活动详情页面
  _registerCategory(); //分类详情
  _registerOrder(); //订单详情
  _registerMember(); //会员
}

//////////// 首页 //////////////

void _registerHome() {
  router.define(
    "/",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return new Zfw();
      },
    ),
    transitionType: TransitionType.inFromLeft,
  );
  router.define(
    "/homeHead",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return new HomeHeadPage();
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
  router.define(
    "/shoppingCart",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return new ShoppingCartPage();
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
  router.define(
    "/webview",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        String url = params["url"].first ?? "";
        if (url.isNotEmpty) {
          url = utf8.decode(base64Decode(url));
        }
        return new WebviewScaffold(
          url: url,
          userAgent:
              "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36",
          withLocalStorage: true,
          hidden: true,
          appBar: new AppBar(
            centerTitle: true,
            title: new Text("登录"),
          ),
        );
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
  router.define(
    "/login",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        String redirect = params["redirect"]?.first;
        if (redirect == null || redirect == "") {
          redirect = "/";
        } else {
          redirect = utf8.decode(base64Decode(redirect));
        }
        return new LoginPage(
          redirectURL: redirect,
        );
      },
    ),
    transitionType: TransitionType.nativeModal,
  );
}

// 跳转
Future navigateTo(BuildContext context, String path,
    {bool replace = false,
    bool clearStack = false,
    TransitionType transition,
    Duration transitionDuration = const Duration(milliseconds: 250),
    RouteTransitionsBuilder transitionBuilder}) {
  if (_checkLoginPath.contains(path) && !isLogin()) {
    String url = base64Encode(utf8.encode(Uri.encodeFull(path)));
    return router.navigateTo(context, "/login?redirect=" + url);
  } else {
    return router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: transition,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder);
  }
}

// 跳转首页
void homeNavigate(BuildContext context) {
  router.navigateTo(context, "/");
}

// 跳转购物车
void shoppingCartNavigate(BuildContext context) {
  navigateTo(context, "/shoppingCart");
}

// 跳转当家
void homeHeadNavigate(BuildContext context) {
  navigateTo(context, "/homeHead");
}

// 跳转登入
void loginNavigate(BuildContext context) {
  router.navigateTo(context, "/login");
}

//////////// 商品详情 /////////////

// 注册路由
void _registerActivity() {
  router.define(
    "/activity",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        var activityCode = params["activityCode"]?.first;
        return new Activity(activityCode: activityCode);
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
}

// 跳转
void activityNavigate(BuildContext context, String activityCode) {
  router.navigateTo(context, "/activity?activityCode=${activityCode}");
}

/////////// 分类 /////////////

// 注册路由
void _registerCategory() {
  router.define(
    "/category/info",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        var categoryName = params["categoryName"]?.first;
        return new ProductList(categoryName: categoryName);
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
  router.define(
    "/category/list",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return new CategoryList();
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
}

// 跳转
void categoryNavigate(BuildContext context, String categoryName) {
  router.navigateTo(
      context, Uri.encodeFull("/category/info?categoryName=${categoryName}"));
}

void categoryListNavigate(BuildContext context) {
  router.navigateTo(context, Uri.encodeFull("/category/list"));
}

/////////// 订单 /////////////

// 注册路由
void _registerOrder() {
  router.define(
    "/order/list",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        var orderState = params["orderState"]?.first;
        return new OrderListPage(orderState: num.parse(orderState));
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
  router.define(
    "/order/create",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        int from = params["from"]?.first != null
            ? int.parse(params["from"]?.first)
            : 0;
        return new OrderCreate(
          from: OrderFrom.values[from],
        );
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
}

void orderListNavigate(BuildContext context, int orderState) {
  navigateTo(context, "/order/list?orderState=" + orderState.toString());
}

Future orderCreateNavigate(BuildContext context,
    [OrderFrom from = OrderFrom.DirectBuy]) {
  return navigateTo(context, "/order/create?from=" + from.index.toString());
}

void webViewNavigate(BuildContext context, String url) {
  navigateTo(context, "/webview?url=" + base64UrlEncode(utf8.encode(url)));
}

//////////// 会员 /////////////

// 注册路由
void _registerMember() {
  router.define(
    "/member",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return new MemberPage();
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
  router.define(
    "/member/address",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        var from = params["fromOrder"]?.first ?? "false";
        return new MemberAddress(
          fromOrder: from == "true",
        );
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
  router.define(
    "/member/address/add",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return new MemberAddressAdd();
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
}

// 跳转会员中心
void memberNavigate(BuildContext context) {
  navigateTo(context, "/member");
}

// 跳转地址管理
Future memberAddressNavigate(BuildContext context,
    [bool fromOrder = false]) async {
  return navigateTo(
      context, "/member/address?fromOrder=" + fromOrder.toString());
}

// 跳转地址新增
Future memberAddressAddNavigate(BuildContext context) async {
  return navigateTo(context, "/member/address/add");
}
