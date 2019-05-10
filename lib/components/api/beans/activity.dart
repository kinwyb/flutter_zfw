import 'dart:convert' show json;
import './common.dart';

// export './img.dart';

class ActivityInfoResp {
  int code;
  String err;
  String errmsg;
  ActivityInfo data;

  ActivityInfoResp.fromParams({this.code, this.err, this.errmsg, this.data});

  factory ActivityInfoResp(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ActivityInfoResp.fromJson(json.decode(jsonStr))
          : new ActivityInfoResp.fromJson(jsonStr);

  ActivityInfoResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    err = jsonRes['err'];
    errmsg = jsonRes['errmsg'];
    data = jsonRes['data'] == null
        ? null
        : new ActivityInfo.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"code": $code,"err": ${err != null ? '${json.encode(err)}' : 'null'},"errmsg": ${errmsg != null ? '${json.encode(errmsg)}' : 'null'},"data": $data}';
  }
}

class ActivityInfo {
  Object Gift;
  Object InspectionReport;
  Object PriceRange;
  Object RecommendGroup;
  int ActivityType;
  int AssessNum;
  int GroupBuyMinNum;
  int GroupNum;
  int MaxSingleBuyNum;
  int NoAssessNum;
  int UsersNum;
  double Commission;
  double GroupPrice;
  double MarketPrice;
  double MaxPrice;
  double MinPrice;
  double SingleBuyPrice;
  String ActivityCode;
  String BrandCode;
  String BrandLogo;
  String BrandName;
  String CanSingleBuy;
  String Category;
  String IsCollection;
  String IsFreeExpress;
  String Name;
  String ProductNo;
  String RelationActivity;
  String SellingPoints;
  String StatusMsg;
  String Video;
  List<ActivityAssess> Assess;
  List<dynamic> GroupTeams;
  List<ImgInfo> Imgs;
  List<ActivityProductAttrs> ProductAttrs;
  List<ImgInfo> ProductDescription;
  List<ActivityTemplate> Template;

  ActivityInfo.fromParams(
      {this.Gift,
      this.InspectionReport,
      this.PriceRange,
      this.RecommendGroup,
      this.ActivityType,
      this.AssessNum,
      this.GroupBuyMinNum,
      this.GroupNum,
      this.MaxSingleBuyNum,
      this.NoAssessNum,
      this.UsersNum,
      this.Commission,
      this.GroupPrice,
      this.MarketPrice,
      this.MaxPrice,
      this.MinPrice,
      this.SingleBuyPrice,
      this.ActivityCode,
      this.BrandCode,
      this.BrandLogo,
      this.BrandName,
      this.CanSingleBuy,
      this.Category,
      this.IsCollection,
      this.IsFreeExpress,
      this.Name,
      this.ProductNo,
      this.RelationActivity,
      this.SellingPoints,
      this.StatusMsg,
      this.Video,
      this.Assess,
      this.GroupTeams,
      this.Imgs,
      this.ProductAttrs,
      this.ProductDescription,
      this.Template});

  ActivityInfo.fromJson(jsonRes) {
    Gift = jsonRes['Gift'];
    InspectionReport = jsonRes['InspectionReport'];
    PriceRange = jsonRes['PriceRange'];
    RecommendGroup = jsonRes['RecommendGroup'];
    ActivityType = jsonRes['ActivityType'];
    AssessNum = jsonRes['AssessNum'];
    GroupBuyMinNum = jsonRes['GroupBuyMinNum'];
    GroupNum = jsonRes['GroupNum'];
    MaxSingleBuyNum = jsonRes['MaxSingleBuyNum'];
    NoAssessNum = jsonRes['NoAssessNum'];
    UsersNum = jsonRes['UsersNum'];
    Commission = jsonRes['Commission'];
    GroupPrice = jsonRes['GroupPrice'];
    MarketPrice = jsonRes['MarketPrice'];
    MaxPrice = jsonRes['MaxPrice'];
    MinPrice = jsonRes['MinPrice'];
    SingleBuyPrice = jsonRes['SingleBuyPrice'];
    ActivityCode = jsonRes['ActivityCode'];
    BrandCode = jsonRes['BrandCode'];
    BrandLogo = jsonRes['BrandLogo'];
    BrandName = jsonRes['BrandName'];
    CanSingleBuy = jsonRes['CanSingleBuy'];
    Category = jsonRes['Category'];
    IsCollection = jsonRes['IsCollection'];
    IsFreeExpress = jsonRes['IsFreeExpress'];
    Name = jsonRes['Name'];
    ProductNo = jsonRes['ProductNo'];
    RelationActivity = jsonRes['RelationActivity'];
    SellingPoints = jsonRes['SellingPoints'];
    StatusMsg = jsonRes['StatusMsg'];
    Video = jsonRes['Video'];
    Assess = jsonRes['Assess'] == null ? null : [];

    for (var AssessItem in Assess == null ? [] : jsonRes['Assess']) {
      Assess.add(
          AssessItem == null ? null : new ActivityAssess.fromJson(AssessItem));
    }

    GroupTeams = jsonRes['GroupTeams'] == null ? null : [];

    for (var GroupTeamsItem
        in GroupTeams == null ? [] : jsonRes['GroupTeams']) {
      GroupTeams.add(GroupTeamsItem);
    }

    Imgs = jsonRes['Imgs'] == null ? null : [];

    for (var ImgsItem in Imgs == null ? [] : jsonRes['Imgs']) {
      Imgs.add(ImgsItem == null ? null : new ImgInfo.fromJson(ImgsItem));
    }

    ProductAttrs = jsonRes['ProductAttrs'] == null ? null : [];

    for (var ProductAttrsItem
        in ProductAttrs == null ? [] : jsonRes['ProductAttrs']) {
      ProductAttrs.add(ActivityProductAttrs.fromJson(ProductAttrsItem));
    }

    ProductDescription = jsonRes['ProductDescription'] == null ? null : [];

    for (var ProductDescriptionItem
        in ProductDescription == null ? [] : jsonRes['ProductDescription']) {
      ProductDescription.add(ProductDescriptionItem == null
          ? null
          : new ImgInfo.fromJson(ProductDescriptionItem));
    }

    Template = jsonRes['Template'] == null ? null : [];

    for (var TemplateItem in Template == null ? [] : jsonRes['Template']) {
      Template.add(TemplateItem == null
          ? null
          : new ActivityTemplate.fromJson(TemplateItem));
    }
  }

