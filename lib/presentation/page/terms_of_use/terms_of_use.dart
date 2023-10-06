import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class TermsOfUsePage extends HookConsumerWidget {
  const TermsOfUsePage({
    required this.isFromAuthPage,
    Key? key,
  }) : super(key: key);

  final bool isFromAuthPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final isTablet = ref.watch(isTabletProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "利用規約",
          style: TextStyle(
            color: isFromAuthPage ? ThemeColor.orange : colorState.textColor,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          isTablet ? 60 : 30,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "当アプリケーションは、利用者の情報を大切にし、利用者の個人情報を保護することを重視しています。",
                style: TextStyle(
                  fontSize: isTablet
                      ? ThemeFontSize.tabletSmallFontSize
                      : ThemeFontSize.smallFontSize,
                ),
              ),
              SizedBox(height: isTablet ? 40 : 20),
              TermsOfUseComponent(
                title: "1. 収集する情報",
                content:
                    "当アプリケーションは、お気に入りの記事を登録するための情報を収集します。この情報には、記事のタイトル、URL、メモ、および登録日時が含まれます。また、利用者がログインした際に収集されるログイン情報にはGoogle、Apple、メールアドレスがあります。",
                isTablet: isTablet,
              ),
              SizedBox(height: isTablet ? 40 : 20),
              TermsOfUseComponent(
                title: "2. 利用目的",
                content:
                    "当アプリケーションは、収集された情報を、お気に入りの記事を登録するために利用します。また、ログイン情報は、アプリケーションの認証に使用します。",
                isTablet: isTablet,
              ),
              SizedBox(height: isTablet ? 40 : 20),
              TermsOfUseComponent(
                title: "3. 個人情報の管理",
                content:
                    "当アプリケーションは、利用者の個人情報を適切に管理し、情報漏洩、紛失、不正アクセス、改ざん等の予防措置を講じます。個人情報は、アプリケーションの認証以外の目的で使用されることはありません。",
                isTablet: isTablet,
              ),
              SizedBox(height: isTablet ? 40 : 20),
              TermsOfUseComponent(
                title: "4. 広告",
                content:
                    "当アプリケーションは、広告を掲載する場合があります。当社は、広告配信サービス事業者が提供する広告配信サービスを利用しており、Cookie等を使用して利用者の情報を収集する場合があります。利用者が広告配信サービス事業者のWebサイトを閲覧した場合、Cookie等により利用者の情報が収集されることがあります。利用者は、広告配信サービス事業者のWebサイトにアクセスすることで、広告配信サービス事業者によるCookie等の利用に関する情報を確認することができます。",
                isTablet: isTablet,
              ),
              SizedBox(height: isTablet ? 40 : 20),
              TermsOfUseComponent(
                title: "5. 第三者への提供",
                content: "当アプリケーションは、利用者の個人情報を、法律に基づく場合を除き、第三者に提供することはありません。",
                isTablet: isTablet,
              ),
              SizedBox(height: isTablet ? 40 : 20),
              TermsOfUseComponent(
                title: "6. お問い合わせ先",
                content: "当アプリケーションに関するお問い合わせは、アプリケーション内のお問い合わせフォームからお願いいたします。",
                isTablet: isTablet,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TermsOfUseComponent extends StatelessWidget {
  const TermsOfUseComponent({
    required this.title,
    required this.content,
    required this.isTablet,
    Key? key,
  }) : super(key: key);
  final String title;
  final String content;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: isTablet ? 10 : 5),
        Text(
          content,
          style: TextStyle(
            fontSize: isTablet
                ? ThemeFontSize.tabletSmallFontSize
                : ThemeFontSize.smallFontSize,
          ),
        ),
      ],
    );
  }
}
