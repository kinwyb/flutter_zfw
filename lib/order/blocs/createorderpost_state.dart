import 'package:meta/meta.dart';
import 'package:zfw/components/component.dart';

@immutable
class CreateorderpostState {
  final bool isInit;
  final DirectBuyResp data;
  CreateorderpostState(this.data, [this.isInit = false]);
}
