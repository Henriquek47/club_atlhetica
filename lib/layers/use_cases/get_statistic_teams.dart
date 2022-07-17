import 'package:club_atlhetica/layers/infra/repository/team_statistic_repository.dart';

class GetStatisticTeams{
  ITeamStatisticRepository repository;

  GetStatisticTeams(this.repository);

  execute(int? idTeam)async{
  return await repository.getStatisticTeam(idTeam);
  }
}