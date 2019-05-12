import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/home.dart';
import './bloc.dart';

class HomebrandBloc extends Bloc<HomebrandEvent, HomebrandState> {
  @override
  HomebrandState get initialState => HomebrandStateValue(data, false);
  List<IndexBrand> data = [];

  @override
  Stream<HomebrandState> mapEventToState(
    HomebrandEvent event,
  ) async* {
    if (event.page < 2) {
      data.clear();
    }
    var brands = await HomeAPI.brands(event.page, 2);
    bool _isEnd = false;
    if (brands == null) {
      _isEnd = true;
    } else {
      data.addAll(brands);
    }
    yield HomebrandStateValue(data, _isEnd);
  }
}
