import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';

abstract class ITeamWinner{
  Future<String> execute(int idHome, int idAway, String nameHome, String nameAway, int fixture, int idLeague);
  Future<List<TeamStatistic>> statisticsHome(int idHome);
  Future<List<TeamStatistic>> statisticsAway(int idAway);
  Future<TeamStatistic> sumDataHome(int idHome);
  Future<TeamStatistic> sumDataAway(int idAway);
}

class TeamWinner implements ITeamWinner{
  IRepository repository;
  late TeamStatistic homeStatistic;
  late TeamStatistic awayStatistic;

  TeamWinner(this.repository);

  @override
  Future<String> execute(int idHome, int idAway, String nameHome, String nameAway, int fixture, int idLeague)async{
    TeamStatistic home = await sumDataHome(idHome);
    TeamStatistic away = await sumDataAway(idAway);
    int goalsHome = 0;
    int goalsAway = 0;
      goalsHome = home.goalsHome!;
      goalsAway = away.goalsAway!;
    if(goalsHome > goalsAway){
      await repository.updateData(idLeague, nameHome, fixture);
      return nameHome;
    }else if(goalsHome < goalsAway){
      await repository.updateData(idLeague, nameAway, fixture);
      return nameAway;
    }else{
      await repository.updateData(idLeague, 'Empate', fixture);
      return 'Empate';
    }
  }
  
  @override
  Future<List<TeamStatistic>> statisticsHome(int idHome)async{
    List<TeamStatistic> statistic = [];
    List<TeamStatistic> teamStatistic = await repository.getStatisticTeamHome(idHome);
    for (int i = 0; i< teamStatistic.length; i++) {
      if(teamStatistic[i].idHome == idHome){
          homeStatistic = TeamStatistic(
          teamStatistic[i].idHome, -1, teamStatistic[i].goalsHome, 0, teamStatistic[i].statisticHome, null);
        statistic.add(homeStatistic);
      }else if(teamStatistic[i].idAway == idHome){
        homeStatistic = TeamStatistic(
          teamStatistic[i].idAway, -1, teamStatistic[i].goalsAway, 0, teamStatistic[i].statisticHome, null);
        statistic.add(homeStatistic);
      }
    }
    return statistic;
  }
  
  @override
  Future<List<TeamStatistic>> statisticsAway(int idAway)async{
    List<TeamStatistic> statistic = [];
    List<TeamStatistic> teamStatistic = await repository.getStatisticTeamAway(idAway);
    for (int i = 0; i< teamStatistic.length; i++) {
      if(teamStatistic[i].idAway == idAway){
         awayStatistic = TeamStatistic(
          -1, teamStatistic[i].idAway, 0, teamStatistic[i].goalsAway, null, teamStatistic[i].statisticAway);//Mudar e criar duas classes que extend de TeamStatistic para 
        statistic.add(awayStatistic);                                                                       //nao confundir home com away
      }else if(teamStatistic[i].idHome == idAway){
        awayStatistic = TeamStatistic(
          -1, teamStatistic[i].idHome, 0, teamStatistic[i].goalsHome, null, teamStatistic[i].statisticHome);
        statistic.add(awayStatistic);
      }
    }
    return statistic;
  }
  @override
  Future<TeamStatistic> sumDataHome(int idHome)async{
    List<TeamStatistic> teamStatistic = await statisticsHome(idHome);
    int goals = 0;
    int shotsOnGoal = 0;
    int goalkeeperSaves = 0; 
    int ballPossession = 0;
    int cornerKicks = 0;
    int fouls = 0;
    int yellowCards = 0;
    int redCards = 0;
    TeamStatistic statistic;
    for (var home in teamStatistic) {
      goals += home.goalsHome ?? 0;
      shotsOnGoal += home.statisticHome?.shotsOnGoal ?? 0;
      goalkeeperSaves += home.statisticHome?.goalkeeperSaves ?? 0;
      ballPossession += int.tryParse(home.statisticHome?.ballPossession?.replaceAll(RegExp(r'[^0-9]'),'') ?? "0") ?? 0;
      cornerKicks += home.statisticHome?.cornerKicks ?? 0;
      fouls += home.statisticHome?.fouls ?? 0;
      yellowCards += home.statisticHome?.yellowCards ?? 0;
      redCards += home.statisticHome?.redCards ?? 0;
    }
    Statistic stat = Statistic(shotsOnGoal, null, null, null, null, null, fouls, cornerKicks, null, (ballPossession/10).toString(), yellowCards, redCards, goalkeeperSaves, null, null, null);
    statistic = TeamStatistic(idHome, -1, goals, -1, stat, null);
    return statistic;
  }
  @override
  Future<TeamStatistic> sumDataAway(int idAway)async{
    List<TeamStatistic> teamStatistic = await statisticsAway(idAway);
    int goals = 0;
    int shotsOnGoal = 0;
    int goalkeeperSaves = 0; 
    int ballPossession = 0;
    int cornerKicks = 0;
    int fouls = 0;
    int yellowCards = 0;
    int redCards = 0;
    TeamStatistic statistic;
    for (var away in teamStatistic) {
      goals += away.goalsAway ?? 0;
      shotsOnGoal += away.statisticAway?.shotsOnGoal ?? 0;
      goalkeeperSaves += away.statisticAway?.goalkeeperSaves ?? 0;
      ballPossession += int.tryParse(away.statisticAway?.ballPossession?.replaceAll(RegExp(r'[^0-9]'),'') ?? "0") ?? 0;
      cornerKicks += away.statisticAway?.cornerKicks ?? 0;
      fouls += away.statisticAway?.fouls ?? 0;
      yellowCards += away.statisticAway?.yellowCards ?? 0;
      redCards += away.statisticAway?.redCards ?? 0;
    }
    Statistic stat = Statistic(shotsOnGoal, null, null, null, null, null, fouls, cornerKicks, null, (ballPossession/10).toString(), yellowCards, redCards, goalkeeperSaves, null, null, null);
    statistic = TeamStatistic(-1, idAway, -1, goals, null, stat);
    return statistic;
  }
}


