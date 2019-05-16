import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/activity.dart';
import './bloc.dart';

class ActivityskuBloc extends Bloc<ActivityskuEvent, ActivityskuState> {
  @override
  ActivityskuState get initialState => ActivityskuState(null);

  @override
  Stream<ActivityskuState> mapEventToState(
    ActivityskuEvent event,
  ) async* {
    List<ActivityProductSKU> data =
        await ActivityAPI.sku(event.activityCode, event.productNo);
    yield ActivityskuState(data);
  }
}
