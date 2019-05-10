import 'dart:convert' show json;

class PageObj {
  int allpage;
  int page;
  int rows;
  int total;

  PageObj.fromParams({this.allpage, this.page, this.rows, this.total});

  PageObj.fromJson(jsonRes) {
    allpage = jsonRes['allpage'];
    page = jsonRes['page'];
    rows = jsonRes['rows'];
    total = jsonRes['total'];
  }

  @override
  String toString() {
    return '{"allpage": $allpage,"page": $page,"rows": $rows,"total": $total}';
  }
}

class StringResp {
  String errmsg;
  String err;
  int code;
  PageObj page;
  String data;

  StringResp({this.errmsg, this.err, this.code, this.page, this.data});

  StringResp.fromJson(Map<String, dynamic> json) {
    this.errmsg = json['errmsg'];
    this.err = json['err'];
    this.code = json['code'];
    this.page = json['page'] != null ? PageObj.fromJson(json['page']) : null;
    this.data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errmsg'] = this.errmsg;
    data['err'] = this.err;
    data['code'] = this.code;
    if (this.page != null) {
      data['page'] = this.page.toString();
    }
    data['data'] = this.data;
    return data;
  }
}

class ImgInfo {
  int height;
  int width;
  String src;
  ImgInfo.fromParams({this.height, this.width, this.src});
  ImgInfo.fromJson(jsonRes) {
    height = jsonRes['Height'];
    width = jsonRes['Width'];
    src = jsonRes['Src'];
  }

  @override
  String toString() {
    return '{"Height": $height,"Width": $width,"Src": ${src != null ? '${json.encode(src)}' : 'null'}}';
  }
}
