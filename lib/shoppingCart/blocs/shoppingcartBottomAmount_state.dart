import 'package:meta/meta.dart';

@immutable
abstract class ShoppingcartbottomAmountState {
  double get amount => _getAmount();

  double _getAmount();
}

class InitialShoppingcartbottomamountState
    extends ShoppingcartbottomAmountState {
  final double amount;

  InitialShoppingcartbottomamountState(this.amount);

  @override
  double _getAmount() {
    return amount;
  }
}
