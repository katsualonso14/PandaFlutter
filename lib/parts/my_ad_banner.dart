import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyAdBanner extends HookWidget {
  const MyAdBanner({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {

    final bannerAd = useState<BannerAd?>(null);
    var isAdLoaded = useState(false); // 広告の読み込み状態
    // ios, android で切り替え
    String bannerId = 'ca-app-pub-5743090122530738/3182678099';

    // ad load
    void loadAd(){
      final ad = BannerAd(
        adUnitId: bannerId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            isAdLoaded.value = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('ad failed to load: $error');
            ad.dispose();
          },
        ),
      );
      ad.load();
      bannerAd.value = ad;
    }

    useEffect((){
      loadAd();
      return () {
        bannerAd.value?.dispose();
      };
    }, []);

    return isAdLoaded.value && bannerAd.value != null
        ? SizedBox(
          width: bannerAd.value!.size.width.toDouble(),
          height: bannerAd.value!.size.height.toDouble(),
          child: AdWidget(ad: bannerAd.value!),
        )
        : const SizedBox(
          width: 320,
          height: 50,
    );
  }
}


