apply {
  if (H.p4calc.isValid()) {
    calculate.apply();
  } else {
    operation_drop();
  }
}
apply { }