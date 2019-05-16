import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/user.dart';
import './bloc.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  @override
  MemberState get initialState => MemberState(null, null, UserDataCount());

  @override
  Stream<MemberState> mapEventToState(
    MemberEvent event,
  ) async* {
    var userInfo = await UserAPI.userInfo();
    var rebateInfo = await UserAPI.rebateInfo();
    var dataCount = await UserAPI.dataCount();
    yield MemberState(userInfo, rebateInfo, dataCount ?? UserDataCount());
  }
}
