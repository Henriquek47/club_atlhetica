import 'dart:convert';

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/adapter/round_adapter.dart';
import 'package:club_atlhetica/layers/infra/adapter/team_adapter.dart';
import 'package:club_atlhetica/layers/infra/datadource/round_datasource.dart';
import 'package:club_atlhetica/layers/service/database/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../entities/team.dart';
import '../datadource/team_datasource.dart';

abstract class IRepository{
  Future<List<TeamStatistic>> getStatisticTeam(int? idTeamHome, int? idTeamAway);
  Future<List<Round>> getRounds();
  List<Round>? listRounds;
}

class Repository extends IRepository{
  TeamDataSource? teamDataSource;
  RoundDataSource? roundDataSource;
  Database? db;

  Repository({this.teamDataSource, this.roundDataSource, this.db}){
    _initialDatabase();
  }

  _initialDatabase(){
    return getRounds;
  }
  
  @override
  getStatisticTeam(int? idTeamHome, int? idTeamAway)async{
    List roundTeamLast = [];
  for(int i=0; i<1; i++){
    if(i==0){
      Map teamRoundHome = await teamDataSource!.last10RoundsTeam(idTeamHome);
      roundTeamLast.add(teamRoundHome);
    }else if(i==1){
      Map teamRoundAway = await teamDataSource!.last10RoundsTeam(idTeamAway);
      roundTeamLast.add(teamRoundAway);
    }
  }

  List<int> fixture = [];
  for(int j=0; j<1; j++){
    for (var i = 0; i < 10; i++) {
      fixture.add(roundTeamLast[j]['response'][i]['fixture']['id']);
    }
  }
  Map teamStatisticResponse =  await teamDataSource!.statisticRound(fixture);
  List results = teamStatisticResponse['response'];
  if(fixture.length > 1){
  List<TeamStatistic> teamStatistic = results.map((e) => TeamAdapter.fromJsonStatistic(e)).toList();
    return teamStatistic;
  }else{
    return [];
  }
  }
  
  @override
  Future<List<Round>> getRounds()async{
    List rounds = await db!.query('round');
    List allRound = [];
    if(rounds.isEmpty){
      allRound = await roundDataSource!.getApi();
      db!.update('round', {'response': allRound.toString()});
    }

    String response = await rounds.first['response'];
    var body = jsonDecode(response);
    List list = body['response'];
    print(list);
    List<Round> listRounds = list.map((e) => RoundAdapter.fromJson(e)).toList();
    //final date = round[id].date;
   // DateTime now = DateTime.parse(date.toString());
    //bool fisnishOrProgress = finishedOrInProgress(now, dateTime);
    return listRounds;
  }  
}
