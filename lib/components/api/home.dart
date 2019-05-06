import './request.dart';
import './beans/home.dart';

export './beans/home.dart';

class HomeAPI {
  static Future<IndexData> data() async {
    var data =
        await HttpUtils.request("/micro/index/data", method: HttpUtils.GET);
    var ret = new IndexDataResp.fromJson(data);
    if (ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }

  static Future<List<IndexBanner>> banners() async {
    var data =
        await HttpUtils.request("/micro/index/banners", method: HttpUtils.GET);
    var ret = new IndexBannersResp.fromJson(data);
    if (ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }

  static Future<List<IndexBrand>> brands(int page, [int pageCount = 20]) async {
    var data = await HttpUtils.request("/micro/index/brands",
        method: HttpUtils.GET,
        queryParameters: {
          "page": page,
          "pageSize": pageCount,
        });
    var ret = new IndexBrandsResp.fromJson(data);
    if (ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }

  static Future<List<IndexCategory>> categorys() async {
    var data = await HttpUtils.request("/micro/index/hotcategory",
        method: HttpUtils.GET);
    var ret = new IndexCategorysResp.fromJson(data);
    if (ret.code == 0) {
      return ret.data;
    }
    return ret.data;
  }
}
