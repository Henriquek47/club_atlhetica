import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/database/shared_pref.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:club_atlhetica/layers/use_cases/team_winner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final http.Client client;
  final IRepository repository;
  final SharedPrefe _pref = SharedPrefe();
  RxBool darkBool = false.obs;
  RxInt screen = 0.obs;
  var roundAll = <Round>[].obs;
  var roundNext = <Round>[].obs;

  HomeController({required this.client, required this.repository});

  @override
  void onInit()async{
    await _pref.initSharedPrefe();
    await initRepository().whenComplete(()async{
      await nextRound();
      await getAllRound();
    });
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

  Future<List> statisticsTeam()async{
    TeamWinner winner = TeamWinner(repository);
    return await winner.execute();
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

  @override
  void onClose() {
    super.onClose();
  }
}