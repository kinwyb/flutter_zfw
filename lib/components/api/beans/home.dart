import 'dart:convert' show json;

class IndexDataResp {

  int code;
  String err;
  String errmsg;
  IndexData data;

  IndexDataResp.fromParams({this.code, this.err, this.errmsg, this.data});

  factory IndexDataResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new IndexDataResp.fromJson(json.decode(jsonStr)) : new IndexDataResp.fromJson(jsonStr);
  
  IndexDataResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    err = jsonRes['err'];
    errmsg = jsonRes['errmsg'];
    data = jsonRes['data'] == null ? null : new IndexData.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"code": $code,"err": ${err != null?'${json.encode(err)}':'null'},"errmsg": ${errmsg != null?'${json.encode(errmsg)}':'null'},"data": $data}';
  }
}

class IndexData {

  List<IndexBanner> Banners;
  List<IndexBrand> Brands;
  List<IndexRecommendDirectActivity> DirectRecommend;
  List<IndexRecommendGroupActivity> GroupRecommend;
  List<IndexCategory> HotCategory;
  List<IndexSellingPoint> SellingPoints;

  IndexData.fromParams({this.Banners, this.Brands, this.DirectRecommend, this.GroupRecommend, this.HotCategory, this.SellingPoints});
  
  IndexData.fromJson(jsonRes) {
    Banners = jsonRes['Banners'] == null ? null : [];

    for (var BannersItem in Banners == null ? [] : jsonRes['Banners']){
            Banners.add(BannersItem == null ? null : new IndexBanner.fromJson(BannersItem));
    }

    Brands = jsonRes['Brands'] == null ? null : [];

    for (var BrandsItem in Brands == null ? [] : jsonRes['Brands']){
            Brands.add(BrandsItem == null ? null : new IndexBrand.fromJson(BrandsItem));
    }

    DirectRecommend = jsonRes['DirectRecommend'] == null ? null : [];

    for (var DirectRecommendItem in DirectRecommend == null ? [] : jsonRes['DirectRecommend']){
            DirectRecommend.add(DirectRecommendItem == null ? null : new IndexRecommendDirectActivity.fromJson(DirectRecommendItem));
    }

    GroupRecommend = jsonRes['GroupRecommend'] == null ? null : [];

    for (var GroupRecommendItem in GroupRecommend == null ? [] : jsonRes['GroupRecommend']){
            GroupRecommend.add(GroupRecommendItem == null ? null : new IndexRecommendGroupActivity.fromJson(GroupRecommendItem));
    }

    HotCategory = jsonRes['HotCategory'] == null ? null : [];

    for (var HotCategoryItem in HotCategory == null ? [] : jsonRes['HotCategory']){
            HotCategory.add(HotCategoryItem == null ? null : new IndexCategory.fromJson(HotCategoryItem));
    }

    SellingPoints = jsonRes['SellingPoints'] == null ? null : [];

    for (var SellingPointsItem in SellingPoints == null ? [] : jsonRes['SellingPoints']){
            SellingPoints.add(SellingPointsItem == null ? null : new IndexSellingPoint.fromJson(SellingPointsItem));
    }
  }

  @override
  String toString() {
    return '{"Banners": $Banners,"Brands": $Brands,"DirectRecommend": $DirectRecommend,"GroupRecommend": $GroupRecommend,"HotCategory": $HotCategory,"SellingPoints": $SellingPoints}';
  }
}

class IndexSellingPoint {

  String Detail;
  String Title;

  IndexSellingPoint.fromParams({this.Detail, this.Title});
  
  IndexSellingPoint.fromJson(jsonRes) {
    Detail = jsonRes['Detail'];
    Title = jsonRes['Title'];
  }

  @override
  String toString() {
    return '{"Detail": ${Detail != null?'${json.encode(Detail)}':'null'},"Title": ${Title != null?'${json.encode(Title)}':'null'}}';
  }
}

class IndexCategory {

  String Img;
  String Name;
  String SellingPoints;

  IndexCategory.fromParams({this.Img, this.Name, this.SellingPoints});
  
  IndexCategory.fromJson(jsonRes) {
    Img = jsonRes['Img'];
    Name = jsonRes['Name'];
    SellingPoints = jsonRes['SellingPoints'];
  }

  @override
  String toString() {
    return '{"Img": ${Img != null?'${json.encode(Img)}':'null'},"Name": ${Name != null?'${json.encode(Name)}':'null'},"SellingPoints": ${SellingPoints != null?'${json.encode(SellingPoints)}':'null'}}';
  }
}

class IndexRecommendGroupActivity {

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

  IndexRecommendGroupActivity.fromParams({this.Users, this.ActivityID, this.ActivityType, this.GroupMinUser, this.GroupSellingNum, this.GroupUsers, this.Commission, this.GroupPrice, this.MarketPrice, this.ActivityCode, this.CategoryName, this.GroupNo, this.Img, this.IsFreeExpress, this.Name, this.OemName, this.Price, this.ProductCode, this.ProductNo, this.SellingPoint, this.SpecialCode, this.StatusMsg});
  
