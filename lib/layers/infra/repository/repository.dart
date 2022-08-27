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
  Future<List<TeamStatistic>> getStatisticTeam(int? idTeamHome, int? idTeamAway, int index);
  Future<List<Round>> getRounds();
  Future<List<Round>> updateData(int index, String winner);
  initRepository();
}

class Repository extends IRepository{
  TeamDataSource? teamDataSource;
  RoundDataSource? roundDataSource;
  Database? db;

  Repository({this.teamDataSource, this.roundDataSource, this.db});

  
  @override
  getStatisticTeam(int? idTeamHome, int? idTeamAway, int index)async{
    List roundTeamLast = [];
  for(int i=0; i<2; i++){
    if(i==0){
      Map teamRoundHome = await teamDataSource!.last10RoundsTeam(idTeamHome);
      roundTeamLast.add(teamRoundHome);
    }else if(i==1){
      Map teamRoundAway = await teamDataSource!.last10RoundsTeam(idTeamAway);
      roundTeamLast.add(teamRoundAway);
    }
  }
  List<int> fixture = [];
  for(int j=0; j<2; j++){
    for (var i = 0; i < 10; i++) {
      fixture.add(roundTeamLast[j]['response'][i]['fixture']['id']);
    }
  }
  Map teamStatisticResponse =  await teamDataSource!.statisticRound(fixture);
  List results = teamStatisticResponse['response'];//tem 20 responses
  if(fixture.length > 1){
  List<TeamStatistic> teamStatistic = results.map((e) => TeamAdapter.fromJsonStatistic(e)).toList();
    return teamStatistic;
  }else{
    return [];
  }
  }
  
   @override
  Future<List<Round>> getRounds()async{
    db = await DB.instance.database;
    List rounds = await db!.query('round');
    String response = await rounds.first['response'];
    var body = jsonDecode(response);
    List list = body['response'];
    var _random = Random().nextInt(100);
    var newBody;
    if(body['response'][_random]['fixture']['notification'] == null || body['response'][_random]['fixture']['winner'] == null){
    for (int i = 0; i<list.length; i++) {
      body['response'][i]['fixture']['notification'] = false;
      body['response'][i]['fixture']['winner'] = 'Analisando';
      newBody = body;
    }
     await db!.update('round', {'response': jsonEncode(newBody)});
    }
    rounds = await db!.query('round');
    List<Round> listRounds = list.map((e) => RoundAdapter.fromJson(e)).toList();
    return listRounds;
  }
  
  @override
  Future<List<Round>> updateData(int index, String winner)async{
    db = await DB.instance.database;
    List rounds = await db!.query('round');
    String response = await rounds.first['response'];
    final body = jsonDecode(response);
    var _random = Random().nextInt(100);
    if(rounds.isEmpty || body['response'][_random]['fixture']['notification'] == null || body['response'][_random]['fixture']['winner'] == null){
      return await getRounds();
    }else{
      List list = body['response'];
      body['response'][index]['fixture']['notification'] = true;
      body['response'][index]['fixture']['winner'] = winner;
      await db!.update('round', {'response': jsonEncode(body)});
      rounds = await db!.query('round');
      List<Round> listRounds = list.map((e) => RoundAdapter.fromJson(e)).toList();
      return listRounds;
   }
  }
  
  @override
  initRepository()async{
    db = await DB.instance.database;
    List rounds = await db!.query('round');
    String allRound = '';
    print(rounds);
    if(rounds.isEmpty || rounds.first['day'] == null){
        print("AQUI");
        allRound = await roundDataSource!.getApi();
        if(rounds.isEmpty){
          await db!.insert('round', {'response': allRound, 'month': dateTime.month, 'day': dateTime.day});
        }else{
          await db!.update('round', {'response': allRound, 'month': dateTime.month, 'day': dateTime.day});
        }
        print('oi');
        rounds = await db!.query('round');
        print('oi2');
    }
  }  
}