import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/my_page/widget/usage_item.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class UsagePage extends HookConsumerWidget {
  const UsagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final usageScrollController = useScrollController();
    final isTablet = ref.watch(isTabletProvider);

    final GlobalKey firstKey = GlobalKey();
    final GlobalKey secondKey = GlobalKey();
    final GlobalKey thirdKey = GlobalKey();
    final GlobalKey fourthKey = GlobalKey();
    final GlobalKey fifthKey = GlobalKey();
    final GlobalKey sixthKey = GlobalKey();
    final GlobalKey seventhKey = GlobalKey();

    void scrollToTarget(GlobalKey targetKey) async {
      final RenderBox renderBox =
          targetKey.currentContext?.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      await usageScrollController.animateTo(
        position.dy - 120,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "使い方",
          style: TextStyle(
            color: colorState.textColor,
            fontWeight: FontWeight.bold,
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
          ),
        ),
        leadingWidth: isTablet ? 80 : 40,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: isTablet ? 36 : 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ThemeColor.darkGray,
        ),
      ),
      floatingActionButton: SizedBox(
        width: isTablet ? 105 : 70,
        height: isTablet ? 105 : 70,
        child: FloatingActionButton(
          onPressed: () => {
            usageScrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            ),
          },
          backgroundColor: colorState.textColor,
          child: Icon(
            Icons.arrow_upward,
            size: isTablet ? 60 : 40,
            color: ThemeColor.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: usageScrollController,
        child: Container(
          padding: EdgeInsets.only(
            top: isTablet ? 60 : 30,
            left: isTablet ? 60 : 30,
            right: isTablet ? 60 : 30,
            bottom: isTablet ? 120 : 60,
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UsageTextButton(
                text: "新規リスト登録",
                onPressed: () => scrollToTarget(firstKey),
                isTablet: isTablet,
              ),
              _UsageTextButton(
                text: "リスト編集、並び替え、削除",
                onPressed: () => scrollToTarget(secondKey),
                isTablet: isTablet,
              ),
              _UsageTextButton(
                text: "記事登録、URLを開く方法",
                onPressed: () => scrollToTarget(thirdKey),
                isTablet: isTablet,
              ),
              _UsageTextButton(
                text: "記事編集、削除",
                onPressed: () => scrollToTarget(fourthKey),
                isTablet: isTablet,
              ),
              _UsageTextButton(
                text: "メモ登録",
                onPressed: () => scrollToTarget(fifthKey),
                isTablet: isTablet,
              ),
              _UsageTextButton(
                text: "メモ編集、削除",
                onPressed: () => scrollToTarget(sixthKey),
                isTablet: isTablet,
              ),
              _UsageTextButton(
                text: "テーマカラー変更",
                onPressed: () => scrollToTarget(seventhKey),
                isTablet: isTablet,
              ),
              SizedBox(height: isTablet ? 60 : 30),
              UsageItem(
                key: firstKey,
                title: "新規リスト登録",
                body: "リストタブの「+」ボタンを押すと\n新規リスト登録ができます。",
                imagePath: "assets/images/walk_through_one.jpg",
              ),
              UsageItem(
                key: secondKey,
                title: "リスト編集、並び替え、削除",
                body:
                    "マイページタブの「リスト編集」を開くと、\nリスト名の編集や削除を行えます。\n\nリストを長押しすると順番の入れ替えが可能です。\n\n「削除」をタップすることで削除が可能です。",
                imagePath: "assets/images/edit_tag.jpg",
              ),
              UsageItem(
                key: thirdKey,
                title: "記事登録、URLを開く方法",
                body:
                    "ホームタブで記事ページの「＋」ボタンをタップすると\n記事登録を行えるページに移動します。\n\nタイトルとURLは必須項目です。\n\n記事登録時に新規リストを追加することも可能です。\n\nまた、登録した記事をタップすると、\nURLに設定したサイトが開きます。",
                imagePath: "assets/images/walk_through_two.jpg",
              ),
              UsageItem(
                key: fourthKey,
                title: "記事編集、削除",
                body:
                    "登録した記事を長押しすると、\n記事の編集や削除ができます。\n\n編集では、タイトル変更や登録しているリストの変更が可能です。\n\n「削除」をタップすることで削除が可能です。",
                imagePath: "assets/images/walk_through_four.jpg",
              ),
              UsageItem(
                key: fifthKey,
                title: "メモ登録",
                body: "メモタブを開き「＋」ボタンをタップすると、\nメモ登録が行えます。",
                imagePath: "assets/images/register_memo.jpg",
              ),
              UsageItem(
                key: sixthKey,
                title: "メモ編集、削除",
                body:
                    "登録したメモをタップして開くとメモ詳細が表示され、\n直接編集することができます。\n\n「削除」をタップすることで削除が可能です。",
                imagePath: "assets/images/edit_memo.jpg",
              ),
              UsageItem(
                key: seventhKey,
                title: "テーマカラー変更",
                body:
                    "マイページタブの「テーマカラー変更」を開くと、\nカラー変更パレットが表示されます。\n\nテキストカラー、ボタンカラー、アイコンカラーを\n一括で変更できます。\n\n＊個別のカラー変更はできません。",
                imagePath: "assets/images/walk_through_five.jpg",
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsageTextButton extends StatelessWidget {
  const _UsageTextButton({
    required this.text,
    required this.onPressed,
    required this.isTablet,
    Key? key,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: GestureDetector(
            onTap: onPressed,
            child: Text(
              text,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: isTablet
                    ? ThemeFontSize.tabletNormalFontSize
                    : ThemeFontSize.normalFontSize,
              ),
            ),
          ),
        ),
        SizedBox(height: isTablet ? 20 : 10),
      ],
    );
  }
}
