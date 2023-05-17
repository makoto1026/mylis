import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IsTabletProvider extends StateNotifier<bool> {
  IsTabletProvider() : super(false);

  Future<void> set(BuildContext context) async {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    state = isTablet;
  }
}

final isTabletProvider = StateNotifierProvider<IsTabletProvider, bool>(
  (ref) => IsTabletProvider(),
);
