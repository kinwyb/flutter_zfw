import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/order.dart';
import 'package:zfw/components/component.dart';
import './bloc.dart';

class CreateorderpostBloc
    extends Bloc<CreateorderpostEvent, CreateorderpostState> {
  @override
  CreateorderpostState get initialState => CreateorderpostState(null, true);

  @override
  Stream<CreateorderpostState> mapEventToState(
    CreateorderpostEvent event,
  ) async* {
    DirectBuyResp result;
    if (event == CreateorderpostEvent.DirectBuy) {
      result = await _directBuy();
//      print(result.toString());
//      result = DirectBuyResp.fromJson(jsonDecode(
//          '{"code":0,"errmsg":"","err":"","data":{"OrderNo":"868051046949392","GroupNo":"","RemainingTime":1800,"PayValue":{"sign":"3+s9U0U6wI0ax+a+xlMyQcPM+YG8lW6wLSjirnwPehXa6QhviWZXslN22Hw+wVQWX9gEAkgphrKpdY9OGsZx5u3mhmBj+0uTLR1j1vK3iDWe5hwSJwZ0UN+9DgQsPTXM7AsaAeZJbfiVAgo3jZ9EAsbSbXetRlyzUKp81dcFfdEe4sRy56C4XCd9D9FwugJ22tLG7tEMevjm5HL14S2Dn0fnSSyY11B6bSrHsSP8ShtnjVYzciF3lCkPq0sthW01bNYNt32nfakLVRnB6B34Z1akVwuZJ5flwcZ+U16Uq4EumfF36YXRDFpn9bkHnJuKy3W0oOyzlhpXN9VGG0byVg==","appId":"wx5f335b183a6092ad","timeStamp":"1557973248","nonceStr":"3ab94b8628104f579a48b8a9a679755e","package":"prepay_id=wx16102048029213bccead1ae80567080797","signType":"RSA"}}}'));
    }
    yield CreateorderpostState(result);
  }

  Future<DirectBuyResp> _directBuy() async {
    if (orderReq == null || orderReq.oem.length < 1) {
      return DirectBuyResp(code: -1, errmsg: "订单信息空");
    }
    orderReq.oem.first.addrCode = addrInfo.code;
    return OrderAPI.directBuy(orderReq.oem.first);
  }
}
