import 'package:meta/meta.dart';
import 'package:zfw/components/api/home.dart';

@immutable
abstract class HomebannerState {
  List<IndexBanner> get data;
}

class HomebannerStateValue extends HomebannerState {
  final List<IndexBanner> _data;

  HomebannerStateValue(this._data);

  @override
  List<IndexBanner> get data => _data;
}
