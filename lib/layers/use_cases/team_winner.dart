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
      print(round[i].notification);
      if(round[i].nextGames == null && round[i].notification == false){
        List<TeamStatistic> statistic = await repository.getStatisticTeam(round[i].idHome, round[i].idAway, i);
          if(round[i].idHome == statistic[0].idHome && round[i].idAway == statistic[1].idAway){
            return winnerFunc(statistic[0].goalsHome, statistic[1].goalsAway);
          }else if(round[i].idHome == statistic[0].idAway && round[i].idAway == statistic[1].idHome){
            return winnerFunc(statistic[0].goalsAway, statistic[1].goalsHome);
          }else if(round[i].idHome == statistic[0].idAway && round[i].idAway == statistic[1].idAway){
            return winnerFunc(statistic[0].goalsAway, statistic[1].goalsAway);
          }else if(round[i].idHome == statistic[0].idHome && round[i].idAway == statistic[1].idHome){
            return winnerFunc(statistic[0].goalsHome, statistic[1].goalsHome);
          }
      }
    }
    return 5;
  }

  int winnerFunc(goalsHome, goalsAway){
    if(goalsHome > goalsAway){
            return 0;
          }else{
            return 1;
          }
  }
}