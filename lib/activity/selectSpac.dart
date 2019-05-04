import 'package:flutter/material.dart';
import '../components/iconTitle.dart';
import '../components/api/activity.dart';
import '../components/input.dart';
import './sku.dart';

class ActivitySelectSpec extends StatefulWidget {
  ActivityInfo info;
  bool addShoppingCart; //是否是加入购物车
  String text;
  Color backgroundColor;
  List<ActivityProductSKU> skus;
  void Function(Map<String, int> value, bool addShoppingCart) callback;

  ActivitySelectSpec(
      {Key key,
      this.callback,
      this.addShoppingCart,
      this.text,
      @required this.skus,
      this.backgroundColor: Colors.white,
      @required this.info})
      : assert(info != null),
        assert(skus != null),
        super(key: key) {
    if (this.text == null || this.text.trim() == "") {
      this.text = addShoppingCart ? "加入购物车" : "立即购买";
    }
  }

  @override
  State<StatefulWidget> createState() =>
      new ActivitySelectSpecState(backgroundColor);
}

// 选择规格
class ActivitySelectSpecState extends State<ActivitySelectSpec> {
  Map<String, int> resultValue = Map();
  Map<String, int> iconValue = Map();
  int _stockNum = 0;
  String skuID = "22";
  NumInput numInput;
  bool keyboard = false;
  final ScrollController _controller = ScrollController();
  final GlobalKey globalKey = GlobalKey();
  double moveUp = 1000;
  FocusNode _focusNode = new FocusNode();
  VoidCallback _focusNodeListen;
  // double _currentPosition = 0.0;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.removeListener(_focusNodeListen);
    _focusNode.dispose();
  }

  ActivitySelectSpecState(Color backgroundColor) {
    _focusNodeListen = () {
      _gridKey();
      keyboard = _focusNode.hasFocus;
      setState(() {});
    };
    _focusNode.addListener(_focusNodeListen);
    numInput = NumInput(
      text: "0",
      backgroundColor: backgroundColor,
      focusNode: this._focusNode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (keyboard) {
          _focusNode.unfocus();
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: _controller,
        child: Wrap(
          children: <Widget>[
            _buiTop(context),
            ActivitySKU(
              key:globalKey,
              sku:widget.skus,
              backgroundColor: widget.backgroundColor,
            ),
            _buyNum(context),
            Buttom(
              onTap: () {
                resultValue["dd"] = 2;
                if (widget.callback != null) {
                  widget.callback(resultValue, widget.addShoppingCart);
                }
                Navigator.pop(context);
                return true;
              },
              backgroundColor: Colors.red,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
            _keyboardContainer(context)
          ],
        ),
      ),
    );
  }

  Widget _keyboardContainer(BuildContext context) {
    var move = MediaQuery.of(context).viewInsets.bottom;
    if (keyboard) {
      _controller
          .animateTo(moveUp,
              duration: Duration(milliseconds: 200), curve: Curves.easeOut)
          .then((Null) {
        // print(_controller.offset);
      });
      return Container(
        height: move,
      );
    } else {
      return Container();
    }
  }

  void _gridKey() {
    moveUp = globalKey.currentContext.size.height;
  }

  // 顶部控件
  Widget _buiTop(BuildContext context) {
    return Container(
      height: 100,
      padding: new EdgeInsets.fromLTRB(10, 10, 10, 5),
      // color: Colors.purple,
      color: widget.backgroundColor,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            child: Image.network(widget.info.Imgs[0].Src, fit: BoxFit.fill),
          ),
          Container(
            margin: new EdgeInsets.fromLTRB(5, 0, 0, 0),
            // color: Colors.yellow,
            width: MediaQuery.of(context).size.width - 100 - 20 - 5,
            child: Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // 价格
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(text: "¥", children: [
                          TextSpan(
                              text: "${widget.info.SingleBuyPrice}",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ))
                        ]),
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    // 库存
                    _stock(context),
                    // 商品规格提示
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: new EdgeInsets.only(top: 2),
                      child: Text(
                        "请选中商品规格",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[800],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 库存
  Widget _stock(BuildContext context) {
    if (skuID == null || skuID.trim() == "") {
      return Container();
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: new EdgeInsets.only(top: 2),
      child: Text(
        "库存: ${_stockNum}",
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  // 购买数量
  Widget _buyNum(BuildContext context) {
    return Container(
      height: 60,
      padding: new EdgeInsets.fromLTRB(10, 5, 10, 2),
      // color: Colors.yellow,
      color: widget.backgroundColor,
      child: Row(
        children: <Widget>[
          Text('购买数量'),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Container(
                width: 100,
                // color: Colors.lightBlue,
                child: numInput,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
