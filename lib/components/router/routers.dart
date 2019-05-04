import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../activity/main.dart';
import '../../productList/main.dart';
import '../../main.dart';

final router = Router();

class Routers {
  static void init() {
    registerHome(); //首页
    registerActivityRouter(); //活动详情页面
    registerCategoryRouter(); //分类详情
  }

  //注册路由
  static void registerHome() {
    router.define(
      "/",
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return new MyApp();
        },
      ),
      transitionType: TransitionType.inFromLeft,
    );
  }

  // 跳转
  static void NavigateHome(BuildContext context) {
    router.navigateTo(context, "/");
  }
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

/////////// 分类列表 /////////////

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
}

// 跳转
void categoryNavigate(BuildContext context, String categoryName) {
  router.navigateTo(context, Uri.encodeFull("/category/info?categoryName=${categoryName}"));
}