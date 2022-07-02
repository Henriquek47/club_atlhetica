import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/service/repository/repository.dart';

class GetStatisticTeams{
  Repository repository;

  GetStatisticTeams(this.repository);

  execute(int? idTeam)async{
    List<Team> team = await repository.getApi(idTeam);
    return team;
  }
}