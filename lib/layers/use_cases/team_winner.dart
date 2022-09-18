import 'package:clock/clock.dart';
import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';

abstract class ITeamWinner{
  Future<List> execute();
}

class TeamWinner implements ITeamWinner{
  IRepository repository;

  TeamWinner(this.repository);

  @override
  execute()async{
    for (var j = 0; j < 3; j++) {
    j == 0 ? repository.posLeague = 0 : j == 1 ? repository.posLeague = 1 : j == 2 ? repository.posLeague = 2 : repository.posLeague = 2;
    List<Round> round = await repository.getRounds();
    int goalsHome = 100;
    int goalsAway = 100;
    for (var i = 0; i < round.length; i++) {
      print(round[i].nextGames == null && round[i].notification == false);
      if(round[i].nextGames == null && round[i].notification == false){
        int hour = DateTime.parse(round[i].date!).hour - 3;
        if(hour - clock.now().hour <= 2 && hour - clock.now().hour >= 0
      && DateTime.parse(round[i].date!).day == clock.now().day && DateTime.parse(round[i].date!).month == clock.now().month){
        List<TeamStatistic> statistic = await repository.getStatisticTeam(round[i].idHome, round[i].idAway);
        if(statistic.isNotEmpty){
        for (var k = 0; k < statistic.length; k++) {
          if(round[i].idHome == statistic[k].idHome){
            goalsHome += statistic[k].goalsHome!;
          }else{
            goalsHome += statistic[k].goalsAway!;
          }
        }
          for (var k = 0; k < statistic.length; k++) {
          if(round[i].idAway == statistic[k].idAway){
            goalsAway += statistic[k].goalsAway!;
          }else{
            goalsAway += statistic[k].goalsHome!;
          }
        }
        return winnerFunc(goalsHome, goalsAway, round[i].nameHome, round[i].nameAway, i, round[i].id, j+1);
        }
      }
      }
    }
    }
    return [5, 'Sem Dados'];
  }

  Future<List> winnerFunc(goalsHome, goalsAway, nameHome, nameAway, index, fixture, posLeague)async{
    if(goalsHome > goalsAway){
      print('Entrou em vitoria');
      await repository.updateData(index, nameHome, fixture, posLeague);
      return [0, nameHome];
    }else if(goalsHome < goalsAway){
      print('Entrou em vitoria');
      await repository.updateData(index, nameAway, fixture, posLeague);
      return [1, nameAway];
    }else{
      print('Entrou em empate');
      return [2, 'Empate'];
    }
  }

  Future<Map<String, Statistic>> getStatisticTeam(int idHome, int idAway)async{
    List<TeamStatistic> statistic = await repository.getStatisticTeam(idHome, idAway);

    Map<String, Statistic> allStatistics = {};
    for (var k = 0; k < statistic.length; k++) {
          if(idHome == statistic[k].idHome){
            allStatistics['home'] = statistic[k].statisticHome;
          }else if(idAway == statistic[k].idHome){
            allStatistics['home'] = statistic[k].statisticAway;
          }else{

          }
        }
          for (var k = 0; k < statistic.length; k++) {
          if(idAway == statistic[k].idAway){
            allStatistics['away'] = statistic[k].statisticAway;
          }else if(idAway == statistic[k].idHome){
            allStatistics['away'] = statistic[k].statisticHome;
          }else{

          }
        }
    return allStatistics;
  }
}