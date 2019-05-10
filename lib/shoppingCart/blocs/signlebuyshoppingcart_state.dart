import 'package:meta/meta.dart';
import 'package:zfw/components/api/shoppingCart.dart';

@immutable
abstract class SignlebuyshoppingcartState {
  SignleBuyShoppingCart get data;
}

class InitialSignlebuyshoppingcartState extends SignlebuyshoppingcartState {
  @override
  SignleBuyShoppingCart get data => SignleBuyShoppingCart(
        shops: [],
      );
}

class SignleBuyShoppingCartLoaded extends SignlebuyshoppingcartState {
  final SignleBuyShoppingCart _data;

  SignleBuyShoppingCartLoaded(this._data);

  @override
  SignleBuyShoppingCart get data => _data;
}

class SignleBuyShoppingCartLoadErr extends SignlebuyshoppingcartState {
  final int errCode;
  final String errMsg;

  SignleBuyShoppingCartLoadErr(this.errCode, this.errMsg);

  @override
  SignleBuyShoppingCart get data => null;
}
