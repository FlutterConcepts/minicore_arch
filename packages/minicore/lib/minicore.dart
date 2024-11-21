library minicore;

import 'package:flutter/foundation.dart';

abstract class FutureUseCase<T extends State, Params> {
  Future<T> call(Params params);
}

abstract class UseCase<T extends State> {
  T call(dynamic params);
}

abstract class Interactor<T extends State> extends ValueNotifier<T> {
  Interactor(super.initialValue);
}

abstract class State {}
