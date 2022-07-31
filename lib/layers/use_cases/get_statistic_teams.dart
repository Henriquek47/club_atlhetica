import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';

abstract class IGetStatisticTeams{
  Future<List<TeamStatistic>> execute(int? idTeamHome, int? idTeamAway);
}

class GetStatisticTeams implements IGetStatisticTeams{
  IRepository repository;

  GetStatisticTeams(this.repository);

  @override
  execute(int? idTeamHome, int? idTeamAway)async{
  return await repository.getStatisticTeam(idTeamHome, idTeamAway);
  }
}