import 'package:meta/meta.dart';

@immutable
class ActivityskuEvent {
  final String activityCode;
  final String productNo;
  ActivityskuEvent(this.activityCode, this.productNo);
}
