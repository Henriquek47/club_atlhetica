import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
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
  var statisticHome = [].obs;
  var statisticAway = [].obs;
  RxInt timer = 0.obs;
  RxBool details = false.obs;
  RxInt index = 0.obs;
  RxString imageHome = RxString('');
  RxInt select = 0.obs;
  RxBool isBottomBannerAdLoaded = false.obs;
  RxBool isPremiumAdLoaded = false.obs;
  late BannerAd bottomBannerAd;
  RewardedAd? rewardedAd;
  int indexBanner = 3;
  int idLeagueActual = 1;
  int idLeagueDefault = 1;
  

  HomeController({required this.client, required this.repository});

  @override
  void onInit()async{
    await _pref.initSharedPrefe();
    await initRepository().whenComplete(()async{
      await getAllRound(idLeagueDefault);
      await nextRound(idLeagueDefault);
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

  Future<String> winner(int idHome, int idAway, String nameHome, String nameAway, int fixture)async{
    TeamWinner winner = TeamWinner(repository);
    return await winner.execute(idHome, idAway, nameHome, nameAway, fixture, idLeagueActual);
  }

  Future<RxList> statisticTeamHome(int idHome)async{
    TeamWinner winner = TeamWinner(repository);
    TeamStatistic list = await winner.sumDataHome(idHome);
    statisticHome.addAll([list.goalsHome, list.statisticHome!.shotsOnGoal!,
    list.statisticHome!.goalkeeperSaves!, list.statisticHome!.ballPossession!,
    list.statisticHome!.cornerKicks!,list.statisticHome!.fouls!,
    list.statisticHome!.yellowCards!,list.statisticHome!.redCards!,
    ]);
    return statisticHome;
  }

  Future<RxList> statisticTeamAway(int idAway)async{
    TeamWinner winner = TeamWinner(repository);
    TeamStatistic list = await winner.sumDataAway(idAway);
     statisticAway.addAll([list.goalsAway, list.statisticAway!.shotsOnGoal!,
    list.statisticAway!.goalkeeperSaves!, list.statisticAway!.ballPossession!,
    list.statisticAway!.cornerKicks!,list.statisticAway!.fouls!,
    list.statisticAway!.yellowCards!,list.statisticAway!.redCards!,
    ]);
    return statisticAway;
  }

  Future<List<Round>> nextRound(int idLeague) async {
    GetRound getRoundVar = GetRound(repository: repository);
    List<Round> round = await getRoundVar.nextRounds(idLeague);
    roundNext.assignAll(round);
    return roundNext;
  }

  Future<List<Round>> getAllRound(int idLeague) async {
    GetRound getRoundVar = GetRound(repository: repository);
    List<Round> round = await getRoundVar.beforeRounds(idLeague);
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

  void showRewardedAd(int idHome, int idAway, String nameHome, String nameAway, int fixture){
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
      rewardedAd!.show(onUserEarnedReward: (ad, reward)async{
        await winner(idHome, idAway, nameHome, nameAway, fixture);
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