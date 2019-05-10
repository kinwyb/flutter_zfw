import 'package:meta/meta.dart';
import 'package:zfw/components/api/shoppingCart.dart';

@immutable
abstract class ShoppingcartproductcardState {
  List<ShoppingCartProduct> get products;
}

class ShoppingcartproductcardStateLoaded extends ShoppingcartproductcardState {
  final List<ShoppingCartProduct> _products;

  ShoppingcartproductcardStateLoaded(this._products);

  @override
  List<ShoppingCartProduct> get products => _products;
}
