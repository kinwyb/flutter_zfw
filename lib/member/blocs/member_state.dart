import 'package:meta/meta.dart';
import 'package:zfw/components/component.dart';

@immutable
class MemberState {
  final UserInfo userInfo;
  final UserRebateInfo rebateInfo;
  final UserDataCount dataCount;
  MemberState(this.userInfo, this.rebateInfo, this.dataCount);
}
