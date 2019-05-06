class LoginResp {
  String errmsg;
  String err;
  int code;
  LoginData data;

  LoginResp({this.errmsg, this.err, this.code, this.data});

  LoginResp.fromJson(Map<String, dynamic> json) {
    this.errmsg = json['errmsg'];
    this.err = json['err'];
    this.code = json['code'];
    this.data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
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

class LoginData {
  String token;
  String isbd;
  String isShop;

  LoginData({this.token, this.isbd, this.isShop});

  LoginData.fromJson(Map<String, dynamic> json) {
    this.token = json['Token'];
    this.isbd = json['Isbd'];
    this.isShop = json['IsShop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['Isbd'] = this.isbd;
    data['IsShop'] = this.isShop;
    return data;
  }
}
