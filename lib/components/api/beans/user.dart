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
