import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/home.dart';
import './bloc.dart';

class HomebannerBloc extends Bloc<HomebannerEvent, HomebannerState> {
  @override
  HomebannerState get initialState => HomebannerStateValue([]);

  @override
  Stream<HomebannerState> mapEventToState(
    HomebannerEvent event,
  ) async* {
    var data = await HomeAPI.banners();
    yield HomebannerStateValue(data ?? []);
  }
}
