import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/home.dart';
import './bloc.dart';

class HomecategoryBloc extends Bloc<HomecategoryEvent, HomecategoryState> {
  @override
  HomecategoryState get initialState => HomecategoryStateValue([]);

  @override
  Stream<HomecategoryState> mapEventToState(
    HomecategoryEvent event,
  ) async* {
    var categorys = await HomeAPI.categorys();
    yield HomecategoryStateValue(categorys ?? []);
  }
}
