import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';

abstract class ITeamWinner{
  Future<int> execute();
}

class TeamWinner implements ITeamWinner{
  IRepository repository;

  TeamWinner(this.repository);

  @override
  execute()async{
    List<Round> round = await repository.getRounds();
    for (var i = 0; i < round.length; i++) {
      if(round[i].nextGames == null){
        List<TeamStatistic> statistic = await repository.getStatisticTeam(round[i].idHome, round[i].idAway);
          if(statistic[0].goalsHome! > statistic[1].goalsAway!){
            return 0;
          }else{
            return 1;
          }
      }
    }
    return 5;
  }
}