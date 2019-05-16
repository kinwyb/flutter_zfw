import 'package:meta/meta.dart';
import 'package:zfw/components/api/user.dart';

@immutable
class AddressState {
  final List<UserAddressInfo> data;
  final bool isInit;
  AddressState(this.data, [this.isInit = false]);
}