  @override
  String toString() {
    return '{"Gift": $Gift,"InspectionReport": $InspectionReport,"PriceRange": $PriceRange,"RecommendGroup": $RecommendGroup,"ActivityType": $ActivityType,"AssessNum": $AssessNum,"GroupBuyMinNum": $GroupBuyMinNum,"GroupNum": $GroupNum,"MaxSingleBuyNum": $MaxSingleBuyNum,"NoAssessNum": $NoAssessNum,"UsersNum": $UsersNum,"Commission": $Commission,"GroupPrice": $GroupPrice,"MarketPrice": $MarketPrice,"MaxPrice": $MaxPrice,"MinPrice": $MinPrice,"SingleBuyPrice": $SingleBuyPrice,"ActivityCode": ${ActivityCode != null ? '${json.encode(ActivityCode)}' : 'null'},"BrandCode": ${BrandCode != null ? '${json.encode(BrandCode)}' : 'null'},"BrandLogo": ${BrandLogo != null ? '${json.encode(BrandLogo)}' : 'null'},"BrandName": ${BrandName != null ? '${json.encode(BrandName)}' : 'null'},"CanSingleBuy": ${CanSingleBuy != null ? '${json.encode(CanSingleBuy)}' : 'null'},"Category": ${Category != null ? '${json.encode(Category)}' : 'null'},"IsCollection": ${IsCollection != null ? '${json.encode(IsCollection)}' : 'null'},"IsFreeExpress": ${IsFreeExpress != null ? '${json.encode(IsFreeExpress)}' : 'null'},"Name": ${Name != null ? '${json.encode(Name)}' : 'null'},"ProductNo": ${ProductNo != null ? '${json.encode(ProductNo)}' : 'null'},"RelationActivity": ${RelationActivity != null ? '${json.encode(RelationActivity)}' : 'null'},"SellingPoints": ${SellingPoints != null ? '${json.encode(SellingPoints)}' : 'null'},"StatusMsg": ${StatusMsg != null ? '${json.encode(StatusMsg)}' : 'null'},"Video": ${Video != null ? '${json.encode(Video)}' : 'null'},"Assess": $Assess,"GroupTeams": $GroupTeams,"Imgs": $Imgs,"ProductAttrs": $ProductAttrs,"ProductDescription": $ProductDescription,"Template": $Template}';
  }
}

class ActivityProductAttrs {
  String name;
  int sortNum;
  String value;

  ActivityProductAttrs.fromParams({this.name, this.value, this.sortNum});

  ActivityProductAttrs.fromJson(jsonRes) {
    name = jsonRes['Name'];
    sortNum = jsonRes['SortNum'];
    value = jsonRes['Value'];
  }

  @override
  String toString() {
    return '{"Name": ${name != null ? '${json.encode(name)}' : 'null'},"Value": ${value != null ? '${json.encode(value)}' : 'null'},"SortNum": ${sortNum != null ? '${json.encode(sortNum)}' : '0'}}';
  }
}

class ActivityTemplate {
  String Contents;
  String TemplateCode;
  String Title;

  ActivityTemplate.fromParams({this.Contents, this.TemplateCode, this.Title});

  ActivityTemplate.fromJson(jsonRes) {
    Contents = jsonRes['Contents'];
    TemplateCode = jsonRes['TemplateCode'];
    Title = jsonRes['Title'];
  }

