import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> openUrl({
  required String url,
}) async {
  await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}

Future<void> openMailApp() async {
  final title = Uri.encodeComponent('');
  final body = Uri.encodeComponent('問題のある投稿のスクリーンショットとリンクを添付してください。');
  const mailAddress = 'sg.enquiry@kao.com';
  await launchUrlString('mailto:$mailAddress?subject=$title&body=$body');
}
