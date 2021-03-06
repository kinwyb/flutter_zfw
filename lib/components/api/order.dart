import 'dart:convert';

import 'package:zfw/components/api/beans/order.dart';

import './request.dart';

export 'package:zfw/components/api/beans/order.dart';

class OrderAPI {
  // 列表
  static Future<OrderListResp> list({
    int orderType: 0,
    OrderState status: OrderState.All,
    int page: 1,
    int pageSize: 20,
  }) async {
    var data = await HttpUtils.request("/micro/order/list",
        method: HttpUtils.GET,
        queryParameters: {
          "orderType": orderType,
          "status": orderStateValue(status),
          "page": page,
          "pageSize": pageSize,
        });
    var ret = new OrderListResp.fromJson(data);
    if (ret.code == 0) {
      return ret;
    }
    return ret;
  }

  // 单独购买下单
  static Future<DirectBuyResp> directBuy(OemOrderAddReq req) async {
    var data = await HttpUtils.request("/micro/activity/order/singlebuy",
        method: HttpUtils.POST, data: json.encode(req));
    return new DirectBuyResp.fromJson(data);
  }
}
