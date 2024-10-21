import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:minicore_arch_example/app/app_widget.dart';
import 'package:minicore_arch_example/app/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  injector.commit();

  runApp(
    const RxRoot(
      child: AppWidget(),
    ),
  );
}
