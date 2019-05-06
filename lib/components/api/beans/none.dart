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
  RecommenderBean recommender;

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
        ? RecommenderBean.fromJson(json['Recommender'])
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

class RecommenderBean {
  String Name;
  String Phone;
  String RegisterTime;
  String Portrait;
  String WeiXin;

  RecommenderBean(
      {this.Name, this.Phone, this.RegisterTime, this.Portrait, this.WeiXin});

  RecommenderBean.fromJson(Map<String, dynamic> json) {
    this.Name = json['Name'];
    this.Phone = json['Phone'];
    this.RegisterTime = json['RegisterTime'];
    this.Portrait = json['Portrait'];
    this.WeiXin = json['WeiXin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.Name;
    data['Phone'] = this.Phone;
    data['RegisterTime'] = this.RegisterTime;
    data['Portrait'] = this.Portrait;
    data['WeiXin'] = this.WeiXin;
    return data;
  }
}
