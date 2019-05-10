import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/shoppingCart.dart';
import './bloc.dart';

class SignlebuyshoppingcartBloc
    extends Bloc<SignlebuyshoppingcartEvent, SignlebuyshoppingcartState> {
  SignleBuyShoppingCart _cartData;

  @override
  SignlebuyshoppingcartState get initialState =>
      InitialSignlebuyshoppingcartState();

  @override
  Stream<SignlebuyshoppingcartState> mapEventToState(
    SignlebuyshoppingcartEvent event,
  ) async* {
    if (event is SignlebuyshoppingcartEventLoad) {
      SignleBuyShoppingCartResp resp = await ShoppingCartAPI.singlebuyInfo();
      if (resp.code != 0) {
        //加载错误
        yield SignleBuyShoppingCartLoadErr(resp.code, resp.errmsg);
        return;
      } else if (resp.data != null) {
        _cartData = resp.data;
        yield SignleBuyShoppingCartLoaded(_cartData);
        return;
      }
    } else if (event is SignlebuyshoppingcartEventRemove) {
      if (_cartData != null && _cartData.shops != null) {
        _cartData.shops.remove(event.shop);
      }
      yield SignleBuyShoppingCartLoaded(_cartData);
      return;
    }
    yield InitialSignlebuyshoppingcartState();
  }
}
