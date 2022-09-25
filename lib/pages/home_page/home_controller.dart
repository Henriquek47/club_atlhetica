import 'dart:io';

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
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
  

  HomeController({required this.client, required this.repository});

  @override
  void onInit()async{
    await _pref.initSharedPrefe();
    await initRepository().whenComplete(()async{
      await getAllRound();
      await nextRound();
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

  Future<List> winner()async{
    TeamWinner winner = TeamWinner(repository);
    return await winner.execute();
  }

  Future<Map> statisticTeam(int idHome, int idAway, )async{
    statistic = {}.obs;
    TeamWinner winner = TeamWinner(repository);
    Map list = await winner.getStatisticTeam(idHome, idAway);
    print(list);
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

  @override
  void onClose() {
    super.onClose();
  }
}