import 'package:meta/meta.dart';

@immutable
abstract class CreateorderbottomState {
  double get amount;
  bool get checkBoxValue;
}

class InitialCreateorderbottomState extends CreateorderbottomState {
  @override
  double get amount => 0.0;
  @override
  bool get checkBoxValue => true;
}

class CreateorderbottomStateValue extends CreateorderbottomState {
  final double _amount;
  final bool _checkBoxValue;
  CreateorderbottomStateValue(this._amount, this._checkBoxValue);

  @override
  double get amount => _amount;
  @override
  bool get checkBoxValue => _checkBoxValue;
}
