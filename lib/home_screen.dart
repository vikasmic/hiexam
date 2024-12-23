import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'services/ad_mob_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();

    // Initialize and load the banner ad
    _bannerAd = BannerAd(
      adUnitId: AdMobService.banenrAdUnitId ?? '',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: AdMobService.bannerListener,
    )..load();

    // Load the interstitial ad
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnit ?? '',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _loadInterstitialAd(); // Reload the ad after it's dismissed
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              debugPrint('Interstitial ad failed to show: $error');
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      debugPrint('Interstitial ad not ready.');
    }
  }

  @override
  void dispose() {
    // Dispose of the banner ad and interstitial ad
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome to the Home Screen!'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showInterstitialAd,
            child: const Text('Show Interstitial Ad'),
          ),
          const SizedBox(height: 20),
          if (_bannerAd != null)
            Container(
              alignment: Alignment.center,
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
    );
  }
}
