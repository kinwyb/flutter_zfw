import './request.dart';
import './beans/activity.dart';

export './beans/activity.dart';

class ActivityAPI {

  // 活动详情
  static Future<ActivityInfo> info(String activityCode) async {
    var data =await HttpUtils.request("/micro/activity/info",
    method: HttpUtils.GET,
    queryParameters: {
      "activityCode":activityCode,
    });
    var ret = new ActivityInfoResp.fromJson(data);
    if(ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }

  // 活动详情
  static Future<List<ActivityProductSKU>> sku(String activityCode,String productno) async {
    var data =await HttpUtils.request("/micro/activity/sku",
    method: HttpUtils.GET,
    queryParameters: {
      "activityCode":activityCode,
      "productno":productno,
    });
    var ret = new ActivityProductSKUResp.fromJson(data);
    if(ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }

}