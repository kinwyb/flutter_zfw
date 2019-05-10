import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ShoppingcartbottomAmountBloc
    extends Bloc<ShoppingcartbottomAmountEvent, ShoppingcartbottomAmountState> {
  @override
  ShoppingcartbottomAmountState get initialState =>
      InitialShoppingcartbottomamountState(0.0);

  @override
  Stream<ShoppingcartbottomAmountState> mapEventToState(
    ShoppingcartbottomAmountEvent event,
  ) async* {
    yield InitialShoppingcartbottomamountState(event.amount);
  }
}
