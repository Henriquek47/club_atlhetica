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
    for (var j = 0; j < 4; j++) {
    j == 0 ? repository.posLeague = 0 : j == 1 ? repository.posLeague = 1 : j == 2 ? repository.posLeague = 2 : j == 3 ? repository.posLeague = 3 : 0;
    List<Round> round = await repository.getRounds();
    int goalsHome = 100;
    int goalsAway = 100;
    for (var i = 0; i < round.length; i++) {
      if(round[i].nextGames == null && round[i].notification == false){
        int hour = DateTime.parse(round[i].date!).hour - 3;
        if(hour - clock.now().hour <= 2 && hour - clock.now().hour >= 0
      && DateTime.parse(round[i].date!).day == clock.now().day && DateTime.parse(round[i].date!).month == clock.now().month){
        Map<String, List<TeamStatistic>> statistic = await repository.getStatisticTeam(round[i].idHome, round[i].idAway);
      print('entrou ${statistic}');

        if(statistic.isNotEmpty){

          for (var k = 0; k < statistic.length; k++) {
            if(round[i].idHome == statistic['away']![k].idHome){
              goalsHome += statistic['away']![k].goalsHome!;
            }else{
              goalsHome += statistic['away']![k].goalsAway!;
            }
          }
            for (var k = 0; k < statistic.length; k++) {
            if(round[i].idAway == statistic['home']![k].idAway){
              goalsAway += statistic['home']![k].goalsAway!;
            }else{
              goalsAway += statistic['home']![k].goalsHome!;
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
    try {
      Map<String, List<TeamStatistic>> statistic = await repository.getStatisticTeam(idHome, idAway);

    Map<String, dynamic> allStatistics = {
      'home' : {
        'goals': 0,
        'shotsOnGoal': 0,
        'goalkeeperSaves':0,
        'ballPossession': 0,
        'cornerKicks':0,
        'fouls':0,
        'yellowCards':0,
        'redCards':0
      },
      'away' : {
        'goals': 0,
        'shotsOnGoal': 0,
        'goalkeeperSaves':0,
        'ballPossession': 0,
        'cornerKicks':0,
        'fouls':0,
        'yellowCards':0,
        'redCards':0
      }
    };
    for (int k = 0; k < statistic['home']!.length; k++) {
          if(idHome == statistic['home']?[k].idHome){
            allStatistics['home']['goals'] += statistic['home']?[k].goalsHome ?? 0;
            allStatistics['home']['shotsOnGoal'] += statistic['home']?[k].statisticHome.shotsOnGoal ?? 0;
            allStatistics['home']['goalkeeperSaves'] += statistic['home']?[k].statisticHome.goalkeeperSaves ?? 0;
            allStatistics['home']['ballPossession'] += calculandoPorcentagemDePasses(statistic['home']?[k].statisticHome.ballPossession ?? '0.0');
            allStatistics['home']['cornerKicks'] += statistic['home']?[k].statisticHome.cornerKicks ?? 0;
            allStatistics['home']['fouls'] += statistic['home']?[k].statisticHome.fouls ?? 0;
            allStatistics['home']['yellowCards'] += statistic['home']?[k].statisticHome.yellowCards ?? 0;
            allStatistics['home']['redCards'] += statistic['home']?[k].statisticHome.redCards ?? 0;
          }else if(idHome == statistic['home']?[k].idAway){
            allStatistics['home']['goals'] += statistic['home']?[k].goalsAway ?? 0;
            allStatistics['home']['shotsOnGoal'] += statistic['home']?[k].statisticHome.shotsOnGoal ?? 0;
            allStatistics['home']['goalkeeperSaves'] += statistic['home']?[k].statisticHome.goalkeeperSaves ?? 0;
            allStatistics['home']['ballPossession'] += calculandoPorcentagemDePasses(statistic['home']?[k].statisticHome.ballPossession ?? '0.0');
            allStatistics['home']['cornerKicks'] += statistic['home']?[k].statisticHome.cornerKicks ?? 0;
            allStatistics['home']['fouls'] += statistic['home']?[k].statisticHome.fouls ?? 0;
            allStatistics['home']['yellowCards'] += statistic['home']?[k].statisticHome.yellowCards ?? 0;
            allStatistics['home']['redCards'] += statistic['home']?[k].statisticHome.redCards ?? 0;
          }else{

          }
        }
          for (var k = 0; k < statistic['away']!.length; k++) {
            if(idAway == statistic['away']?[k].idAway){
              allStatistics['away']['goals'] += statistic['away']?[k].goalsAway ?? 0;
              allStatistics['away']['shotsOnGoal'] += statistic['away']?[k].statisticHome.shotsOnGoal ?? 0;
              allStatistics['away']['goalkeeperSaves'] += statistic['away']?[k].statisticHome.goalkeeperSaves ?? 0;
              allStatistics['away']['ballPossession'] += calculandoPorcentagemDePasses(statistic['away']?[k].statisticHome.ballPossession ?? '0.0');
              allStatistics['away']['cornerKicks'] += statistic['away']?[k].statisticHome.cornerKicks ?? 0;
              allStatistics['away']['fouls'] += statistic['away']?[k].statisticHome.fouls ?? 0;
              allStatistics['away']['yellowCards'] += statistic['away']?[k].statisticHome.yellowCards ?? 0;
              allStatistics['away']['redCards'] += statistic['away']?[k].statisticHome.redCards ?? 0;
            }else if(idAway == statistic['away']?[k].idHome){
              allStatistics['away']['goals'] += statistic['away']?[k].goalsHome ?? 0;
              allStatistics['away']['shotsOnGoal'] += statistic['away']?[k].statisticHome.shotsOnGoal ?? 0;
              allStatistics['away']['goalkeeperSaves'] += statistic['away']?[k].statisticHome.goalkeeperSaves ?? 0;
              allStatistics['away']['ballPossession'] += calculandoPorcentagemDePasses(statistic['away']?[k].statisticHome.ballPossession ?? '0.0');
              allStatistics['away']['cornerKicks'] += statistic['away']?[k].statisticHome.cornerKicks ?? 0;
              allStatistics['away']['fouls'] += statistic['away']?[k].statisticHome.fouls ?? 0;
              allStatistics['away']['yellowCards'] += statistic['away']?[k].statisticHome.yellowCards ?? 0;
              allStatistics['away']['redCards'] += statistic['away']?[k].statisticHome.redCards ?? 0;
            }else{
              
          }
        }
    return allStatistics;
    } catch (e) {
      return {};
    }
    
  }

  int calculandoPorcentagemDePasses(String passes){
    double value = double.parse(passes.replaceAll(RegExp('[^0-9]'), ''));
    value = value/10;
    return value.toInt();
  }
}