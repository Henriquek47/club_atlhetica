import 'package:club_atlhetica/layers/domain/team.dart';
import 'package:club_atlhetica/layers/service/repository/model/teams_model.dart';
import 'package:club_atlhetica/layers/service/repository/repository.dart';

class GetStatisticTeams{
  Repository repository;

  GetStatisticTeams(this.repository);

  execute(int? id)async{
    List<SoccerMatch> team = await repository.getApi(id);
    return team;
  }
}