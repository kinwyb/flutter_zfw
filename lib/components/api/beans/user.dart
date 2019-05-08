class UserRebateInfoResp {
  String errmsg;
  String err;
  int code;
  UserRebateInfo data;

  UserRebateInfoResp({this.errmsg, this.err, this.code, this.data});

  UserRebateInfoResp.fromJson(Map<String, dynamic> json) {
    this.errmsg = json['errmsg'];
    this.err = json['err'];
    this.code = json['code'];
    this.data =
        json['data'] != null ? UserRebateInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errmsg'] = this.errmsg;
    data['err'] = this.err;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserRebateInfo {
  double waitSettlementMoney;
  double dayRebateMoney;
  double yestDayRebateMoney;
  double allRebateMoney;
  double availableMoney;

  UserRebateInfo(
      {this.waitSettlementMoney,
      this.dayRebateMoney,
      this.yestDayRebateMoney,
      this.allRebateMoney,
      this.availableMoney});

  UserRebateInfo.fromJson(Map<String, dynamic> json) {
    this.waitSettlementMoney = json['WaitSettlementMoney'];
    this.dayRebateMoney = json['DayRebateMoney'];
    this.yestDayRebateMoney = json['YestDayRebateMoney'];
    this.allRebateMoney = json['AllRebateMoney'];
    this.availableMoney = json['AvailableMoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WaitSettlementMoney'] = this.waitSettlementMoney;
    data['DayRebateMoney'] = this.dayRebateMoney;
    data['YestDayRebateMoney'] = this.yestDayRebateMoney;
    data['AllRebateMoney'] = this.allRebateMoney;
    data['AvailableMoney'] = this.availableMoney;
    return data;
  }
}

class UserFansInfoResp {
  String errmsg;
  String err;
  int code;
  UserFansInfo data;

  UserFansInfoResp({this.errmsg, this.err, this.code, this.data});

  UserFansInfoResp.fromJson(Map<String, dynamic> json) {
    this.errmsg = json['errmsg'];
    this.err = json['err'];
    this.code = json['code'];
    this.data =
        json['data'] != null ? UserFansInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errmsg'] = this.errmsg;
    data['err'] = this.err;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserFansInfo {
  String registerTime;
  int fansCount;
  int todayFansCount;
  int yesterdayFansCount;
  int minFansNum;
  UserRecommender recommender;

  UserFansInfo(
      {this.registerTime,
      this.fansCount,
      this.todayFansCount,
      this.yesterdayFansCount,
      this.minFansNum,
      this.recommender});

  UserFansInfo.fromJson(Map<String, dynamic> json) {
    this.registerTime = json['RegisterTime'];
    this.fansCount = json['FansCount'];
    this.todayFansCount = json['TodayFansCount'];
    this.yesterdayFansCount = json['YesterdayFansCount'];
    this.minFansNum = json['MinFansNum'];
    this.recommender = json['Recommender'] != null
        ? UserRecommender.fromJson(json['Recommender'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegisterTime'] = this.registerTime;
    data['FansCount'] = this.fansCount;
    data['TodayFansCount'] = this.todayFansCount;
    data['YesterdayFansCount'] = this.yesterdayFansCount;
    data['MinFansNum'] = this.minFansNum;
    if (this.recommender != null) {
      data['Recommender'] = this.recommender.toJson();
    }
    return data;
  }
}

class UserRecommender {
  String name;
  String phone;
  String registerTime;
  String portrait;
  String weiXin;

  UserRecommender(
      {this.name, this.phone, this.registerTime, this.portrait, this.weiXin});

  UserRecommender.fromJson(Map<String, dynamic> json) {
    this.name = json['Name'];
    this.phone = json['Phone'];
    this.registerTime = json['RegisterTime'];
    this.portrait = json['Portrait'];
    this.weiXin = json['WeiXin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Phone'] = this.phone;
    data['RegisterTime'] = this.registerTime;
    data['Portrait'] = this.portrait;
    data['WeiXin'] = this.weiXin;
    return data;
  }
}

class UserInfoResp {
  String errmsg;
  String err;
  int code;
  UserInfo data;

  UserInfoResp({this.errmsg, this.err, this.code, this.data});

  UserInfoResp.fromJson(Map<String, dynamic> json) {
    this.errmsg = json['errmsg'];
    this.err = json['err'];
    this.code = json['code'];
    this.data = json['data'] != null ? UserInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errmsg'] = this.errmsg;
    data['err'] = this.err;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserInfo {
  String pk;
  String phone;
  String email;
  String userName;
  String payPassword;
  String imToken;
  String portrait;
  String inviteCode;
  String recommender;
  String registerTime;
  String areaID;
  String areaDetail;
  String extraMessage;
  String qq;
  String weibo;
  String weixin;
  String weixinExt;
  String ali;
  String name;
  String certID;
  String certImg1;
  String certImg2;
  String submitTime;
  String auditTime;
  String refusereason;
  String sex;
  String titleImage;
  String factoryName;
  String birthYear;
  String companyName;
  String legalPerson;
  String contactPhone;
  String nickname;
  String identity;
  String hunter;
  double availableMoney;
  double freezeMoney;
  double longitude;
  double latitude;
  int userType;
  int enableState;
  int credits;
  int state;
  int wipeMoney;

  UserInfo(
      {this.pk,
      this.phone,
      this.email,
      this.userName,
      this.payPassword,
      this.imToken,
      this.portrait,
      this.inviteCode,
      this.recommender,
      this.registerTime,
      this.areaID,
      this.areaDetail,
      this.extraMessage,
      this.qq,
      this.weibo,
      this.weixin,
      this.weixinExt,
      this.ali,
      this.name,
      this.certID,
      this.certImg1,
      this.certImg2,
      this.submitTime,
      this.auditTime,
      this.refusereason,
      this.sex,
      this.titleImage,
      this.factoryName,
      this.birthYear,
      this.companyName,
      this.legalPerson,
      this.contactPhone,
      this.nickname,
      this.identity,
      this.hunter,
      this.availableMoney,
      this.freezeMoney,
      this.longitude,
      this.latitude,
      this.userType,
      this.enableState,
      this.credits,
      this.state,
      this.wipeMoney});

  UserInfo.fromJson(Map<String, dynamic> json) {
    this.pk = json['Pk'];
    this.phone = json['Phone'];
    this.email = json['Email'];
    this.userName = json['UserName'];
    this.payPassword = json['PayPassword'];
    this.imToken = json['IMToken'];
    this.portrait = json['Portrait'];
    this.inviteCode = json['InviteCode'];
    this.recommender = json['Recommender'];
    this.registerTime = json['RegisterTime'];
    this.areaID = json['AreaID'];
    this.areaDetail = json['AreaDetail'];
    this.extraMessage = json['ExtraMessage'];
    this.qq = json['QQ'];
    this.weibo = json['Weibo'];
    this.weixin = json['Weixin'];
    this.weixinExt = json['WeixinExt'];
    this.ali = json['Ali'];
    this.name = json['Name'];
    this.certID = json['CertID'];
    this.certImg1 = json['CertImg1'];
    this.certImg2 = json['CertImg2'];
    this.submitTime = json['SubmitTime'];
    this.auditTime = json['AuditTime'];
    this.refusereason = json['Refusereason'];
    this.sex = json['Sex'];
    this.titleImage = json['TitleImage'];
    this.factoryName = json['FactoryName'];
    this.birthYear = json['BirthYear'];
    this.companyName = json['CompanyName'];
    this.legalPerson = json['LegalPerson'];
    this.contactPhone = json['ContactPhone'];
    this.nickname = json['Nickname'];
    this.identity = json['Identity'];
    this.hunter = json['Hunter'];
    this.availableMoney = json['AvailableMoney'];
    this.freezeMoney = json['FreezeMoney'];
    this.longitude = json['Longitude'];
    this.latitude = json['Latitude'];
    this.userType = json['UserType'];
    this.enableState = json['EnableState'];
    this.credits = json['Credits'];
    this.state = json['State'];
    this.wipeMoney = json['WipeMoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Pk'] = this.pk;
    data['Phone'] = this.phone;
    data['Email'] = this.email;
    data['UserName'] = this.userName;
    data['PayPassword'] = this.payPassword;
    data['IMToken'] = this.imToken;
    data['Portrait'] = this.portrait;
    data['InviteCode'] = this.inviteCode;
    data['Recommender'] = this.recommender;
    data['RegisterTime'] = this.registerTime;
    data['AreaID'] = this.areaID;
    data['AreaDetail'] = this.areaDetail;
    data['ExtraMessage'] = this.extraMessage;
    data['QQ'] = this.qq;
    data['Weibo'] = this.weibo;
    data['Weixin'] = this.weixin;
    data['WeixinExt'] = this.weixinExt;
    data['Ali'] = this.ali;
    data['Name'] = this.name;
    data['CertID'] = this.certID;
    data['CertImg1'] = this.certImg1;
    data['CertImg2'] = this.certImg2;
    data['SubmitTime'] = this.submitTime;
    data['AuditTime'] = this.auditTime;
    data['Refusereason'] = this.refusereason;
    data['Sex'] = this.sex;
    data['TitleImage'] = this.titleImage;
    data['FactoryName'] = this.factoryName;
    data['BirthYear'] = this.birthYear;
    data['CompanyName'] = this.companyName;
    data['LegalPerson'] = this.legalPerson;
    data['ContactPhone'] = this.contactPhone;
    data['Nickname'] = this.nickname;
    data['Identity'] = this.identity;
    data['Hunter'] = this.hunter;
    data['AvailableMoney'] = this.availableMoney;
    data['FreezeMoney'] = this.freezeMoney;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['UserType'] = this.userType;
    data['EnableState'] = this.enableState;
    data['Credits'] = this.credits;
    data['State'] = this.state;
    data['WipeMoney'] = this.wipeMoney;
    return data;
  }
}

class UserDataCountResp {
  String errmsg;
  String err;
  int code;
  UserDataCount data;

  UserDataCountResp({this.errmsg, this.err, this.code, this.data});

  UserDataCountResp.fromJson(Map<String, dynamic> json) {
    this.errmsg = json['errmsg'];
    this.err = json['err'];
    this.code = json['code'];
    this.data =
        json['data'] != null ? UserDataCount.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errmsg'] = this.errmsg;
    data['err'] = this.err;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserDataCount {
  int waitPayOrder;
  int waitSending;
  int waitDelivey;
  int waitAssess;
  int coupons;

  UserDataCount(
      {this.waitPayOrder,
      this.waitSending,
      this.waitDelivey,
      this.waitAssess,
      this.coupons});

  UserDataCount.fromJson(Map<String, dynamic> json) {
    this.waitPayOrder = json['WaitPayOrder'];
    this.waitSending = json['WaitSending'];
    this.waitDelivey = json['WaitDelivey'];
    this.waitAssess = json['WaitAssess'];
    this.coupons = json['Coupons'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WaitPayOrder'] = this.waitPayOrder;
    data['WaitSending'] = this.waitSending;
    data['WaitDelivey'] = this.waitDelivey;
    data['WaitAssess'] = this.waitAssess;
    data['Coupons'] = this.coupons;
    return data;
  }
}
