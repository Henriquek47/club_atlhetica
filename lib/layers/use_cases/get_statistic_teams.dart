import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/team_statistic_repository.dart';

class GetStatisticTeams{
  ITeamStatisticRepository repository;

  GetStatisticTeams(this.repository);

  execute(int? idTeamHome, int? idTeamAway)async{
  List<TeamStatistic> statistics = await repository.getStatisticTeam(idTeamHome, idTeamAway);
  return statistics;
  }
}