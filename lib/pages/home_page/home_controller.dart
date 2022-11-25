import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/ads/ad_helper.dart';
import 'package:club_atlhetica/layers/service/database/shared_pref.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:club_atlhetica/layers/use_cases/team_winner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final http.Client client;
  final IRepository repository;
  final SharedPrefe _pref = SharedPrefe();
  RxBool darkBool = false.obs;
  RxInt screen = 0.obs;
  RxBool expanded = false.obs;
  var roundAll = <Round>[].obs;
  var roundNext = <Round>[].obs;
  var statistic = {}.obs;
  RxInt timer = 0.obs;
  RxBool details = false.obs;
  RxInt index = 0.obs;
  RxString imageHome = RxString('');
  RxInt posLeague = 0.obs;
  RxInt select = 0.obs;
  RxBool isBottomBannerAdLoaded = false.obs;
  RxBool isPremiumAdLoaded = false.obs;
  late BannerAd bottomBannerAd;
  RewardedAd? rewardedAd;
  int indexBanner = 3;
  

  HomeController({required this.client, required this.repository});

  @override
  void onInit()async{
    await _pref.initSharedPrefe();
    await initRepository().whenComplete(()async{
      await getAllRound();
      await nextRound();
    });
    createBottomPremium();
    super.onInit();
  }

  @override
  void onReady()async{
    await darkMode(_pref.darkMode);
    await setScreen(_pref.screen);
    super.onReady();
  }

  Future initRepository()async{
    await repository.initRepository();
  }

  Future<List> winner()async{
    TeamWinner winner = TeamWinner(repository);
    return await winner.execute();
  }

  Future<Map> statisticTeam(int idHome, int idAway, )async{
    statistic = {}.obs;
    TeamWinner winner = TeamWinner(repository);
    Map list = await winner.getStatisticTeam(idHome, idAway);
    statistic.assignAll(list);
    return statistic;
  }

  Future<List<Round>> nextRound() async {
    GetRound getRoundVar = GetRound(repository: repository);
    List<Round> round = await getRoundVar.nextRounds();
    roundNext.assignAll(round);
    return roundNext;
  }

  Future<List<Round>> getAllRound() async {
    GetRound getRoundVar = GetRound(repository: repository);
    List<Round> round = await getRoundVar.beforeRounds();
    roundAll.assignAll(round);
    return roundAll;
  }
  
  darkMode(bool darkBool)async{
    await _pref.setDarkMode(darkBool);
    this.darkBool.value = _pref.darkMode;
    Get.changeThemeMode(
      _pref.darkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }

  setScreen(int id)async{
   await _pref.setScreen(id);
   screen.value = _pref.screen; 
  }

  timerLoad(){
    Future.delayed(const Duration(seconds: 15),() => timer.value = 1,);
  }

  getIndex(int index){
    this.index.value = index;
  }

void createBottomBannerAd() {
    bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
            isBottomBannerAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    bottomBannerAd.load();
  }

  void createBottomPremium() {
    RewardedAd.load(
      request: const AdRequest(),
      adUnitId: AdHelper.premiumId,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (RewardedAd ad) {
        print('$ad loaded.');
        // Keep a reference to the ad so you can show it later.
        rewardedAd = ad;
        isPremiumAdLoaded.value = true;
      },
      onAdFailedToLoad: (LoadAdError error) {
        print('RewardedAd failed to load: $error');
        rewardedAd = null;
        isPremiumAdLoaded.value = false;
      },
    ));
  }

  void showRewardedAd(){
    if(rewardedAd != null){
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          print('Ad onAdShowedFullScreenContent');
        },
        onAdDismissedFullScreenContent: (ad){
          ad.dispose();
          isPremiumAdLoaded.value = false;
          createBottomPremium();
        },
        onAdFailedToShowFullScreenContent: (ad, err){
          ad.dispose();
          isPremiumAdLoaded.value = false;
          createBottomPremium();
        }
      );
      rewardedAd!.setImmersiveMode(true);
      rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        print('recompensaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      },);
    }
  }

  @override
  void onClose() {
    super.onClose();
    bottomBannerAd.dispose();
    rewardedAd?.dispose();
  }
}