import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart' as cityPickers;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/component.dart';
import 'package:zfw/components/switch.dart';

import 'addressAddSizeUtil.dart';

class MemberAddressAdd extends StatefulWidget {
  @override
  _MemberAddressAddState createState() => _MemberAddressAddState();
}

class _MemberAddressAddState extends State<MemberAddressAdd> {
  AddressAddSizeUtil get _size => getAddressAddSizeUtil();
  _CityPickerBloc _cityPickerBloc = new _CityPickerBloc();
  bool _isDefault = false;
  int areaID = 0;

  @override
  Widget build(BuildContext context) {
    TextField contactUser = _getTextFile("请输入联系人");
    TextField contactPhone = _getTextFile("请输入手机号");
    TextField addressDetail = _getTextFile("请输入详细地址");
    return onTap(
        Scaffold(
          appBar: AppBar(
            title: Text('新增地址'),
            actions: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: _size.saveContainerPadding,
                child: onTap(Text('保存'), () {
                  showPutData(context);
                }),
              ),
            ],
          ),
          backgroundColor: Colors.grey[300],
          body: Wrap(
            children: <Widget>[
              Container(
                padding: _size.containerPadding,
                color: Colors.white,
                child: Wrap(
                  children: <Widget>[
                    Container(
                      padding: _size.lineContainerPadding,
                      decoration: _size.lineContainerDecoration,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: _size.labelContainerWidth,
                            child: Text(
                              '联系人',
                              style: _size.defaultTextStyle,
                            ),
                          ),
                          Expanded(
                            child: contactUser,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: _size.lineContainerPadding,
                      decoration: _size.lineContainerDecoration,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: _size.labelContainerWidth,
                            child: Text(
                              '手机号',
                              style: _size.defaultTextStyle,
                            ),
                          ),
                          Expanded(
                            child: contactPhone,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: _size.lineContainerPadding,
                      decoration: _size.lineContainerDecoration,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: _size.labelContainerWidth,
                            child: Text(
                              '选择地址',
                              style: _size.defaultTextStyle,
                            ),
                          ),
                          Expanded(
                            child: onTap(
                                BlocBuilder<_CityPickerEvent, _CityPickerState>(
                                  bloc: _cityPickerBloc,
                                  builder: (context, state) {
                                    if (state == null ||
                                        state.address.isEmpty) {
                                      return Text(
                                        '请选择地区',
                                        style: _size.defaultTextStyle
                                            .copyWith(color: Colors.grey[600]),
                                      );
                                    } else {
                                      return Text(
                                        state.address,
                                        style: _size.defaultTextStyle,
                                      );
                                    }
                                  },
                                ), () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              cityPickers.Result result =
                                  await cityPickers.CityPickers.showCityPicker(
                                height: _size.cityPickerHeight,
                                context: context,
                              );
                              if (result == null) {
                                return;
                              }
                              areaID = int.parse(result.areaId);
                              _cityPickerBloc.dispatch(_CityPickerEvent(
                                  result.provinceName +
                                      result.cityName +
                                      result.areaName));
                            }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: _size.lineContainerPadding,
                      decoration: _size.lineContainerDecoration,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: _size.labelContainerWidth,
                            child: Text(
                              '详细地址',
                              style: _size.defaultTextStyle,
                            ),
                          ),
                          Expanded(
                            child: addressDetail,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: _size.defaultLineContainerMargin,
                padding: _size.defaultLineContainerPadding,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            '设为默认地址',
                            style: _size.defaultTextStyle,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: CustomerSwitch(
                          value: _isDefault,
                          onChanged: (val) {
                            _isDefault = val;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          width: _size.defaultSwitchWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ), () {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  TextField _getTextFile(String labelText) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        hintText: labelText,
      ),
      style: _size.defaultTextStyle,
    );
  }
}

@immutable
class _CityPickerEvent {
  final String address;
  _CityPickerEvent(this.address);
}

@immutable
class _CityPickerState {
  final String address;
  _CityPickerState(this.address);
}

class _CityPickerBloc extends Bloc<_CityPickerEvent, _CityPickerState> {
  @override
  _CityPickerState get initialState => _CityPickerState("");

  @override
  Stream<_CityPickerState> mapEventToState(
    _CityPickerEvent event,
  ) async* {
    yield _CityPickerState(event.address);
  }
}