  IndexRecommendGroupActivity.fromJson(jsonRes) {
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
    return '{"Users": $Users,"ActivityID": $ActivityID,"ActivityType": $ActivityType,"GroupMinUser": $GroupMinUser,"GroupSellingNum": $GroupSellingNum,"GroupUsers": $GroupUsers,"Commission": $Commission,"GroupPrice": $GroupPrice,"MarketPrice": $MarketPrice,"ActivityCode": ${ActivityCode != null?'${json.encode(ActivityCode)}':'null'},"CategoryName": ${CategoryName != null?'${json.encode(CategoryName)}':'null'},"GroupNo": ${GroupNo != null?'${json.encode(GroupNo)}':'null'},"Img": ${Img != null?'${json.encode(Img)}':'null'},"IsFreeExpress": ${IsFreeExpress != null?'${json.encode(IsFreeExpress)}':'null'},"Name": ${Name != null?'${json.encode(Name)}':'null'},"OemName": ${OemName != null?'${json.encode(OemName)}':'null'},"Price": ${Price != null?'${json.encode(Price)}':'null'},"ProductCode": ${ProductCode != null?'${json.encode(ProductCode)}':'null'},"ProductNo": ${ProductNo != null?'${json.encode(ProductNo)}':'null'},"SellingPoint": ${SellingPoint != null?'${json.encode(SellingPoint)}':'null'},"SpecialCode": ${SpecialCode != null?'${json.encode(SpecialCode)}':'null'},"StatusMsg": ${StatusMsg != null?'${json.encode(StatusMsg)}':'null'}}';
  }
}

class IndexRecommendDirectActivity {

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

  IndexRecommendDirectActivity.fromParams({this.Users, this.ActivityID, this.ActivityType, this.GroupMinUser, this.GroupSellingNum, this.GroupUsers, this.Commission, this.GroupPrice, this.MarketPrice, this.ActivityCode, this.CategoryName, this.GroupNo, this.Img, this.IsFreeExpress, this.Name, this.OemName, this.Price, this.ProductCode, this.ProductNo, this.SellingPoint, this.SpecialCode, this.StatusMsg});
  
  IndexRecommendDirectActivity.fromJson(jsonRes) {
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
    return '{"Users": $Users,"ActivityID": $ActivityID,"ActivityType": $ActivityType,"GroupMinUser": $GroupMinUser,"GroupSellingNum": $GroupSellingNum,"GroupUsers": $GroupUsers,"Commission": $Commission,"GroupPrice": $GroupPrice,"MarketPrice": $MarketPrice,"ActivityCode": ${ActivityCode != null?'${json.encode(ActivityCode)}':'null'},"CategoryName": ${CategoryName != null?'${json.encode(CategoryName)}':'null'},"GroupNo": ${GroupNo != null?'${json.encode(GroupNo)}':'null'},"Img": ${Img != null?'${json.encode(Img)}':'null'},"IsFreeExpress": ${IsFreeExpress != null?'${json.encode(IsFreeExpress)}':'null'},"Name": ${Name != null?'${json.encode(Name)}':'null'},"OemName": ${OemName != null?'${json.encode(OemName)}':'null'},"Price": ${Price != null?'${json.encode(Price)}':'null'},"ProductCode": ${ProductCode != null?'${json.encode(ProductCode)}':'null'},"ProductNo": ${ProductNo != null?'${json.encode(ProductNo)}':'null'},"SellingPoint": ${SellingPoint != null?'${json.encode(SellingPoint)}':'null'},"SpecialCode": ${SpecialCode != null?'${json.encode(SpecialCode)}':'null'},"StatusMsg": ${StatusMsg != null?'${json.encode(StatusMsg)}':'null'}}';
  }
}

class IndexBrand {

  String Category;
  String Img;
  String Name;
  List<IndexBrandProduct> Products;

  IndexBrand.fromParams({this.Category, this.Img, this.Name, this.Products});
  
  IndexBrand.fromJson(jsonRes) {
    Category = jsonRes['Category'];
    Img = jsonRes['Img'];
    Name = jsonRes['Name'];
    Products = jsonRes['Products'] == null ? null : [];

    for (var ProductsItem in Products == null ? [] : jsonRes['Products']){
            Products.add(ProductsItem == null ? null : new IndexBrandProduct.fromJson(ProductsItem));
    }
  }

  @override
  String toString() {
    return '{"Category": ${Category != null?'${json.encode(Category)}':'null'},"Img": ${Img != null?'${json.encode(Img)}':'null'},"Name": ${Name != null?'${json.encode(Name)}':'null'},"Products": $Products}';
  }
}

