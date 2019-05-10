import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/shoppingCart.dart';
import './bloc.dart';

class ShoppingcartproductcardBloc
    extends Bloc<ShoppingcartproductcardEvent, ShoppingcartproductcardState> {
  final ShoppingCartShop shop;
  ShoppingcartproductcardBloc(this.shop);

  @override
  ShoppingcartproductcardState get initialState =>
      ShoppingcartproductcardStateLoaded(shop?.items);

  @override
  Stream<ShoppingcartproductcardState> mapEventToState(
    ShoppingcartproductcardEvent event,
  ) async* {
    yield ShoppingcartproductcardStateLoaded(shop.items);
  }
}
