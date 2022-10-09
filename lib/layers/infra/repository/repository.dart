import 'dart:convert';
import 'dart:math';

import 'package:clock/clock.dart';
import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/adapter/round_adapter.dart';
import 'package:club_atlhetica/layers/infra/adapter/team_adapter.dart';
import 'package:club_atlhetica/layers/infra/datadource/round_datasource.dart';
import 'package:club_atlhetica/layers/service/database/db.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:sqflite/sqflite.dart';

import '../../entities/team.dart';
import '../datadource/team_datasource.dart';

abstract class IRepository{
  Future<Map<String, List<TeamStatistic>>> getStatisticTeam(int? idTeamHome, int? idTeamAway);
  Future<List<Round>> getRounds();
  Future<List<Round>> updateData(int index, String winner, int fixture, int pos);
  Future<List> winners();
  initRepository();
  int posLeague = 0;
}

class Repository extends IRepository{
  TeamDataSource? teamDataSource;
  RoundDataSource? roundDataSource;
  Database? db;
  List roundTeamLast = [];

  Repository({this.teamDataSource, this.roundDataSource, this.db});

  Future get10lastRound(int? idTeamHome, int? idTeamAway)async{
  roundTeamLast = [];
  for(int i=0; i<2; i++){
    if(i==0){
      Map teamRoundHome = await teamDataSource!.last10RoundsTeam(idTeamHome);
      roundTeamLast.add(teamRoundHome);
    }else if(i==1){
      Map teamRoundAway = await teamDataSource!.last10RoundsTeam(idTeamAway);
      roundTeamLast.add(teamRoundAway);
    }
  }
  return roundTeamLast;
  }
  
  @override
  getStatisticTeam(int? idTeamHome, int? idTeamAway)async{
    List<int> fixtureHome = [];
    List<int> fixtureAway = [];
    try {
     await get10lastRound(idTeamHome, idTeamAway);
      List<Round> round = await getRounds();
      List<Round> beforeRounds =  round.where((element) => DateTime.parse(element.date!).isBefore(clock.now())).toList();

    for (var i = 0; i < beforeRounds.length && i < 10; i++) {
      fixtureHome.add(roundTeamLast[0]['response'][i]['fixture']['id']);
      fixtureAway.add(roundTeamLast[1]['response'][i]['fixture']['id']);
  }   
    } catch (e) {
      return {};
    }

  if(fixtureHome.isNotEmpty && fixtureAway.isNotEmpty){
    try {
      Map teamStatisticResponseHome =  await teamDataSource!.statisticRound(fixtureHome);
      Map teamStatisticResponseAway =  await teamDataSource!.statisticRound(fixtureAway);
      List home = teamStatisticResponseHome['response'];
      List away = teamStatisticResponseAway['response'];
      List<TeamStatistic> teamStatisticHome = home.map((e) => TeamAdapter.fromJsonStatistic(e)).toList();
      List<TeamStatistic> teamStatisticAway = away.map((e) => TeamAdapter.fromJsonStatistic(e)).toList();
      Map<String, List<TeamStatistic>> response = {
      'home': teamStatisticHome,
      'away': teamStatisticAway
    };
      return response;
    } catch (e) {
      return {};
    }
  }else{
    return {};
  }
  }
  
   @override
  Future<List<Round>> getRounds()async{
    db = await DB.instance.database;
    List rounds = await db!.query('round');
    List list = [];
    for (var i = 1; i < 4; i++) {
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
  Future<List> winners()async{
    print('entrou winner aqui agr');
    db = await DB.instance.database;
    List<Round> round = await getRounds();
    List winners = await db!.query('team');
    List rounds = await db!.query('round');
    for (var i = 1; i < 4; i++) {
    String response = await rounds[i-1]['response'];
    var body = jsonDecode(response);
    if(round.isNotEmpty && winners.isNotEmpty){
      for (var i = 0; i < winners.length; i++) {
        for (var k = 0; k < round.length; k++) {
          if(winners[i]['fixture'] == round[k].id){
            body['response'][k]['fixture']['winner'] = winners[i]['winner'];
          }
        }
      }
      await db!.update('round', {'response': jsonEncode(body)}, where: 'id = $i');
    }
    }
    return winners;
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
        for (var i = 1; i < 4; i++) {
          int idLeague = 0;
          i == 1 ? idLeague = 71 : i == 2 ? idLeague = 2 : i == 3 ? idLeague = 73 : idLeague = 0;
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
}