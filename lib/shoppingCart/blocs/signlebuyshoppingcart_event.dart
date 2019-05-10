import 'package:zfw/components/api/shoppingCart.dart';

abstract class SignlebuyshoppingcartEvent {}

// 加载数据
class SignlebuyshoppingcartEventLoad extends SignlebuyshoppingcartEvent {}

// 移除店铺
class SignlebuyshoppingcartEventRemove extends SignlebuyshoppingcartEvent {
  ShoppingCartShop shop;
  SignlebuyshoppingcartEventRemove(this.shop);
}
