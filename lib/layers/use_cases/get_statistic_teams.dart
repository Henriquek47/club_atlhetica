import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/service/repository/get_statistic_teams_api.dart';

class GetStatisticTeams{
  GetStatisticTeamsApi repository;

  GetStatisticTeams(this.repository);

  execute(int? idTeam, int idRound)async{
    List<Team> team = await repository.getApi(idTeam);
    List goals = [];
    for (var goalsTeam in team) {
      if(goalsTeam.idHome != idTeam){
        goals.add(goalsTeam.goalsAway);
      }else{
      goals.add(goalsTeam.goalsHome);
      }
    }
    print(team[0].idHome);
    print(team[1].idHome);
    team[idRound].statisticTeams(goals, idTeam);
    return team;
  }
}