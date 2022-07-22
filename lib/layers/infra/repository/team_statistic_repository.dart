import 'package:club_atlhetica/layers/infra/adapter/team_adapter.dart';

import '../../entities/team.dart';
import '../datadource/team_datasource.dart';

abstract class ITeamStatisticRepository{
  getStatisticTeam(int? idTeamHome, int? idTeamAway);
}

class TeamStatisticRepository extends ITeamStatisticRepository{
  TeamDataSource teamDataSource;

  TeamStatisticRepository(this.teamDataSource);
  
  @override
  getStatisticTeam(int? idTeamHome, int? idTeamAway)async{
    List roundTeamLast = [];
  for(int i=0; i<2; i++){
    if(i==0){
      Map teamRoundHome = await teamDataSource.last10RoundsTeam(idTeamHome);
      roundTeamLast.add(teamRoundHome);
    }else if(i==1){
      Map teamRoundAway = await teamDataSource.last10RoundsTeam(idTeamAway);
      roundTeamLast.add(teamRoundAway);
    }
  }
  List<int> fixture = [];
  for(int j=0; j<2; j++){
    for (var i = 0; i < 4; i++) {
      fixture.add(roundTeamLast[j]['response'][i]['fixture']['id']);
    }
  }
  print(fixture);
  Map teamStatisticResponse =  await teamDataSource.statisticRound(fixture);
  List results = teamStatisticResponse['response'];
  if(fixture.length > 1){
  List<TeamStatistic> teamStatistic = results.map((e) => TeamAdapter.fromJsonStatistic(e)).toList();
    return teamStatistic;
  }else{
    return;
  }
  }  
}
