import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/infrastructure/firebase_storage/firebase_storage.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/news_provider.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class NewsDialog extends HookConsumerWidget {
  const NewsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final isTablet = ref.watch(isTabletProvider);
    final news = ref.watch(newsProvider);

    return MylisBaseDialog(
      widget: Column(
        children: [
          Text(
            news?.title ?? "",
            style: TextStyle(
              fontSize: isTablet
                  ? ThemeFontSize.tabletMediumFontSize
                  : ThemeFontSize.mediumFontSize,
              fontWeight: FontWeight.bold,
              color: colorState.textColor,
            ),
          ),
          SizedBox(height: isTablet ? 40 : 20),
          news?.imageUri != ""
              ? Column(
                  children: [
                    FutureBuilder(
                      future: getImageUrl(news?.imageUri ?? ""),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          if (snapshot.error != null) {
                            return const Text('画像の読み込みに失敗しました');
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ThemeColor.gray,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  snapshot.data ?? "",
                                  width: isTablet ? 600 : 300,
                                  height: isTablet ? 600 : 300,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(height: isTablet ? 40 : 20),
                  ],
                )
              : const SizedBox.shrink(),
          Text(
            news?.content ?? "",
            style: TextStyle(
              fontSize: isTablet
                  ? ThemeFontSize.tabletNormalFontSize
                  : ThemeFontSize.normalFontSize,
              fontWeight: FontWeight.bold,
              color: ThemeColor.darkGray,
            ),
          ),
          SizedBox(height: isTablet ? 40 : 20),
          const Divider(),
          SizedBox(height: isTablet ? 60 : 30),
          SizedBox(
            height: 50,
            width: isTablet ? 260 : 160,
            child: RoundRectButton(
              onPressed: () => {
                ref
                    .read(currentMemberProvider.notifier)
                    .updateIsReadedNews(true),
                Navigator.pop(context),
              },
              text: "今後は表示しない",
            ),
          ),
        ],
      ),
    );
  }
}
