import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';

class MemoBox extends HookConsumerWidget {
  const MemoBox({
    required this.item,
    Key? key,
  }) : super(key: key);
  final Memo item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var screenSize = MediaQuery.of(context).size;
    final convertedText = item.body.replaceAll("\\n", "\n");

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 7.5,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(width: screenSize.width * 0.02),
              Flexible(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        convertedText.split('\n')[0],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        convertedText.split('\n').skip(1).join('\n'),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
