import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './activity.dart';
import '../../main.dart';

export './activity.dart';

final router = Router();

class Routers {

  static void init() {
    registerHome(); //首页
    ActivityRouter.registerRouter(); //活动详情页面
  }

  //注册路由
  static void registerHome() { 
    router.define("/",handler:Handler(
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

