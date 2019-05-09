import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './iconTitle.dart';

class NumInput extends StatefulWidget {
  TextEditingController controller = new TextEditingController();
  FocusNode focusNode;

  Color backgroundColor;
  _NumInputState inputState = new _NumInputState();
  Function(FocusNode) focusNodeValueFunc;
  ValueChanged<String> onChangeed;
  int minNum = 0;
  int maxNum = 65535;

  String text;
  void setText(String newText) {
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
      this.focusNode,
      this.focusNodeValueFunc,
      this.onChangeed,
      this.maxNum = 65535})
      : super(key: key) {
    if (focusNode == null) {
      focusNode = FocusNode();
    }
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
    focusNode.removeListener(_focusNodeListen);
    focusNode.addListener(_focusNodeListen);
    controller.text = text;
    controller.addListener(_onChange);
  }

  void _onChange() {
    if (onChangeed != null) {
      onChangeed(controller.text);
    }
  }

  // 监听function
  void _focusNodeListen() {
    if (focusNodeValueFunc != null) {
      focusNodeValueFunc(focusNode);
    }
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
    widget.controller?.removeListener(widget._onChange);
    widget.controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

// 监听值变动
class ListenValueChangedController<T extends Function> {
  List<ValueChanged<T>> _listens = [];

  void addListen(ValueChanged<T> listen) {
    if (listen != null) {
      _listens.add(listen);
    }
  }

  void removeListen(ValueChanged<T> listen) {
    int index = _listens.indexOf(listen);
    if (index >= 0) {
      _listens.removeAt(index);
    }
  }

  // 更新
  void changeValue(T val) {
    for (var v in _listens) {
      v(val);
    }
  }
}
