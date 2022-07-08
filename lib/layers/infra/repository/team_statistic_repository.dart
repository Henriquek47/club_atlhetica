import 'package:club_atlhetica/layers/infra/adapter/team_adapter.dart';

import '../../entities/team.dart';
import '../datadource/team_datasource.dart';

abstract class ITeamStatisticRepository{
  getStatisticTeam(int? idTeam, int? idFixtures);
}

class TeamStatisticRepository extends ITeamStatisticRepository{
  TeamDataSource teamDataSource;

  TeamStatisticRepository(this.teamDataSource);
  
  @override
  getStatisticTeam(int? idTeam, int? idFixtures)async{
  Map teamStatisticResponse =  await teamDataSource.getStatisticTeams(idTeam, idFixtures);
  Map teamRound = await teamDataSource.getGoalsTeam(idTeam);

  List results = teamStatisticResponse['response'][0]['statistics'];
  List statisticsGoals = teamRound['response'];
  List<Team> teamStatistic = [];
  for (var i = 0; i < 4; i++) {
  Map<String, dynamic> addStatistic = statisticsGoals[i];
  addStatistic.addAll({'statistics' : results});
  teamStatistic = statisticsGoals.map((e) => TeamAdapter.fromjson(e)).toList();
  }
    return teamStatistic;
  }  
}