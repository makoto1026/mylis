import 'package:flutter_svg/svg.dart';
import 'package:mylis/theme/color.dart';

class SetArticleIcon {
  static SvgPicture set(String url) {
    var iconPath = "";

    if (url.contains("instagram")) {
      iconPath = "assets/icons/instagram.svg";
    } else if (url.contains("twitter")) {
      iconPath = "assets/icons/twitter.svg";
    } else if (url.contains("tiktok")) {
      iconPath = "assets/icons/tiktok.svg";
    } else if (url.contains("youtube")) {
      iconPath = "assets/icons/toutube.svg";
    } else if (url.contains("facebook")) {
      iconPath = "assets/icons/facebook.svg";
    } else {
      iconPath = "assets/icons/like.svg";
    }

    return SvgPicture.asset(
      iconPath,
      width: 34,
      height: 34,
      color: ThemeColor.black,
    );
  }
}
