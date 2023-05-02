import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/main_page.dart' as main;

final tabNavigationStateProvider = Provider.autoDispose(
  (ref) => List.generate(main.Tab.values.length, (index) => index)
      .map(
        (e) => GlobalKey<NavigatorState>(),
      )
      .toList(),
);
