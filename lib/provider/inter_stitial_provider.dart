import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/config.dart';

class InterstitialAdProvider extends StateNotifier<void> {
  InterstitialAdProvider() : super(null);
  InterstitialAd? interstitialAd;

  final adUnitId = Platform.isAndroid
      ? Config.app.androidInterStitialAdID
      : Config.app.iosInterStitialAdID;

  /// Loads an interstitial ad.
  Future<void> loadAd() async {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {});

          debugPrint('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          interstitialAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  Future<void> showAd() async {
    interstitialAd?.show();
  }
}

final interStitialAdProvider =
    StateNotifierProvider<InterstitialAdProvider, void>((ref) {
  return InterstitialAdProvider();
});
