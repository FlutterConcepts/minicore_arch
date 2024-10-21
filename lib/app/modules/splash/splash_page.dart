import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minicore_arch_example/app/shared/widgets/img/tractian_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    unawaited(Future<void>.delayed(const Duration(seconds: 1)).whenComplete(() {
      if (mounted) {
        context.go('/home');
      }
    }));

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: const Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: TractianLogo(),
        ),
      ),
    );
  }
}
