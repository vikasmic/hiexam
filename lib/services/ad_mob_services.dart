import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get banenrAdUnitId {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-3940256099942544/9214589741';
      return 'ca-app-pub-2349780228883411/7566251016';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2349780228883411/5791131427';
      // return 'ca-app-pub-1140443868367054/4837002782';
    }
    return null;
  }

  static String? get interstitialAdUnit {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2349780228883411/6030937367';
      // return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2349780228883411/3015443206';
      // return 'ca-app-pub-1140443868367054/2016194487';
    }
    return null;
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad Loaded.'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    },
    onAdOpened: (ad) => debugPrint('Ad Opened'),
    onAdClosed: (ad) => debugPrint('Ad Closed'),
  );
}
