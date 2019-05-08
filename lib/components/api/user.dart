import './request.dart';
import './beans/user.dart';

export './beans/user.dart';

class UserAPI {
  // 佣金信息
  static Future<UserRebateInfo> rebateInfo() async {
    var data = await HttpUtils.request("/micro/user/rebate/info",
        method: HttpUtils.GET);
    var ret = new UserRebateInfoResp.fromJson(data);
    if (ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }

  // 粉丝信息
  static Future<UserFansInfo> fansInfo() async {
    var data =
        await HttpUtils.request("/micro/user/fans/info", method: HttpUtils.GET);
    var ret = new UserFansInfoResp.fromJson(data);
    if (ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }

  // 会员信息
  static Future<UserInfo> userInfo() async {
    var data = await HttpUtils.request("/micro/user/getUserInfo",
        method: HttpUtils.GET);
    var ret = new UserInfoResp.fromJson(data);
    if (ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }

  // 会员数据统计
  static Future<UserDataCount> dataCount() async {
    var data = await HttpUtils.request("/micro/user/data/count",
        method: HttpUtils.GET);
    var ret = new UserDataCountResp.fromJson(data);
    if (ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }
}
