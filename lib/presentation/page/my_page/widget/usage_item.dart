import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/theme/color.dart';

class UsageItem extends HookConsumerWidget {
  const UsageItem({
    required this.title,
    required this.body,
    required this.imagePath,
    this.height = 60,
    Key? key,
  }) : super(key: key);

  final String title;
  final String body;
  final String imagePath;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorState.textColor,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeColor.gray,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 300,
                height: 300,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ThemeColor.darkGray,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height),
        ],
      ),
    );
  }
}
