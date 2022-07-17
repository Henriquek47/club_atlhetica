import 'package:club_atlhetica/layers/infra/adapter/team_adapter.dart';

import '../../entities/team.dart';
import '../datadource/team_datasource.dart';

abstract class ITeamStatisticRepository{
  getStatisticTeam(int? idTeam);
}

class TeamStatisticRepository extends ITeamStatisticRepository{
  TeamDataSource teamDataSource;

  TeamStatisticRepository(this.teamDataSource);
  
  @override
  getStatisticTeam(int? idTeam)async{
  Map teamRound = await teamDataSource.last10RoundsTeam(idTeam);
  List<int> fixture = [];
  for (var i = 0; i < 4; i++) {
      fixture.add(teamRound['response'][i]['fixture']['id']);
  }
  Map teamStatisticResponse =  await teamDataSource.statisticRound(fixture);
  List results = teamStatisticResponse['response'];
  List<TeamStatistic> teamStatistic = results.map((e) => TeamAdapter.fromJsonStatistic(e)).toList();
    return teamStatistic;
  }  
}