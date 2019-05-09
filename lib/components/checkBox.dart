import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zfw/components/component.dart';

class CheckBoxTree<T> extends StatefulWidget {
  /// Whether this checkbox is checked.
  ///
  /// This property must not be null.
  final bool value;

  /// Called when the value of the checkbox should change.
  ///
  /// The checkbox passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the checkbox with the new
  /// value.
  ///
  /// If this callback is null, the checkbox will be displayed as disabled
  /// and will not respond to input gestures.
  ///
  /// When the checkbox is tapped, if [tristate] is false (the default) then
  /// the [onChanged] callback will be applied to `!value`. If [tristate] is
  /// true this callback cycle from false to true to null.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// Checkbox(
  ///   value: _throwShotAway,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _throwShotAway = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool> onChanged;

  /// The color to use when this checkbox is checked.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  final Color activeColor;

  /// The color to use for the check icon when this checkbox is checked
  ///
  /// Defaults to Color(0xFFFFFFFF)
  final Color checkColor;

  /// If true the checkbox's [value] can be true, false, or null.
  ///
  /// Checkbox displays a dash when its value is null.
  ///
  /// When a tri-state checkbox is tapped its [onChanged] callback will be
  /// applied to true if the current value is null or false, false otherwise.
  /// Typically tri-state checkboxes are disabled (the onChanged callback is
  /// null) so they don't respond to taps.
  ///
  /// If tristate is false (the default), [value] must not be null.
  final bool tristate;

  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [ThemeData.materialTapTargetSize].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize materialTapTargetSize;
  final Color childActiveColor;
  final Widget child;
  final T data;

  final CheckBoxTree<T> parent;
  final List<CheckBoxTree<T>> _children = [];

  /// Creates a material design checkbox.
  ///
  /// The checkbox itself does not maintain any state. Instead, when the state of
  /// the checkbox changes, the widget calls the [onChanged] callback. Most
  /// widgets that use a checkbox will listen for the [onChanged] callback and
  /// rebuild the checkbox with a new [value] to update the visual appearance of
  /// the checkbox.
  ///
  /// The following arguments are required:
  ///
  /// * [value], which determines whether the checkbox is checked. The [value]
  ///   can only be null if [tristate] is true.
  /// * [onChanged], which is called when the value of the checkbox should
  ///   change. It can be set to null to disable the checkbox.
  ///
  /// The value of [tristate] must not be null.
  CheckBoxTree({
    Key key,
    @required this.value,
    this.tristate = false,
    @required this.onChanged,
    this.activeColor,
    this.childActiveColor,
    this.checkColor,
    this.parent,
    this.child,
    this.data,
    this.materialTapTargetSize,
  })  : assert(tristate != null),
        assert(tristate || value != null),
        super(key: key) {
    _value = value;
    _activeColor = _activeColor;
    if (parent != null) {
      parent._addChild(this);
      if (parent._allChildrenChecked) {
        _value = true;
      }
    }
  }

  bool _value; //实际值
  Color _activeColor; //选中的颜色

  // 添加子控件
  void _addChild(CheckBoxTree child) {
    this._children.add(child);
  }

  // notifyParent是否先上通知,这里主要是父节点变更后会通知子节点,而子节点优惠反通知父节点导致循环
  // 通过notifyParent控制是否向父节点通知,notifyChildren 类似
  void _valueChange(bool value,
      [bool notifyParent = true, bool notifyChildren = true]) {
    if (notifyChildren && _children.length > 0) {
      for (var v in _children) {
        v._valueChange(value, false);
      }
    }
    _checkChildrenValue(value);
    if (parent != null && notifyParent) {
      //更新上一级的状态
      parent._valueChange(value, notifyParent, false);
    }
    //值改变了
    if (_state != null) {
      _state(value);
    }
  }

  // 被销毁
  dispose() {
    if (parent != null) {
      parent._children.remove(this);
      // 延时更新
      Future.delayed(Duration.zero, () => parent._valueChange(parent._value));
    }
    for (var v in _children) {
      v.dispose();
    }
  }

  // 获取所有选中的值
  List<T> checkedDatas() {
    List<T> ret = [];
    if (_allChildrenChecked && _value && data != null) {
      ret.add(data);
    }
    for (var v in _children) {
      ret.addAll(v.checkedDatas());
    }
    return ret;
  }

  // 是否选中
  bool isChecked() {
    return _value;
  }

  bool _hasChildChecked = false; //是否有子对象选中
  bool _allChildrenChecked = false; //所有子对象选中

  // 子对象是否选中
  void _checkChildrenValue(bool value) {
    _activeColor = activeColor;
    _allChildrenChecked = value;
    _hasChildChecked = value;
    if (_children.length > 0) {
      _hasChildChecked = false;
      for (var c in _children) {
        _hasChildChecked = _hasChildChecked ? true : c._hasChildChecked;
        _allChildrenChecked = _allChildrenChecked && c._allChildrenChecked;
      }
      if (_hasChildChecked && !_allChildrenChecked) {
        _activeColor = childActiveColor ?? activeColor;
      }
    }
    _value = value ? value : _hasChildChecked;
  }

  ValueChanged<bool> _state;

  @override
  _CheckBoxTreeState createState() => _CheckBoxTreeState();
}

class _CheckBoxTreeState extends State<CheckBoxTree> {
  void _valueChange(bool value) {
    _upate();
  }

  void _upate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    widget._state = _valueChange;
    Checkbox checkBox = Checkbox(
      value: widget._value,
      tristate: widget.tristate,
      onChanged: _onChanged,
      activeColor: widget._activeColor,
      checkColor: widget.checkColor,
      materialTapTargetSize: widget.materialTapTargetSize,
    );
    if (widget.child == null) {
      return checkBox;
    } else {
      return onTap(
          Row(
            children: <Widget>[checkBox, widget.child],
          ), () {
        _onChanged(!widget._value);
      });
    }
  }

  void _onChanged(bool value) {
    widget._valueChange(value);
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }
}
