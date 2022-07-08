import 'package:club_atlhetica/layers/infra/repository/team_statistic_repository.dart';

class GetStatisticTeams{
  ITeamStatisticRepository repository;

  GetStatisticTeams(this.repository);

  execute(int? idTeam, int? idFixtures)async{
  return await repository.getStatisticTeam(idTeam, idFixtures);
  }
}