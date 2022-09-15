import 'dart:convert';
import 'dart:math';

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
  Future<List<TeamStatistic>> getStatisticTeam(int? idTeamHome, int? idTeamAway, int idLeague);
  Future<List<Round>> getRounds();
  Future<List<Round>> updateData(int index, String winner, int fixture);
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

  Future get10lastRound(int? idTeamHome, int? idTeamAway, int idLeague)async{
  roundTeamLast = [];
  for(int i=0; i<2; i++){
    if(i==0){
      Map teamRoundHome = await teamDataSource!.last10RoundsTeam(idTeamHome, idLeague);
      roundTeamLast.add(teamRoundHome);
    }else if(i==1){
      Map teamRoundAway = await teamDataSource!.last10RoundsTeam(idTeamAway, idLeague);
      roundTeamLast.add(teamRoundAway);
    }
  }
  return roundTeamLast;
  }
  
  @override
  getStatisticTeam(int? idTeamHome, int? idTeamAway, int idLeague)async{
    await get10lastRound(idTeamHome, idTeamAway, idLeague);
  List<int> fixture = [];
  print(roundTeamLast);
  try {
    for(int j=0; j<2; j++){
    for (var i = 0; i < 3; i++) {
      fixture.add(roundTeamLast[j]['response'][i]['fixture']['id']);
    }
  }  
  }on RangeError {
    print(e);
  }catch(e){
    print(e);
  }

  Map teamStatisticResponse =  await teamDataSource!.statisticRound(fixture);
  List results = teamStatisticResponse['response'];//tem 20 responses
  if(fixture.length > 1){
  List<TeamStatistic> teamStatistic = results.map((e) => TeamAdapter.fromJsonStatistic(e)).toList();
  print(teamStatistic[0].statisticAway.fouls);
    return teamStatistic;
  }else{
    return [];
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
      print('entrou winner errado');
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
  Future<List<Round>> updateData(int index, String winner, int fixture)async{
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
      await db!.update('round', {'response': jsonEncode(body)}, where: "id = $posLeague");
      rounds = await db!.query('round');
      List<Round> listRounds = list.map((e) => RoundAdapter.fromJson(e)).toList();
      return listRounds;
   }
  }
  
  @override
  initRepository()async{
    db = await DB.instance.database;
    List rounds = await db!.query('round');
    if(rounds.isEmpty || rounds.first['day'] == null || DateTime.utc(dateTime.year, rounds[posLeague]['month'], rounds[posLeague]['day'] + 5,).isBefore(DateTime.now())){
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
          return 'tudo certo';
        }
        print('oi');
        rounds = await db!.query('round');
        print('oi2');
        await winners();
    }
  }
}