import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/theme/color.dart';

class PrivacyPolicyPage extends HookConsumerWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final isFromAuthPage = ModalRoute.of(context)?.settings.arguments as bool;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "プライバシーポリシー",
          style: TextStyle(
            color: isFromAuthPage ? ThemeColor.orange : colorState.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ThemeColor.darkGray,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              PrivacyPolicyComponent(
                title: "1. はじめに",
                content:
                    "この利用規約（以下、「本規約」といいます。）は、本アプリの利用に関する条件を定めるものです。本アプリを利用される場合は、本規約に同意されたものとみなします。",
              ),
              SizedBox(height: 20),
              PrivacyPolicyComponent(
                title: "2. アカウント登録について",
                content:
                    "本アプリの機能を利用するためには、Google、Apple、メールアドレスのうち、いずれかのアカウント登録が必要です。アカウント登録にあたっては、正確かつ最新の情報を提供していただくようお願いします。また、アカウントの管理は、利用者自身の責任となります。",
              ),
              SizedBox(height: 20),
              PrivacyPolicyComponent(
                title: "3. プライバシーについて",
                content:
                    "本アプリは、利用者の個人情報を適切に取り扱います。取得した情報は、ログイン認証のためにのみ使用し、第三者に提供することはありません。詳細については、別途定めるプライバシーポリシーに従って取り扱います。",
              ),
              SizedBox(height: 20),
              PrivacyPolicyComponent(
                title: "4. 禁止事項",
                content:
                    "本アプリの利用にあたり、以下の行為は禁止されます。\n\n・法令や公序良俗に反する行為\n・本アプリの運営や他の利用者に損害を与える行為\n・本アプリの利用者でない者によるアカウントの利用\n・本アプリによって取得した情報の商用利用\n・その他、本アプリの運営に支障をきたすおそれのある行為",
              ),
              SizedBox(height: 20),
              PrivacyPolicyComponent(
                title: "5. 免責事項",
                content:
                    "本アプリは、本アプリの利用により発生した損害について一切の責任を負いません。また、本規約の変更については、事前に利用者への通知なしに行うことがあります。",
              ),
              SizedBox(height: 20),
              PrivacyPolicyComponent(
                title: "6. 広告について",
                content: "本アプリは、広告を掲出する場合があります。広告掲載に関する事項は、別途定める広告ポリシーに従います。",
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyComponent extends StatelessWidget {
  const PrivacyPolicyComponent({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          content,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
