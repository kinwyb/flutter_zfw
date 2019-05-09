import './request.dart';
import './beans/shoppingCart.dart';

export './beans/shoppingCart.dart';

class ShoppingCartAPI {
  // 购物车数据
  static Future<SignleBuyShoppingCart> singlebuyInfo() async {
    var data = await HttpUtils.request("/micro/shoppingCart/singlebuy/info",
        method: HttpUtils.GET);
    var ret = new SignleBuyShoppingCartResp.fromJson(data);
    if (ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }
}
