import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/font_size.dart';

class MemoBox extends HookConsumerWidget {
  const MemoBox({
    required this.item,
    Key? key,
  }) : super(key: key);
  final Memo item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstLine = useState("");
    final secondLine = useState("");
    var screenSize = MediaQuery.of(context).size;
    final convertedText = item.body.replaceAll("\\n", "\n");
    final isTablet = ref.watch(isTabletProvider);

    List<String> lines =
        convertedText.split('\n').where((line) => line.isNotEmpty).toList();

    if (lines.length >= 2) {
      firstLine.value = lines[0];
      secondLine.value = lines[1];
    } else {
      firstLine.value = lines[0];
      secondLine.value = "";
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 10 : 5,
        vertical: isTablet ? 15 : 7.5,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: isTablet ? 30 : 15,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: screenSize.width * 0.02,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstLine.value,
                      style: TextStyle(
                        fontSize: isTablet
                            ? ThemeFontSize.tabletNormalFontSize
                            : ThemeFontSize.normalFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (secondLine.value != "")
                      Column(
                        children: [
                          SizedBox(height: isTablet ? 10 : 5),
                          Text(
                            secondLine.value,
                            style: TextStyle(
                              fontSize: isTablet
                                  ? ThemeFontSize.tabletSmallFontSize
                                  : ThemeFontSize.smallFontSize,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
