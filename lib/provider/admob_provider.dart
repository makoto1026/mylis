import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/config.dart';

final homeBannerAdProvider = Provider.autoDispose<AdWithView>(
  (ref) {
    var bannerID = "";

    if (Platform.isAndroid) {
      bannerID = Config.app.androidBannerID;
    } else if (Platform.isIOS) {
      bannerID = Config.app.iosBannerID;
    }

    final bannerAd = BannerAd(
      adUnitId: bannerID,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    bannerAd.load();
    ref.onDispose(
      () {
        bannerAd.dispose();
      },
    );
    return bannerAd;
  },
);

final memoBannerAdProvider = Provider.autoDispose<AdWithView>(
  (ref) {
    var bannerID = "";

    if (Platform.isAndroid) {
      bannerID = Config.app.androidBannerID;
    } else if (Platform.isIOS) {
      bannerID = Config.app.iosBannerID;
    }

    final bannerAd = BannerAd(
      adUnitId: bannerID,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    bannerAd.load();
    ref.onDispose(
      () {
        bannerAd.dispose();
      },
    );
    return bannerAd;
  },
);

final mypageBannerAdProvider = Provider.autoDispose<AdWithView>(
  (ref) {
    var bannerID = "";

    if (Platform.isAndroid) {
      bannerID = Config.app.androidBannerID;
    } else if (Platform.isIOS) {
      bannerID = Config.app.iosBannerID;
    }

    final bannerAd = BannerAd(
      adUnitId: bannerID,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    bannerAd.load();
    ref.onDispose(
      () {
        bannerAd.dispose();
      },
    );
    return bannerAd;
  },
);
