// import 'package:flutter/material.dart';
// import 'package:flutter_app_mj/admob/ad_helper.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdMob {
//   BannerAd? _bannerAd;
//   AdMob() {
//     _bannerAd = BannerAd(
//         size: AdSize.banner,
//         adUnitId: AdHelper.bannerAdUnitId,
//         listener: BannerAdListener(
//           onAdFailedToLoad: (Ad ad, LoadAdError error) {
//             ad.dispose();
//           },
//         ),
//         request: const AdRequest());
//   }

//   void load() {
//     _bannerAd!.load();
//   }

//   void dispose() {
//     _bannerAd!.dispose();
//   }

//   // when getting admod success
//   Widget getAdBanner() {
//     return Container(
//       alignment: Alignment.center,
//       width: _bannerAd!.size.width.toDouble(),
//       height: _bannerAd!.size.height.toDouble(),
//       child: AdWidget(ad: _bannerAd!),
//     );
//   }

//   // when getting admod fail
//   double getAdBannerHeight() {
//     return _bannerAd!.size.height.toDouble();
//   }
// }
