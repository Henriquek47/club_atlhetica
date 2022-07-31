import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/adapter/round_adapter.dart';
import 'package:club_atlhetica/layers/infra/adapter/team_adapter.dart';
import 'package:club_atlhetica/layers/infra/datadource/round_datasource.dart';

import '../../entities/team.dart';
import '../datadource/team_datasource.dart';

abstract class IRepository{
  Future<List<TeamStatistic>> getStatisticTeam(int? idTeamHome, int? idTeamAway);
  Future<List<Round>> getRounds();
}

class Repository extends IRepository{
  TeamDataSource? teamDataSource;
  RoundDataSource? roundDataSource;

  Repository({this.teamDataSource, this.roundDataSource});
  
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
    List allRound = await roundDataSource!.getApi();
    List<Round> round = allRound.map((e) => RoundAdapter.fromJson(e)).toList();
    //final date = round[id].date;
   // DateTime now = DateTime.parse(date.toString());
    //bool fisnishOrProgress = finishedOrInProgress(now, dateTime);
    return round;
  }  
}