/*class TeamWinner implements ITeamWinner{
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
              goalsHome += statistic['away']![k].goalsHome;
            }else{
              goalsHome += statistic['away']![k].goalsAway;
            }
          }
            for (var k = 0; k < statistic.length; k++) {
            if(round[i].idAway == statistic['home']![k].idAway){
              goalsAway += statistic['home']![k].goalsAway;
            }else{
              goalsAway += statistic['home']![k].goalsHome;
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
            allStatistics['home']['shotsOnGoal'] += statistic['home']?[k].statisticHome?.shotsOnGoal;
            allStatistics['home']['goalkeeperSaves'] += statistic['home']?[k].statisticHome?.goalkeeperSaves;
            allStatistics['home']['ballPossession'] += calculandoPorcentagemDePasses(statistic['home']?[k].statisticHome?.ballPossession ?? '0.0');
            allStatistics['home']['cornerKicks'] += statistic['home']?[k].statisticHome?.cornerKicks;
            allStatistics['home']['fouls'] += statistic['home']?[k].statisticHome?.fouls;
            allStatistics['home']['yellowCards'] += statistic['home']?[k].statisticHome?.yellowCards;
            allStatistics['home']['redCards'] += statistic['home']?[k].statisticHome?.redCards;
          }else if(idHome == statistic['home']?[k].idAway){
            allStatistics['home']['goals'] += statistic['home']?[k].goalsAway;
            allStatistics['home']['shotsOnGoal'] += statistic['home']?[k].statisticHome?.shotsOnGoal;
            allStatistics['home']['goalkeeperSaves'] += statistic['home']?[k].statisticHome?.goalkeeperSaves;
            allStatistics['home']['ballPossession'] += calculandoPorcentagemDePasses(statistic['home']?[k].statisticHome?.ballPossession ?? '0.0');
            allStatistics['home']['cornerKicks'] += statistic['home']?[k].statisticHome?.cornerKicks;
            allStatistics['home']['fouls'] += statistic['home']?[k].statisticHome?.fouls;
            allStatistics['home']['yellowCards'] += statistic['home']?[k].statisticHome?.yellowCards;
            allStatistics['home']['redCards'] += statistic['home']?[k].statisticHome?.redCards;
          }else{

          }
        }
          for (var k = 0; k < statistic['away']!.length; k++) {
            if(idAway == statistic['away']?[k].idAway){
              allStatistics['away']['goals'] += statistic['away']?[k].goalsAway;
              allStatistics['away']['shotsOnGoal'] += statistic['away']?[k].statisticHome?.shotsOnGoal;
              allStatistics['away']['goalkeeperSaves'] += statistic['away']?[k].statisticHome?.goalkeeperSaves;
              allStatistics['away']['ballPossession'] += calculandoPorcentagemDePasses(statistic['away']?[k].statisticHome?.ballPossession ?? '0.0');
              allStatistics['away']['cornerKicks'] += statistic['away']?[k].statisticHome?.cornerKicks;
              allStatistics['away']['fouls'] += statistic['away']?[k].statisticHome?.fouls;
              allStatistics['away']['yellowCards'] += statistic['away']?[k].statisticHome?.yellowCards;
              allStatistics['away']['redCards'] += statistic['away']?[k].statisticHome?.redCards;
            }else if(idAway == statistic['away']?[k].idHome){
              allStatistics['away']['goals'] += statistic['away']?[k].goalsHome;
              allStatistics['away']['shotsOnGoal'] += statistic['away']?[k].statisticHome?.shotsOnGoal;
              allStatistics['away']['goalkeeperSaves'] += statistic['away']?[k].statisticHome?.goalkeeperSaves;
              allStatistics['away']['ballPossession'] += calculandoPorcentagemDePasses(statistic['away']?[k].statisticHome?.ballPossession ?? '0.0');
              allStatistics['away']['cornerKicks'] += statistic['away']?[k].statisticHome?.cornerKicks;
              allStatistics['away']['fouls'] += statistic['away']?[k].statisticHome?.fouls;
              allStatistics['away']['yellowCards'] += statistic['away']?[k].statisticHome?.yellowCards;
              allStatistics['away']['redCards'] += statistic['away']?[k].statisticHome?.redCards;
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
}*/