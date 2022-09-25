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

  Future<Map<String, dynamic>> getStatisticTeam(int idHome, int idAway)async{
    List<TeamStatistic> statistic = await repository.getStatisticTeam(idHome, idAway);
    print(statistic);

    Map<String, dynamic> allStatistics = {
      'home' : {
        'goals': 0,
        'shotsOnGoal': 0,
        'goalkeeperSaves':0,
        'ballPossession':'0',
        'cornerKicks':0,
        'fouls':0,
        'yellowCards':0,
        'redCards':0
      },
      'away' : {
        'goals': 0,
        'shotsOnGoal': 0,
        'goalkeeperSaves':0,
        'ballPossession':'0',
        'cornerKicks':0,
        'fouls':0,
        'yellowCards':0,
        'redCards':0
      }
    };
    for (var k = 0; k < statistic.length; k++) {
          if(idHome == statistic[k].idHome){
            allStatistics['home']['goals'] += statistic[k].goalsHome ?? 0;
            allStatistics['home']['shotsOnGoal'] += statistic[k].statisticHome.shotsOnGoal ?? 0;
            allStatistics['home']['goalkeeperSaves'] += statistic[k].statisticHome.goalkeeperSaves ?? 0;
            allStatistics['home']['ballPossession'] = statistic[k].statisticHome.ballPossession ?? '0';
            allStatistics['home']['cornerKicks'] += statistic[k].statisticHome.cornerKicks ?? 0;
            allStatistics['home']['fouls'] += statistic[k].statisticHome.fouls ?? 0;
            allStatistics['home']['yellowCards'] += statistic[k].statisticHome.yellowCards ?? 0;
            allStatistics['home']['redCards'] += statistic[k].statisticHome.redCards ?? 0;
          }else if(idAway == statistic[k].idHome){
            allStatistics['home']['goals'] += statistic[k].goalsAway ?? 0;
            allStatistics['home']['shotsOnGoal'] += statistic[k].statisticHome.shotsOnGoal ?? 0;
            allStatistics['home']['goalkeeperSaves'] += statistic[k].statisticHome.goalkeeperSaves ?? 0;
            allStatistics['home']['ballPossession'] = statistic[k].statisticHome.ballPossession ?? '0';
            allStatistics['home']['cornerKicks'] += statistic[k].statisticHome.cornerKicks ?? 0;
            allStatistics['home']['fouls'] += statistic[k].statisticHome.fouls ?? 0;
            allStatistics['home']['yellowCards'] += statistic[k].statisticHome.yellowCards ?? 0;
            allStatistics['home']['redCards'] += statistic[k].statisticHome.redCards ?? 0;
          }else{

          }
        }
          for (var k = 0; k < statistic.length; k++) {
          if(idAway == statistic[k].idAway){
            allStatistics['away']['goals'] += statistic[k].goalsAway ?? 0;
            allStatistics['away']['shotsOnGoal'] += statistic[k].statisticHome.shotsOnGoal ?? 0;
            allStatistics['away']['goalkeeperSaves'] += statistic[k].statisticHome.goalkeeperSaves ?? 0;
            allStatistics['away']['ballPossession'] = statistic[k].statisticHome.ballPossession ?? '0';
            allStatistics['away']['cornerKicks'] += statistic[k].statisticHome.cornerKicks ?? 0;
            allStatistics['away']['fouls'] += statistic[k].statisticHome.fouls ?? 0;
            allStatistics['away']['yellowCards'] += statistic[k].statisticHome.yellowCards ?? 0;
            allStatistics['away']['redCards'] += statistic[k].statisticHome.redCards ?? 0;
          }else if(idAway == statistic[k].idHome){
             allStatistics['away']['goals'] += statistic[k].goalsHome ?? 0;
            allStatistics['away']['shotsOnGoal'] += statistic[k].statisticHome.shotsOnGoal ?? 0;
            allStatistics['away']['goalkeeperSaves'] += statistic[k].statisticHome.goalkeeperSaves ?? 0;
            allStatistics['away']['ballPossession'] = statistic[k].statisticHome.ballPossession ?? '0';
            allStatistics['away']['cornerKicks'] += statistic[k].statisticHome.cornerKicks ?? 0;
            allStatistics['away']['fouls'] += statistic[k].statisticHome.fouls ?? 0;
            allStatistics['away']['yellowCards'] += statistic[k].statisticHome.yellowCards ?? 0;
            allStatistics['away']['redCards'] += statistic[k].statisticHome.redCards ?? 0;
          }else{

          }
        }
    return allStatistics;
  }
}