import 'package:meta/meta.dart';
import 'package:zfw/components/api/home.dart';

@immutable
abstract class HomebrandState {
  List<IndexBrand> get data;
  bool get isEnd;
}

class HomebrandStateValue extends HomebrandState {
  final List<IndexBrand> _data;
  final bool _end;
  HomebrandStateValue(this._data, this._end);
  @override
  List<IndexBrand> get data => _data;

  @override
  bool get isEnd => _end;
}
