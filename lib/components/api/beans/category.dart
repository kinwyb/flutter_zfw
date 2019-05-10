import 'dart:convert' show json;
import 'package:zfw/components/api/beans/common.dart';

class CategoryInfoResp {
  int code;
  String err;
  String errmsg;
  CategoryInfo data;
  PageObj page;

  CategoryInfoResp.fromParams(
      {this.code, this.err, this.errmsg, this.data, this.page});

  factory CategoryInfoResp(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new CategoryInfoResp.fromJson(json.decode(jsonStr))
          : new CategoryInfoResp.fromJson(jsonStr);

  CategoryInfoResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    err = jsonRes['err'];
    errmsg = jsonRes['errmsg'];
    data = jsonRes['data'] == null
        ? null
        : new CategoryInfo.fromJson(jsonRes['data']);
    page =
        jsonRes['page'] == null ? null : new PageObj.fromJson(jsonRes['page']);
  }

  @override
  String toString() {
    return '{"code": $code,"err": ${err != null ? '${json.encode(err)}' : 'null'},"errmsg": ${errmsg != null ? '${json.encode(errmsg)}' : 'null'},"data": $data,"page": $page}';
  }
}

class CategoryInfo {
  String Name;
  List<ActivityList> Activitys;
  List<String> Imgs;

  CategoryInfo.fromParams({this.Name, this.Activitys, this.Imgs});

  CategoryInfo.fromJson(jsonRes) {
    Name = jsonRes['Name'];
    Activitys = jsonRes['Activitys'] == null ? null : [];

    for (var ActivitysItem in Activitys == null ? [] : jsonRes['Activitys']) {
      Activitys.add(ActivitysItem == null
          ? null
          : new ActivityList.fromJson(ActivitysItem));
    }

    Imgs = jsonRes['Imgs'] == null ? null : [];

    for (var ImgsItem in Imgs == null ? [] : jsonRes['Imgs']) {
      Imgs.add(ImgsItem);
    }
  }

  @override
  String toString() {
    return '{"Name": ${Name != null ? '${json.encode(Name)}' : 'null'},"Activitys": $Activitys,"Imgs": $Imgs}';
  }
}

class ActivityList {
  Object Users;
  int ActivityID;
  int ActivityType;
  int GroupMinUser;
  int GroupSellingNum;
  int GroupUsers;
  double Commission;
  double GroupPrice;
  double MarketPrice;
  String ActivityCode;
  String CategoryName;
  String GroupNo;
  String Img;
  String IsFreeExpress;
  String Name;
  String OemName;
  String Price;
  String ProductCode;
  String ProductNo;
  String SellingPoint;
  String SpecialCode;
  String StatusMsg;

  ActivityList.fromParams(
      {this.Users,
      this.ActivityID,
      this.ActivityType,
      this.GroupMinUser,
      this.GroupSellingNum,
      this.GroupUsers,
      this.Commission,
      this.GroupPrice,
      this.MarketPrice,
      this.ActivityCode,
      this.CategoryName,
      this.GroupNo,
      this.Img,
      this.IsFreeExpress,
      this.Name,
      this.OemName,
      this.Price,
      this.ProductCode,
      this.ProductNo,
      this.SellingPoint,
      this.SpecialCode,
      this.StatusMsg});

  ActivityList.fromJson(jsonRes) {
    Users = jsonRes['Users'];
    ActivityID = jsonRes['ActivityID'];
    ActivityType = jsonRes['ActivityType'];
    GroupMinUser = jsonRes['GroupMinUser'];
    GroupSellingNum = jsonRes['GroupSellingNum'];
    GroupUsers = jsonRes['GroupUsers'];
    Commission = jsonRes['Commission'];
    GroupPrice = jsonRes['GroupPrice'];
    MarketPrice = jsonRes['MarketPrice'];
    ActivityCode = jsonRes['ActivityCode'];
    CategoryName = jsonRes['CategoryName'];
    GroupNo = jsonRes['GroupNo'];
    Img = jsonRes['Img'];
    IsFreeExpress = jsonRes['IsFreeExpress'];
    Name = jsonRes['Name'];
    OemName = jsonRes['OemName'];
    Price = jsonRes['Price'];
    ProductCode = jsonRes['ProductCode'];
    ProductNo = jsonRes['ProductNo'];
    SellingPoint = jsonRes['SellingPoint'];
    SpecialCode = jsonRes['SpecialCode'];
    StatusMsg = jsonRes['StatusMsg'];
  }

  @override
  String toString() {
    return '{"Users": $Users,"ActivityID": $ActivityID,"ActivityType": $ActivityType,"GroupMinUser": $GroupMinUser,"GroupSellingNum": $GroupSellingNum,"GroupUsers": $GroupUsers,"Commission": $Commission,"GroupPrice": $GroupPrice,"MarketPrice": $MarketPrice,"ActivityCode": ${ActivityCode != null ? '${json.encode(ActivityCode)}' : 'null'},"CategoryName": ${CategoryName != null ? '${json.encode(CategoryName)}' : 'null'},"GroupNo": ${GroupNo != null ? '${json.encode(GroupNo)}' : 'null'},"Img": ${Img != null ? '${json.encode(Img)}' : 'null'},"IsFreeExpress": ${IsFreeExpress != null ? '${json.encode(IsFreeExpress)}' : 'null'},"Name": ${Name != null ? '${json.encode(Name)}' : 'null'},"OemName": ${OemName != null ? '${json.encode(OemName)}' : 'null'},"Price": ${Price != null ? '${json.encode(Price)}' : 'null'},"ProductCode": ${ProductCode != null ? '${json.encode(ProductCode)}' : 'null'},"ProductNo": ${ProductNo != null ? '${json.encode(ProductNo)}' : 'null'},"SellingPoint": ${SellingPoint != null ? '${json.encode(SellingPoint)}' : 'null'},"SpecialCode": ${SpecialCode != null ? '${json.encode(SpecialCode)}' : 'null'},"StatusMsg": ${StatusMsg != null ? '${json.encode(StatusMsg)}' : 'null'}}';
  }
}

class CategoryListResp {
  String errmsg;
  String err;
  int code;
  List<CategoryListBean> data;

  CategoryListResp({this.errmsg, this.err, this.code, this.data});

  CategoryListResp.fromJson(Map<String, dynamic> json) {
    this.errmsg = json['errmsg'];
    this.err = json['err'];
    this.code = json['code'];
    this.data = (json['data'] as List) != null
        ? (json['data'] as List)
            .map((i) => CategoryListBean.fromJson(i))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errmsg'] = this.errmsg;
    data['err'] = this.err;
    data['code'] = this.code;
    data['data'] =
        this.data != null ? this.data.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class CategoryListBean {
  String name;
  String img;
  int sortNum;
  List<CategoryListBean> children;

  CategoryListBean({this.name, this.img, this.sortNum, this.children});

  CategoryListBean.fromJson(Map<String, dynamic> json) {
    this.name = json['Name'];
    this.img = json['Img'];
    this.sortNum = json['SortNum'];
    this.children = (json['Children'] as List) != null
        ? (json['Children'] as List)
            .map((i) => CategoryListBean.fromJson(i))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Img'] = this.img;
    data['SortNum'] = this.sortNum;
    data['Children'] = this.children != null
        ? this.children.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}
