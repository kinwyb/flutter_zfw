import 'package:flutter/material.dart';
import 'package:zfw/components/component.dart';
import '../components/router/routers.dart';
import './homeHead.dart';

class HomeHeadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return toast(MaterialApp(
      title: '当家',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: showPerformanceOverlay,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generator,
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: new HomeHeadPage(),
      // home: Activity(activityCode: "c110d2ca40ca11e9941b00163e136d45",)
    ));
  }
}
