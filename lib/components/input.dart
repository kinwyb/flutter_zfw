import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './iconTitle.dart';

class NumInput extends StatefulWidget {
  TextEditingController controller = new TextEditingController();
  FocusNode focusNode;

  Color backgroundColor;
  _NumInputState inputState = new _NumInputState();

  int minNum = 0;
  int maxNum = 65535;

  String text;
  void setText(String newText){
    oldNum = int.parse(newText);
    controller.text = newText;
  }

  TextField textField;

  int oldNum;

  NumInput(
      {Key key,
      this.text,
      this.backgroundColor,
      this.minNum = 0,
      @required this.focusNode,
      this.maxNum = 65535})
      : assert(focusNode != null),
        super(key: key) {
    oldNum = int.parse(text);
    textField = TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.transparent)),
        //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
        contentPadding: EdgeInsets.all(2.0),
        fillColor: backgroundColor,
        filled: true,
        // 以下属性可用来去除TextField的边框
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      focusNode: focusNode,
      //内容改变的回调
      onChanged: (text) {
        try {
          var num = int.parse(text);
          oldNum = num;
          controller.text = num.toString();
        } catch (e) {
          controller.text = oldNum.toString();
        }
      },
    );
  }

  @override
  State<StatefulWidget> createState() => inputState;

  int getNum() {
    return int.parse(controller.text);
  }
}

class _NumInputState extends State<NumInput> {

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.text;
    return Row(
      children: <Widget>[
        Buttom(
          onTap: () {
            try {
              var num = int.parse(widget.controller.text);
              if (num >= widget.maxNum) {
                num = widget.maxNum;
              } else {
                num++;
              }
              widget.oldNum = num;
              widget.controller.text = num.toString();
            } catch (e) {
              widget.controller.text = widget.text;
            }
          },
          children: <Widget>[Icon(Icons.add_circle)],
        ),
        Expanded(
          child: Container(
            color: widget.backgroundColor,
            child: widget.textField,
          ),
        ),
        Buttom(
          onTap: () {
            try {
              var num = int.parse(widget.controller.text);
              if (num <= widget.minNum) {
                widget.controller.text = widget.minNum.toString();
                return false;
              }
              num--;
              widget.oldNum = num;
              widget.controller.text = num.toString();
            } catch (e) {
              widget.controller.text = widget.text;
            }
          },
          children: <Widget>[Icon(Icons.remove_circle)],
        ),
      ],
    );
  }
}
