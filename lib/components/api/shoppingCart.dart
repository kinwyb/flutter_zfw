import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:zfw/components/api/beans/common.dart';

import './request.dart';
import './beans/shoppingCart.dart';

export './beans/shoppingCart.dart';
export 'package:zfw/components/api/beans/common.dart';

class ShoppingCartAPI {
  // 购物车数据
  static Future<SignleBuyShoppingCartResp> singlebuyInfo() async {
    var data = await HttpUtils.request("/micro/shoppingCart/singlebuy/info",
        method: HttpUtils.GET);
    return new SignleBuyShoppingCartResp.fromJson(data);
  }

  static Future<StringResp> itemChange({
    @required String activityCode,
    @required String skuID,
    @required int num,
  }) async {
    var data = await HttpUtils.request("/micro/shoppingCart/item/change",
        method: HttpUtils.POST,
        queryParameters: {
          "activityCode": activityCode,
          "spacCode": skuID,
          "num": num,
        });
    return new StringResp.fromJson(data);
  }

  // 添加商品到购物车
  static Future<StringResp> add(ShoppingCartAddReq req) async {
    var data = await HttpUtils.request(
      "/micro/shoppingCart/add",
      method: HttpUtils.POST,
      data: json.encode(req),
    );
    return new StringResp.fromJson(data);
  }
}
