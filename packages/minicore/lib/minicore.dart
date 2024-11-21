library minicore;

import 'package:flutter/foundation.dart';

abstract class State {}

abstract class Interactor<T extends State> extends ValueNotifier<T> {
  Interactor(super.initialValue);
}
