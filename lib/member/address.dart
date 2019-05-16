import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zfw/components/adapt.dart';
import 'package:zfw/components/api/user.dart';
import 'package:zfw/components/component.dart';
import 'package:zfw/components/router/routers.dart';
import 'package:zfw/member/blocs/bloc.dart';

import 'addressSizeUtil.dart';
import 'blocs/address_bloc.dart';

class MemberAddress extends StatefulWidget {
  final bool fromOrder;
  MemberAddress({Key key, this.fromOrder}) : super(key: key);
  @override
  _MemberAddressState createState() => _MemberAddressState();
}

class _MemberAddressState extends State<MemberAddress> {
  final AddressBloc _bloc = new AddressBloc();
  AddressSizeUtil get _size => new AddressSizeUtil();

  @override
  void initState() {
    super.initState();
    _bloc.dispatch(AddressEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地址管理'),
      ),
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<AddressEvent, AddressState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state.isInit) {
            return Container();
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return onTap(_item(state.data[index]), () {
                if (widget.fromOrder) {
                  addrInfo = state.data[index];
                  Navigator.pop(context);
                }
              });
            },
            itemCount: state.data.length,
          );
        },
      ),
      bottomNavigationBar: onTap(
        Wrap(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Colors.red,
              padding: _size.bottomContainerPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: defaultIconSize,
                  ),
                  Text(
                    '新增',
                    style: _size.bottomContainerTextStyle,
                  )
                ],
              ),
            )
          ],
        ),
        () async {
          await memberAddressAddNavigate(context);
          _bloc.dispatch(AddressEvent());
        },
      ),
    );
  }

  Widget _item(UserAddressInfo addr) {
    if (addr.isDefault == yes && addrInfo == null) {
      addrInfo = addr;
    }
    return Container(
      color: Colors.white,
      margin: _size.itemContainerMargin,
      padding: _size.itemContainerPadding,
      child: Wrap(
        children: <Widget>[
          Container(
            decoration: _size.itemContainerUpContainerDecoration,
            padding: _size.itemContainerUpContainerPadding,
            child: Wrap(
              children: <Widget>[
                Container(
                  margin: _size.itemContainerNamePhoneContainerMargin,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          addr.contactsName,
                          style: _size.itemContainerNamePhoneTextStyle,
                        ),
                      ),
                      Container(
                        child: Text(
                          addr.contactsPhone,
                          style: _size.itemContainerNamePhoneTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    addr.provinceName +
                        addr.cityName +
                        addr.districtName +
                        addr.address,
                    style: _size.itemContainerAddrTextStyle,
                  ),
                  padding: _size.itemContainerAddrPadding,
                ),
              ],
            ),
          ),
          Container(
            height: _size.itemContainerDownHeight,
            padding: _size.itemContainerDownPadding,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: CustomerCheckbox(
                            value: addr.isDefault == yes,
                            onChanged: (val) {},
                            activeColor: Colors.green,
                            isCircle: true,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "默认",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: _size.itemContainerDownButtonWidth,
                  padding: _size.itemContainerDownButtonPadding,
                  child: RaisedButton(
                    child: Text(
                      '编辑',
                      style: defaultFontTextStyle,
                    ),
                    shape: _size.itemContainerDownButtonEditShape,
                    color: Colors.white,
                    disabledElevation: 0,
                    onPressed: () {
                      print('ddds');
                    },
                  ),
                ),
                Container(
                  padding: _size.itemContainerDownButtonPadding,
                  width: _size.itemContainerDownButtonWidth,
                  child: RaisedButton(
                    child: Text(
                      '删除',
                      style: defaultFontTextStyle,
                    ),
                    color: Colors.yellow[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: borderRadiusCircular),
                    onPressed: () {
                      print('ddd');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