class IndexBrandProduct {

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

  IndexBrandProduct.fromParams({this.Users, this.ActivityID, this.ActivityType, this.GroupMinUser, this.GroupSellingNum, this.GroupUsers, this.Commission, this.GroupPrice, this.MarketPrice, this.ActivityCode, this.CategoryName, this.GroupNo, this.Img, this.IsFreeExpress, this.Name, this.OemName, this.Price, this.ProductCode, this.ProductNo, this.SellingPoint, this.SpecialCode, this.StatusMsg});
  
  IndexBrandProduct.fromJson(jsonRes) {
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
    return '{"Users": $Users,"ActivityID": $ActivityID,"ActivityType": $ActivityType,"GroupMinUser": $GroupMinUser,"GroupSellingNum": $GroupSellingNum,"GroupUsers": $GroupUsers,"Commission": $Commission,"GroupPrice": $GroupPrice,"MarketPrice": $MarketPrice,"ActivityCode": ${ActivityCode != null?'${json.encode(ActivityCode)}':'null'},"CategoryName": ${CategoryName != null?'${json.encode(CategoryName)}':'null'},"GroupNo": ${GroupNo != null?'${json.encode(GroupNo)}':'null'},"Img": ${Img != null?'${json.encode(Img)}':'null'},"IsFreeExpress": ${IsFreeExpress != null?'${json.encode(IsFreeExpress)}':'null'},"Name": ${Name != null?'${json.encode(Name)}':'null'},"OemName": ${OemName != null?'${json.encode(OemName)}':'null'},"Price": ${Price != null?'${json.encode(Price)}':'null'},"ProductCode": ${ProductCode != null?'${json.encode(ProductCode)}':'null'},"ProductNo": ${ProductNo != null?'${json.encode(ProductNo)}':'null'},"SellingPoint": ${SellingPoint != null?'${json.encode(SellingPoint)}':'null'},"SpecialCode": ${SpecialCode != null?'${json.encode(SpecialCode)}':'null'},"StatusMsg": ${StatusMsg != null?'${json.encode(StatusMsg)}':'null'}}';
  }
}

class IndexBanner {

  String Img;
  String URL;

  IndexBanner.fromParams({this.Img, this.URL});
  
  IndexBanner.fromJson(jsonRes) {
    Img = jsonRes['Img'];
    URL = jsonRes['URL'];
  }

  @override
  String toString() {
    return '{"Img": ${Img != null?'${json.encode(Img)}':'null'},"URL": ${URL != null?'${json.encode(URL)}':'null'}}';
  }
}

class IndexBannersResp {

  int code;
  String err;
  String errmsg;
  List<IndexBanner> data;

  IndexBannersResp.fromParams({this.code, this.err, this.errmsg, this.data});

  factory IndexBannersResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new IndexBannersResp.fromJson(json.decode(jsonStr)) : new IndexBannersResp.fromJson(jsonStr);
  
  IndexBannersResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    err = jsonRes['err'];
    errmsg = jsonRes['errmsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
            data.add(dataItem == null ? null : new IndexBanner.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"err": ${err != null?'${json.encode(err)}':'null'},"errmsg": ${errmsg != null?'${json.encode(errmsg)}':'null'},"data": $data}';
  }

}

class IndexBrandsResp {

  int code;
  String err;
  String errmsg;
  List<IndexBrand> data;

  IndexBrandsResp.fromParams({this.code, this.err, this.errmsg, this.data});

  factory IndexBrandsResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new IndexBrandsResp.fromJson(json.decode(jsonStr)) : new IndexBrandsResp.fromJson(jsonStr);
  
  IndexBrandsResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    err = jsonRes['err'];
    errmsg = jsonRes['errmsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
            data.add(dataItem == null ? null : new IndexBrand.fromJson(dataItem));
    }

  }

  @override
  String toString() {
    return '{"code": $code,"err": ${err != null?'${json.encode(err)}':'null'},"errmsg": ${errmsg != null?'${json.encode(errmsg)}':'null'},"data": $data}';
  }
  
}

class IndexCategorysResp {

  int code;
  String err;
  String errmsg;
  List<IndexCategory> data;

  IndexCategorysResp.fromParams({this.code, this.err, this.errmsg, this.data});

  factory IndexCategorysResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new IndexCategorysResp.fromJson(json.decode(jsonStr)) : new IndexCategorysResp.fromJson(jsonStr);
  
  IndexCategorysResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    err = jsonRes['err'];
    errmsg = jsonRes['errmsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
            data.add(dataItem == null ? null : new IndexCategory.fromJson(dataItem));
    }

  }

  @override
  String toString() {
    return '{"code": $code,"err": ${err != null?'${json.encode(err)}':'null'},"errmsg": ${errmsg != null?'${json.encode(errmsg)}':'null'},"data": $data}';
  }
  
}