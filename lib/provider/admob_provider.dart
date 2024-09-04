import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/config.dart';

final bannerAdID = Platform.isAndroid
    ? Config.app.androidBannerAdID
    : Config.app.iosBannerAdID;

final homeBannerAdProvider = Provider.autoDispose<AdWithView>(
  (ref) {
    final bannerAd = BannerAd(
      adUnitId: bannerAdID,
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
    final bannerAd = BannerAd(
      adUnitId: bannerAdID,
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
    final bannerAd = BannerAd(
      adUnitId: bannerAdID,
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

final searchPageBannerAdProvider = Provider.autoDispose<AdWithView>(
  (ref) {
    final bannerAd = BannerAd(
      adUnitId: bannerAdID,
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
