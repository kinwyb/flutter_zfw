import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../api/request.dart';
import '../../activity/main.dart';
import '../../productList/main.dart';
import '../../categorys/categoryList.dart';
import '../../member/main.dart';
import '../../member/login.dart';
import '../../homeHead/main.dart';
import '../../shoppingCart/main.dart';
import '../../main.dart';

final router = Router();
final _checkLoginPath = ["/member", "/homeHead", "/shoppingCart"];

void routerInit() {
  login("15058679668", "www123");
  registerHome(); //首页
  registerActivityRouter(); //活动详情页面
  registerCategoryRouter(); //分类详情
}

//////////// 首页 //////////////

void registerHome() {
  router.define(
    "/",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return new MyApp();
      },
    ),
    transitionType: TransitionType.inFromLeft,
  );
  router.define(
    "/homeHead",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return new HomeHeadApp();
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
  router.define(
    "/shoppingCart",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return new ShoppingCartApp();
      },
    ),
    transitionType: TransitionType.inFromRight,
  );
  router.define(
    "/member",
    handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return new MemberApp();
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

// 跳转会员中心
void memberNavigate(BuildContext context) {
  navigateTo(context, "/member");
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
void registerActivityRouter() {
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
void registerCategoryRouter() {
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
