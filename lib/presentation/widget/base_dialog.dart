import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/provider/is_tablet_provider.dart';

class MylisBaseDialog extends HookConsumerWidget {
  const MylisBaseDialog({
    required this.widget,
    Key? key,
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = ref.watch(isTabletProvider);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          isTablet ? 48 : 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: widget),
            ),
          ],
        ),
      ),
    );
  }
}
