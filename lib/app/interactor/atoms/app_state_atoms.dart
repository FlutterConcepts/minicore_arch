import 'package:asp/asp.dart';
import 'package:minicore_arch_example/app/interactor/models/app_model.dart';

class AppSA {
  static final appStateAtom = Atom<AppModel>(AppModel.empty());
}
