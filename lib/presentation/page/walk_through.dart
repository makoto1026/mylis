import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/infrastructure/secure_storage_service.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';

class WalkThroughPage extends HookConsumerWidget {
  const WalkThroughPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = useState(0);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 500,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) =>
                    currentPageIndex.value = index,
              ),
              items: const <Widget>[
                _WalkThroughTop(),
                _WalkThroughContent(
                  assetName: "walk_through_one.jpg",
                  title: "新しいリストを作成しよう！",
                  body: "まとめたいジャンルを登録して、\n自分だけのリストを作成していこう！",
                  supplement: "※マイページの「リスト編集」でリスト名や順番を変更できます",
                ),
                _WalkThroughContent(
                  assetName: "walk_through_two.jpg",
                  title: "お気に入り記事を登録しよう！",
                  body: "リストを作成したら、\n+ ボタンから記事を登録しよう！\n登録した記事をタップするとページが開ける！",
                ),
                _WalkThroughContent(
                  assetName: "walk_through_three.jpg",
                  title: "シェア受け取り機能を使って簡単登録！",
                  body: "webページやInstagram、Twitter\nなどのSNSから記事をシェアして、簡単登録！",
                ),
                _WalkThroughContent(
                  assetName: "walk_through_four.jpg",
                  title: "登録した記事を編集したい！",
                  body: "記事を長押しすると、記事を削除したり\nタイトルの編集などができる！",
                ),
                _WalkThroughContent(
                  assetName: "walk_through_five.jpg",
                  title: "アプリを自分好みのカラーに！",
                  body: "マイページの「テーマカラー変更」で、\nアプリを自分好みのカラーに変更しよう！",
                )
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPageIndex.value == index
                            ? ThemeColor.orange
                            : ThemeColor.orange.withOpacity(0.3),
                      ),
                    ),
                  ).toList(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 215,
                  height: 52,
                  child: RoundRectButton(
                    isAuth: true,
                    onPressed: () {
                      ref
                          .read(secureStorageServiceProvider)
                          .write(key: "isFirstOpen", value: "false");

                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.main.path,
                        (route) => false,
                      );
                    },
                    text: "はじめる",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _WalkThroughTop extends StatelessWidget {
  const _WalkThroughTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "mylisの\n使い方とポイント",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ThemeColor.orange,
          height: 1.3,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _WalkThroughContent extends StatelessWidget {
  const _WalkThroughContent({
    required this.assetName,
    required this.title,
    required this.body,
    this.supplement = "",
    Key? key,
  }) : super(key: key);
  final String assetName;
  final String title;
  final String body;
  final String supplement;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
              "assets/images/$assetName",
              width: 300,
              height: 300,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ThemeColor.orange,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          body,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ThemeColor.darkGray,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          supplement,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: ThemeColor.darkGray,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
