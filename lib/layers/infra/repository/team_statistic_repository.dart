import 'package:club_atlhetica/layers/infra/adapter/team_adapter.dart';

import '../../entities/team.dart';
import '../datadource/team_datasource.dart';

abstract class ITeamStatisticRpository{
  getStatisticTeam(int? idTeam, int? idFixtures);
}

class TeamStatisticRepository extends ITeamStatisticRpository{
  TeamDataSource teamDataSource;

  TeamStatisticRepository(this.teamDataSource);
  
  @override
  getStatisticTeam(int? idTeam, int? idFixtures)async{
  Map teamStatistic2 =  await teamDataSource.getStatisticTeams2(idTeam, idFixtures);
  Map teamRound2 = await teamDataSource.getGoalsTeam2(idTeam);


  List results = teamStatistic2['response'][0]['statistics'];
  List statisticsGoals = teamRound2['response'];
  Map<String, dynamic> addStatistic = statisticsGoals[0];
  addStatistic.addAll({'statistics' : results});
  List<Team> teamStatistic = statisticsGoals.map((e) => TeamAdapter.fromjson(e)).toList();
  return teamStatistic;
  }
  
   
}