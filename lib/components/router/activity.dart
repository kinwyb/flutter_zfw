import 'package:flutter/material.dart';
import '../../activity/main.dart';
import 'package:fluro/fluro.dart';
import './routers.dart';

class ActivityRouter {

  //注册路由
  static void registerRouter() { 
    router.define("/activity",handler:Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          var activityCode = params["activityCode"]?.first;
          return new Activity(activityCode: activityCode);
        },
      ),
      transitionType: TransitionType.inFromRight,
    );
  }

  // 跳转
  static void Navigate(BuildContext context,String activityCode) {
    router.navigateTo(context, "/activity?activityCode=${activityCode}");
  }

}