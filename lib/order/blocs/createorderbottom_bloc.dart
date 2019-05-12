import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CreateorderbottomBloc
    extends Bloc<CreateorderbottomEvent, CreateorderbottomState> {
  double _amount = 0.0;
  bool _checkBoxValue = true;

  @override
  CreateorderbottomState get initialState => InitialCreateorderbottomState();

  @override
  Stream<CreateorderbottomState> mapEventToState(
    CreateorderbottomEvent event,
  ) async* {
    if (event is CreateorderbottomEventAmountValue) {
      _amount += event.amount;
    } else if (event is CreateorderbottomEventCheckBoxValue) {
      _checkBoxValue = event.value;
    }
    yield CreateorderbottomStateValue(_amount, _checkBoxValue);
  }
}
