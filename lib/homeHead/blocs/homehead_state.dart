import 'package:meta/meta.dart';
import 'package:zfw/components/component.dart';

@immutable
class HomeheadState {
  final UserRebateInfo rebateInfo;
  final UserFansInfo fansInfo;
  HomeheadState(this.rebateInfo, this.fansInfo);
}
