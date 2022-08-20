import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';

abstract class ITeamWinner{
  Future<List> execute();
}

class TeamWinner implements ITeamWinner{
  IRepository repository;

  TeamWinner(this.repository);

  @override
  execute()async{
    List<Round> round = await repository.getRounds();
    for (var i = 0; i < round.length; i++) {
      if(round[i].nextGames == null && round[i].notification == false){
        List<TeamStatistic> statistic = await repository.getStatisticTeam(round[i].idHome, round[i].idAway, i);
        print(statistic.length);
          if(round[i].idHome == statistic[0].idHome && round[i].idAway == statistic[1].idAway){
            return winnerFunc(statistic[0].goalsHome, statistic[1].goalsAway, round[i].nameHome, round[i].nameAway);
          }else if(round[i].idHome == statistic[0].idAway && round[i].idAway == statistic[1].idHome){
            return winnerFunc(statistic[0].goalsAway, statistic[1].goalsHome, round[i].nameHome, round[i].nameAway);
          }else if(round[i].idHome == statistic[0].idAway && round[i].idAway == statistic[1].idAway){
            return winnerFunc(statistic[0].goalsAway, statistic[1].goalsAway, round[i].nameHome, round[i].nameAway);
          }else if(round[i].idHome == statistic[0].idHome && round[i].idAway == statistic[1].idHome){
            return winnerFunc(statistic[0].goalsHome, statistic[1].goalsHome, round[i].nameHome, round[i].nameAway);
          }
      }
    }
    return [5, 'Sem Dados'];
  }

  List winnerFunc(goalsHome, goalsAway, nameHome, nameAway){
    if(goalsHome > goalsAway){
            return [0, nameHome];
          }else if(goalsHome < goalsAway){
            return [1, nameAway];
          }else{
            return [2, 'Empate'];
          }
  }
}