  @override
  String toString() {
    return '{"Contents": ${Contents != null ? '${json.encode(Contents)}' : 'null'},"TemplateCode": ${TemplateCode != null ? '${json.encode(TemplateCode)}' : 'null'},"Title": ${Title != null ? '${json.encode(Title)}' : 'null'}}';
  }
}

class ActivityAssess {
  Object Imgs;
  int Pleased;
  String Anonymous;
  String AssessCode;
  String Audit;
  String Content;
  String InsertTime;
  String Ischoice;
  String NickName;
  String Portrait;
  String ProductCode;
  String ProductNo;
  String SpacValue;
  String UserPK;

  ActivityAssess.fromParams(
      {this.Imgs,
      this.Pleased,
      this.Anonymous,
      this.AssessCode,
      this.Audit,
      this.Content,
      this.InsertTime,
      this.Ischoice,
      this.NickName,
      this.Portrait,
      this.ProductCode,
      this.ProductNo,
      this.SpacValue,
      this.UserPK});

  ActivityAssess.fromJson(jsonRes) {
    Imgs = jsonRes['Imgs'];
    Pleased = jsonRes['Pleased'];
    Anonymous = jsonRes['Anonymous'];
    AssessCode = jsonRes['AssessCode'];
    Audit = jsonRes['Audit'];
    Content = jsonRes['Content'];
    InsertTime = jsonRes['InsertTime'];
    Ischoice = jsonRes['Ischoice'];
    NickName = jsonRes['NickName'];
    Portrait = jsonRes['Portrait'];
    ProductCode = jsonRes['ProductCode'];
    ProductNo = jsonRes['ProductNo'];
    SpacValue = jsonRes['SpacValue'];
    UserPK = jsonRes['UserPK'];
  }

  @override
  String toString() {
    return '{"Imgs": $Imgs,"Pleased": $Pleased,"Anonymous": ${Anonymous != null ? '${json.encode(Anonymous)}' : 'null'},"AssessCode": ${AssessCode != null ? '${json.encode(AssessCode)}' : 'null'},"Audit": ${Audit != null ? '${json.encode(Audit)}' : 'null'},"Content": ${Content != null ? '${json.encode(Content)}' : 'null'},"InsertTime": ${InsertTime != null ? '${json.encode(InsertTime)}' : 'null'},"Ischoice": ${Ischoice != null ? '${json.encode(Ischoice)}' : 'null'},"NickName": ${NickName != null ? '${json.encode(NickName)}' : 'null'},"Portrait": ${Portrait != null ? '${json.encode(Portrait)}' : 'null'},"ProductCode": ${ProductCode != null ? '${json.encode(ProductCode)}' : 'null'},"ProductNo": ${ProductNo != null ? '${json.encode(ProductNo)}' : 'null'},"SpacValue": ${SpacValue != null ? '${json.encode(SpacValue)}' : 'null'},"UserPK": ${UserPK != null ? '${json.encode(UserPK)}' : 'null'}}';
  }
}

class ActivityProductSKUResp {
  int code;
  String err;
  String errmsg;
  List<ActivityProductSKU> data;

  ActivityProductSKUResp.fromParams(
      {this.code, this.err, this.errmsg, this.data});

  factory ActivityProductSKUResp(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ActivityProductSKUResp.fromJson(json.decode(jsonStr))
          : new ActivityProductSKUResp.fromJson(jsonStr);

  ActivityProductSKUResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    err = jsonRes['err'];
    errmsg = jsonRes['errmsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(
          dataItem == null ? null : new ActivityProductSKU.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"err": ${err != null ? '${json.encode(err)}' : 'null'},"errmsg": ${errmsg != null ? '${json.encode(errmsg)}' : 'null'},"data": $data}';
  }
}

class ActivityProductSKU {
  int Num;
  int Store;
  String Name;
  String SkuID;
  String SpacGroupName;
  List<ActivityProductSKU> Values;

  ActivityProductSKU.fromParams(
      {this.Num,
      this.Store,
      this.Name,
      this.SkuID,
      this.SpacGroupName,
      this.Values});

  ActivityProductSKU.fromJson(jsonRes) {
    Num = jsonRes['Num'];
    Store = jsonRes['Store'];
    Name = jsonRes['Name'];
    SkuID = jsonRes['SkuID'];
    SpacGroupName = jsonRes['SpacGroupName'];
    Values = jsonRes['Values'] == null ? null : [];

    for (var ValuesItem in Values == null ? [] : jsonRes['Values']) {
      Values.add(ValuesItem == null
          ? null
          : new ActivityProductSKU.fromJson(ValuesItem));
    }
  }

  @override
  String toString() {
    return '{"Num": $Num,"Store": $Store,"Name": ${Name != null ? '${json.encode(Name)}' : 'null'},"SkuID": ${SkuID != null ? '${json.encode(SkuID)}' : 'null'},"SpacGroupName": ${SpacGroupName != null ? '${json.encode(SpacGroupName)}' : 'null'},"Values": $Values}';
  }
}
