import 'package:flutter/material.dart';
import '../components/api/activity.dart';

class ActivitySKU extends StatefulWidget {
  List<ActivityProductSKU> sku;

  Map<String, SkuTree> skuAttrMap = {};
  List<SkuTree> skus = [];
  Color backgroundColor;
  Function(SkuTree sku) selectCallBack; //选择规格变化后回调

  ActivitySKU({Key key, this.sku, this.backgroundColor, this.selectCallBack})
      : assert(sku != null),
        super(key: key) {
    for (var s in sku) {
      var ss = SkuTree(s);
      ss.attr = ss.name;
      skuAttrMap[ss.attr] = ss;
      skus.add(ss);
    }
  }

  @override
  State<StatefulWidget> createState() => new ActivitySKUState();
}

class ActivitySKUState extends State<ActivitySKU> {
  Map<int, String> _selectMap = {};
  int _maxLevel = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      constraints: BoxConstraints(
        minHeight: 110,
      ),
      alignment: Alignment.topLeft,
      // color: Colors.green,
      child: Column(
        children: _specValue(level: 1),
      ),
    );
  }

  // 组合规格型号
  List<Widget> _specValue({int level: 1}) {
    List<Widget> wgs = [];
    Wrap wgWrap = Wrap(
      children: <Widget>[],
    );
    String groupName;
    String first = "";
    var sku = widget.skus;
    String prefixAttr = "";
    if (level > 1) {
      sku = widget.skuAttrMap[_selectMap[level - 1]]?.children;
      if (sku == null) {
        _maxLevel = level - 1;
        return wgs;
      }
      prefixAttr = widget.skuAttrMap[_selectMap[level - 1]]?.attr;
      if (prefixAttr != null) {
        prefixAttr = prefixAttr + ",";
      }
    }
    for (var spec in sku) {
      spec.attr = prefixAttr + spec.name;
      if (!widget.skuAttrMap.containsKey(spec.attr)) {
        widget.skuAttrMap[spec.attr] = spec;
      }
      if (spec.children.length < 1 && spec.skuID.isEmpty) {
        // 没有子类而且没有skuid的规格不展示
        continue;
      } else if (first == "" && level == 1) {
        first = spec.attr;
      }
      BoxDecoration decoration = _noSelectedDecoration;
      TextStyle textstyle = _noSelectedTextStyle;
      if ((_selectMap[level] == null && first == spec.attr) ||
          _selectMap[level] == spec.attr) {
        decoration = _selectedDecoration;
        textstyle = _selectedTextStyle;
      }
      wgWrap.children.add(GestureDetector(
        onTap: () {
          // 规格选择变化了,重新渲染
          if (_selectMap[level]?.toString() != spec.attr) {
            _selectMap[level] = spec.attr;
            // 把下一级选择的全部取消掉
            for (var i = level + 1; i <= _maxLevel; i++) {
              _selectMap.remove(i);
            }
            if (widget.selectCallBack != null &&
                _selectMap[_maxLevel] != null) {
              SkuTree sku = widget.skuAttrMap[_selectMap[_maxLevel]];
              widget.selectCallBack(sku);
            } else if (_selectMap[_maxLevel] == null) {
              widget.selectCallBack(null);
            }
            setState(() {});
          }
        },
        child: Container(
          constraints: BoxConstraints(
            minWidth: 40,
          ),
          padding: new EdgeInsets.fromLTRB(10, 3, 10, 3),
          margin: new EdgeInsets.fromLTRB(0, 3, 20, 10),
          decoration: decoration,
          child: Text(
            spec.name,
            textAlign: TextAlign.center,
            style: textstyle,
          ),
        ),
      ));
      groupName = spec.groupName;
    }
    if (groupName == null) {
      _maxLevel = level - 1;
      return wgs;
    }
    var childs = _specValue(level: level + 1);
    // 规格组中间横线
    Border warpContainerDecorationBorder =
        new Border(bottom: BorderSide(width: 1.0, color: Colors.grey[300]));
    if (childs.length < 1) {
      warpContainerDecorationBorder = null;
    }
    wgs.add(Column(
      children: <Widget>[
        Container(
          // color: Colors.purple,
          padding: new EdgeInsets.fromLTRB(10, 10, 20, 5),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  groupName,
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          decoration: new BoxDecoration(border: warpContainerDecorationBorder),
          padding: new EdgeInsets.fromLTRB(30, 5, 20, 5),
          // color: Colors.blue,
          child: wgWrap,
        )
      ],
    ));
    if (level < 2 && !_selectMap.containsKey(level)) {
      _selectMap[level] = first;
      SkuTree firstSKU = widget.skuAttrMap[first];
      if (firstSKU != null && firstSKU.skuID != "") {
        firstSKU.attr = firstSKU.name;
        widget.selectCallBack(firstSKU);
      }
    }
    if (childs.length > 0) {
      wgs.addAll(childs);
    }
    return wgs;
  }

  // 选中状态
  final BoxDecoration _selectedDecoration = new BoxDecoration(
      // border: new Border.all(width: 1.0),
      color: Colors.black,
      // color: Colors.yellow,
      borderRadius: new BorderRadius.circular(10));

  // 没选中状态
  final BoxDecoration _noSelectedDecoration = new BoxDecoration(
      border: new Border.all(width: 1.0),
      borderRadius: new BorderRadius.circular(10));

  // 选中状态
  final TextStyle _selectedTextStyle = new TextStyle(color: Colors.white);

  // 没选中状态
  final TextStyle _noSelectedTextStyle = new TextStyle(color: Colors.black);
}

class SkuTree {
  String groupName;
  String skuID;
  String name;
  int stockNum;
  int num;
  String attr;
  List<SkuTree> children = [];

  SkuTree(ActivityProductSKU sku) {
    groupName = sku.SpacGroupName;
    skuID = sku.SkuID ?? "";
    name = sku.Name;
    stockNum = sku.Store;
    if (sku.Values != null && sku.Values.length > 0) {
      for (var s in sku.Values) {
        children.add(SkuTree(s));
      }
    }
  }

  // 获取指定子对象
  SkuTree getChild(String val) {
    for (var i in children) {
      if (i.name == val) {
        return i;
      }
    }
    return null;
  }
}
