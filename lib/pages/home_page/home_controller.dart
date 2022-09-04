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
  final SharedPrefe pref = SharedPrefe();
  RxBool darkBool = false.obs;
  var roundAll = <Round>[].obs;
  var roundNext = <Round>[].obs;

  HomeController({required this.client, required this.repository});

  @override
  void onInit()async{
    await pref.initSharedPrefe();
    await initRepository().whenComplete(()async{
      await nextRound();
      await getAllRound();
    });
    super.onInit();
  }

  @override
  void onReady()async{
    await darkMode(pref.darkMode);
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
    await pref.setData(darkBool);
    this.darkBool.value = pref.darkMode;
    Get.changeThemeMode(
      pref.darkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}