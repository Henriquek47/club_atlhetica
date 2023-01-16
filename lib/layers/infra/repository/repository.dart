import 'dart:convert';
import 'dart:math';

import 'package:clock/clock.dart';
import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/adapter/round_adapter.dart';
import 'package:club_atlhetica/layers/infra/adapter/team_adapter.dart';
import 'package:club_atlhetica/layers/infra/datadource/round_datasource.dart';
import 'package:club_atlhetica/layers/service/database/db.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../entities/team.dart';
import '../datadource/team_datasource.dart';

abstract class IRepository {
  Future<List<TeamStatistic>> getStatisticTeamHome(int idTeamHome);
  Future<List<TeamStatistic>> getStatisticTeamAway(int idTeamAway);
  Future<List<Round>> getRounds(int idLeague);
  Future<void> updateData(
      int idLeague, String winner, int fixture);
  initRepository();
  int posLeague = 0;
}

class Repository extends IRepository {
  late TeamDataSource teamDataSource;
  late RoundDataSource roundDataSource;
  Database? db;
  List idsLeagues = [475,2,71,73];
  List season = [2023, 2022, 2023, 2023];
  List roundTeamLastHome = [];
  List roundTeamLastAway = [];
  bool update = false;

  Repository(
      {required this.teamDataSource, required this.roundDataSource, this.db});

  @override
  Future<List<TeamStatistic>> getStatisticTeamHome(int idTeamHome) async {
    roundTeamLastHome = [];
    try {
      Map teamRoundHome = await teamDataSource.last10RoundsTeam(idTeamHome);
      for (var i = 0; i < (teamRoundHome['response'] as List).length -1; i++) {
        roundTeamLastHome.add(teamRoundHome['response'][i]['fixture']['id']);
      }
      Map home =
          await teamDataSource.statisticRound(roundTeamLastHome.join('-'));
      List<TeamStatistic> homeStatistic = (home['response'] as List)
          .map((e) => TeamAdapter.fromJsonStatistic(e))
          .toList();
      return homeStatistic;
    } catch (e) {
      print('homeeeeeeeeeeee');
      return [];
    }
  }

  @override
  Future<List<TeamStatistic>> getStatisticTeamAway(int idTeamAway) async {
    roundTeamLastAway.clear();
    try {
      Map teamRoundAway = await teamDataSource.last10RoundsTeam(idTeamAway);
      for (var i = 0; i < (teamRoundAway['response'] as List).length -1; i++) {
        roundTeamLastAway.add(teamRoundAway['response'][i]['fixture']['id']);
      }
      print(roundTeamLastAway.join('-'));
      Map away =
          await teamDataSource.statisticRound(roundTeamLastAway.join('-'));
      List<TeamStatistic> awayStatistic = (away['response'] as List)
          .map((e) => TeamAdapter.fromJsonStatistic(e))
          .toList();
      return awayStatistic;
    } catch (e) {
      print('awayaaaaaaaaaaaaa');
      return [];
    }
  }

  @override
  Future<List<Round>> getRounds(int idLeague) async {
    db = await DB.instance.database;
    List rounds = await db!.query('round', where: 'idLeague = $idLeague', columns: ['response']);
    
    if (rounds.isEmpty) {
      return [];
    } else {
      String response = await rounds.first['response'];
      var body = jsonDecode(response);
      List res = body['response'];
      List<Round> listRounds =
          res.map((e) => RoundAdapter.fromJson(e)).toList();
          for (var element in listRounds) {
            if(element.goalsHome == null && !DateTime.parse(element.date!).hour.isEqual(00) && (DateTime.parse(element.date!).isBefore(DateTime.now()))){
              return [];
            }
          }
      return listRounds;
    }
  }

  @override
  initRepository() async {
    try {
    db = await DB.instance.database;
    List rounds = await db!.query('round');
      if (rounds.isEmpty) {
        for (int i = 0; i < idsLeagues.length; i++) {
      final response = await roundDataSource.getApi(idsLeagues[i], season[i]);
      var response2 = response;
      var body = jsonDecode(response);
      print(body);
        print('INIT REPOSITORY SQLLLL');
        await db!.insert('round', {
          'idLeague': idsLeagues[i],
          'response': response,
          'month': dateTime.month,
          'day': dateTime.day
        });
        }
      } else{
        for (int i = 0; i < idsLeagues.length; i++) {
        final response = await roundDataSource.getApi(idsLeagues[i], season[i]);
        print('INIT REPOSITORY SQLLLL 222222222');
        await db!.update('round', {
          'response': response,
          'month': dateTime.month,
          'day': dateTime.day
        }, where: 'idLeague = ${idsLeagues[i]}');
        }
      }
    rounds = await db!.query('round');
    } catch (e) {
      Get.rawSnackbar(title:'Erro na conexão', message: 'Erro na conexão', backgroundColor: Colors.red);
    }
  }

  @override
  Future<void> updateData(int idLeague, String winner, int fixture)async{
      db = await DB.instance.database;
    List rounds = await db!.query('round', where: 'idLeague = $idLeague', columns: ['response']);
      String response = await rounds.first['response'];
      var body = jsonDecode(response);
      for (var i = 0; i < (body['response'] as List).length; i++) {
        if(body['response'][i]['fixture']['id'] == fixture){
          body['response'][i]['fixture']['winner'] = winner;
          body['response'][i]['fixture']['notification'] = true;
          await db!.update('round', {'response': jsonEncode(body)}, where: 'idLeague = $idLeague');
        }
      }
      rounds = await db!.query('round', where: 'idLeague = $idLeague', columns: ['response']);
  }
}

