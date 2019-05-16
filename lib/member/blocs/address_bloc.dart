import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/user.dart';
import './bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  @override
  AddressState get initialState => AddressState([], true);

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    var data = await UserAPI.addressList();
    yield AddressState(data, false);
  }
}
