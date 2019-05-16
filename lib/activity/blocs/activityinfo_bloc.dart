import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zfw/components/api/activity.dart';
import './bloc.dart';

class ActivityinfoBloc extends Bloc<ActivityinfoEvent, ActivityinfoState> {
  @override
  ActivityinfoState get initialState => ActivityinfoState(null);

  @override
  Stream<ActivityinfoState> mapEventToState(
    ActivityinfoEvent event,
  ) async* {
    ActivityInfo data = await ActivityAPI.info(event.activityCode);
    yield ActivityinfoState(data);
  }
}
