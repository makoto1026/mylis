import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mylis/config.dart';

String getBannerID() {
  if (Platform.isAndroid) {
    return Config.app.androidBannerID;
  } else if (Platform.isIOS) {
    return Config.app.iosBannerID;
  }

  return "";
}

BannerAd setBanner() {
  final myBanner = BannerAd(
    adUnitId: getBannerID(),
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  myBanner.load();

  return myBanner;
}
