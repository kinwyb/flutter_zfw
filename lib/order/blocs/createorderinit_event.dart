import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:zfw/components/component.dart';

@immutable
class CreateorderinitEvent extends Equatable {
  final List<ShoppingCartProduct> props;
  CreateorderinitEvent([this.props = const []]) : super(props);
}
