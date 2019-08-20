import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/user.dart';
import './bloc.dart';

class HomeheadBloc extends Bloc<HomeheadEvent, HomeheadState> {
  final UserRebateInfo rebateInfo = UserRebateInfo();
  final UserFansInfo fansInfo = UserFansInfo();

  @override
  HomeheadState get initialState => HomeheadState(rebateInfo, fansInfo);

  @override
  Stream<HomeheadState> mapEventToState(
    HomeheadEvent event,
  ) async* {
    var rebateInfo = await UserAPI.rebateInfo();
    var fansInfo = await UserAPI.fansInfo();
    yield HomeheadState(
        rebateInfo ?? this.rebateInfo, fansInfo ?? this.fansInfo);
  }
}
