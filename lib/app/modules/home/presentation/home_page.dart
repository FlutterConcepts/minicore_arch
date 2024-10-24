import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/actions/home_actions.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/atoms/home_atom.dart';
import 'package:minicore_arch_example/app/shared/widgets/img/custom_companies_icon.dart';
import 'package:minicore_arch_example/app/shared/widgets/img/tractian_logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    unawaited(getCompaniesListAction());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    context.select(() => [
          companiesListState,
          isLoadingState,
          errorMessageState,
        ]);

    return Scaffold(
      appBar: AppBar(
        title: TractianLogo(
          width: size.width * 0.35,
          colorFilter: colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLoadingState.value)
              const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            else if (errorMessageState.value.isNotEmpty)
              Center(
                child: Text(errorMessageState.value),
              )
            else if (companiesListState.value.isEmpty)
              const Center(
                child: Text('Companies not found'),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: companiesListState.value.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemBuilder: (context, index) {
                    final item = companiesListState.value[index];
                    return InkWell(
                      onTap: () async {
                        await context.push('/assets/${item.id}');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 32),
                        child: Row(
                          children: [
                            CustomCompaniesIcon(color: colorScheme.onPrimary),
                            const SizedBox(width: 16),
                            Text(
                              item.name,
                              style: textTheme.headlineMedium
                                  ?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
