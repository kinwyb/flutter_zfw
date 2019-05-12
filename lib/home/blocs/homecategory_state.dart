import 'package:meta/meta.dart';
import 'package:zfw/components/api/home.dart';

@immutable
abstract class HomecategoryState {
  List<IndexCategory> get data;
}

class HomecategoryStateValue extends HomecategoryState {
  final List<IndexCategory> _data;
  HomecategoryStateValue(this._data);

  @override
  List<IndexCategory> get data => _data;
}
