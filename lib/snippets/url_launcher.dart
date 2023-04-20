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
  final title = Uri.encodeComponent("mylisお問い合わせ");
  final body = Uri.encodeComponent("");
  const mailAddress = 'mylis.app.info@gmail.com';
  await launchUrlString('mailto:$mailAddress?subject=$title&body=$body');
}