/*class Repository extends IRepository{
  TeamDataSource? teamDataSource;
  RoundDataSource? roundDataSource;
  Database? db;
  List roundTeamLastHome = [];
  List roundTeamLastAway = [];
  List idsLeagues = [71, 2, 73, 1];

  Repository({this.teamDataSource, this.roundDataSource, this.db});

  get10lastRound(int? idTeamHome, int? idTeamAway)async{
  roundTeamLastHome = [];
  roundTeamLastAway = [];
  for(int i=0; i<2; i++){
    if(i==0){
      Map teamRoundHome = await teamDataSource!.last10RoundsTeam(idTeamHome);
      for (var i = 0; i < (teamRoundHome['response'] as List).length; i++) {
      roundTeamLastHome.add(teamRoundHome['response'][i]['fixture']['id']);
      }
    }else if(i==1){
      Map teamRoundAway = await teamDataSource!.last10RoundsTeam(idTeamAway);
      for (var i = 0; i < (teamRoundAway['response'] as List).length; i++) {
      roundTeamLastAway.add(teamRoundAway['response'][i]['fixture']['id']);
      }
    }
  }
  }
  
  @override
  getStatisticTeam(int? idTeamHome, int? idTeamAway)async{
    await get10lastRound(idTeamHome, idTeamAway);
    Map home = await teamDataSource!.statisticRound(roundTeamLastHome.join('-'));
    Map away = await teamDataSource!.statisticRound(roundTeamLastAway.join('-'));
    print(roundTeamLastHome.join('-'));
    List<TeamStatistic> homeStatistic = (home['response'] as List).map((e) => TeamAdapter.fromJsonStatistic(e)).toList();
    List<TeamStatistic> awayStatistic = (away['response'] as List).map((e) => TeamAdapter.fromJsonStatistic(e)).toList();
    Map<String, List<TeamStatistic>> response = {
      'home': homeStatistic,
      'away': awayStatistic
    };
    return response;
  }
  
   @override
  Future<List<Round>> getRounds()async{
    db = await DB.instance.database;
    List rounds = await db!.query('round');
    List list = [];
    for (var i = 1; i < (idsLeagues.length + 1); i++) {
      String response = await rounds[i-1]['response'];
      var body = jsonDecode(response);
      list = body['response'];
      Map? newBody;
      if(body['response'][0]['fixture']['notification'] == null || body['response'][0]['fixture']['winner'] == null){
        for (int k = 0; k<list.length; k++) {
          body['response'][k]['fixture']['notification'] = false;
          body['response'][k]['fixture']['winner'] = 'Analisando';
          newBody = body;
        }
      await db!.update('round', {'response': jsonEncode(newBody)}, where: 'id = $i');
    }
    }
    rounds = await db!.query('round');
    String response = await rounds[posLeague]['response'];
    var body = jsonDecode(response);
    List roundsList = body['response'];
    List<Round> listRounds = roundsList.map((e) => RoundAdapter.fromJson(e)).toList();
    return listRounds;
  }
  
  @override
  Future<List<Round>> updateData(int index, String winner, int fixture, int pos)async{
    db = await DB.instance.database;
    List rounds = await db!.query('round');
    String response = await rounds[posLeague]['response'];
    final body = jsonDecode(response);
    if(rounds.isEmpty || body['response'][1]['fixture']['notification'] == null || body['response'][1]['fixture']['winner'] == null){
      return await getRounds();
    }else{
      List list = body['response'];
      body['response'][index]['fixture']['notification'] = true;
      body['response'][index]['fixture']['winner'] = winner;
      await db!.insert('team', {'winner': winner, 'fixture': fixture});
      await db!.update('round', {'response': jsonEncode(body)}, where: "id = $pos");
      rounds = await db!.query('round');
      List<Round> listRounds = list.map((e) => RoundAdapter.fromJson(e)).toList();
      return listRounds;
   }
  }
  
  @override
  initRepository()async{
    db = await DB.instance.database;
    List rounds = await db!.query('round');
    if(rounds.isEmpty || rounds.first['day'] == null || DateTime.utc(dateTime.year, rounds[posLeague]['month'], rounds[posLeague]['day'] + 2,).isBefore(DateTime.now())){
        print("AQUI");
        for (var i = 1; i < (idsLeagues.length + 1); i++) {
          int idLeague = 0;
          i == 1 ? idLeague = 71 : i == 2 ? idLeague = 2 : i == 3 ? idLeague = 73 : i == 4 ? idLeague = 1 : 0;
          String allRoundsInLeague = await roundDataSource!.getApi(idLeague);
            if(rounds.isEmpty){
              await db!.insert('round', {'response': allRoundsInLeague, 'month': dateTime.month, 'day': dateTime.day});
            }else{
              await db!.update('round', {'response': allRoundsInLeague, 'month': dateTime.month, 'day': dateTime.day}, where: 'id = $i');
            }
          }
        print('oi');
        rounds = await db!.query('round');
        print(rounds.length);
        print('oi2');
        //await winners();
    }
  }
}*/