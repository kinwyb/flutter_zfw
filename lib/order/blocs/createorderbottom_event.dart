abstract class CreateorderbottomEvent {}

class CreateorderbottomEventAmountValue extends CreateorderbottomEvent {
  double amount;
  CreateorderbottomEventAmountValue(this.amount);
}

class CreateorderbottomEventCheckBoxValue extends CreateorderbottomEvent {
  bool value;
  CreateorderbottomEventCheckBoxValue(this.value);
}
