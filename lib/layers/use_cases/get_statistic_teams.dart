import 'package:club_atlhetica/layers/service/repository/model/teams_model.dart';
import 'package:club_atlhetica/layers/service/repository/repository.dart';

class GetStatisticTeams{
  Repository repository;

  GetStatisticTeams(this.repository);

  execute(int? idTeam)async{
    List<SoccerMatch> team = await repository.getApi(idTeam);
    return team;
  }
}