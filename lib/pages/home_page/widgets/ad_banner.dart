import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({Key? key}) : super(key: key);

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) => 
            SizedBox(
              height: controller.bottomBannerAd.size.height.toDouble(),
              width: controller.bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: controller.bottomBannerAd),
            ));
  }
}