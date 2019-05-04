import 'dart:convert' show json;

class ImgInfo {
  int Height;
  int Width;
  String Src;
  ImgInfo.fromParams({this.Height, this.Width, this.Src});
  ImgInfo.fromJson(jsonRes) {
    Height = jsonRes['Height'];
    Width = jsonRes['Width'];
    Src = jsonRes['Src'];
  }

  @override
  String toString() {
    return '{"Height": $Height,"Width": $Width,"Src": ${Src != null?'${json.encode(Src)}':'null'}}';
  }
}
