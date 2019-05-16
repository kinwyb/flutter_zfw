import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/component.dart';
import './bloc.dart';

class CreateorderinitBloc
    extends Bloc<CreateorderinitEvent, CreateorderinitState> {
  @override
  CreateorderinitState get initialState => CreateorderinitState(false, "");

  @override
  Stream<CreateorderinitState> mapEventToState(
    CreateorderinitEvent event,
  ) async* {
    if (orderReq == null) {
      orderReq = ShoppingCartOrderAddReq(oem: []);
    } else {
      orderReq.oem.clear();
    }
    Map<String, OemOrderAddReq> oemMap = {};
    for (var v in event.props) {
      if (!oemMap.containsKey(v.shopCode)) {
        OemOrderAddReq oemOrder = OemOrderAddReq();
        oemOrder.oemName = v.oemName;
        oemOrder.activityCode = v.activityCode;
        oemOrder.products = [];
        oemMap[v.shopCode] = oemOrder;
        orderReq.oem.add(oemOrder);
      }
      oemMap[v.shopCode].products.add(OemOrderProduct(
            activityCode: v.activityCode,
            skuID: v.skuID,
            num: v.num,
            attr: v.spacValue,
            price: v.price,
            productImg: v.productImage,
            productName: v.productName,
          ));
    }
    yield CreateorderinitState(orderReq.oem.length > 0, "");
  }
}
