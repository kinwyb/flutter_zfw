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
