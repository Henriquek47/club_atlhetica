import 'package:clock/clock.dart';
import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:flutter/cupertino.dart';

abstract class ITeamWinner{
  Future<List> execute();
}

class TeamWinner implements ITeamWinner{
  IRepository repository;

  TeamWinner(this.repository);

  @override
  execute()async{
    List<Round> round = await repository.getRounds();
    int goalsHome = 0;
    int goalsAway = 0;
    print((DateTime.parse(round[0].date!).hour - 3) - clock.now().hour);
    for (var i = 0; i < round.length; i++) {
      if(round[i].nextGames == null && round[i].notification == false){
        int hour = DateTime.parse(round[i].date!).hour - 3;
        if(hour - clock.now().hour <= 2 && hour - clock.now().hour >= 0
      && DateTime.parse(round[i].date!).day == clock.now().day && DateTime.parse(round[i].date!).month == clock.now().month){
        List<TeamStatistic> statistic = await repository.getStatisticTeam(round[i].idHome, round[i].idAway);
        for (var k = 0; k < 10; k++) {
          if(round[i].idHome == statistic[k].idHome){
            goalsHome += statistic[k].goalsHome!;
          }else{
            goalsHome += statistic[k].goalsAway!;
          }
        }
          for (var k = 0; k < 10; k++) {
          if(round[i].idAway == statistic[k].idAway){
            goalsAway += statistic[k].goalsAway!;
          }else{
            goalsAway += statistic[k].goalsHome!;
          }
        }
      }
        return winnerFunc(goalsHome, goalsAway, round[i].nameHome, round[i].nameAway, i);
      }
    }
    return [5, 'Sem Dados'];
  }

  Future<List> winnerFunc(goalsHome, goalsAway, nameHome, nameAway, index)async{
    if(goalsHome > goalsAway){
      print('Entrou em vitoria');
      await repository.updateData(index, nameHome);
      return [0, nameHome];
    }else if(goalsHome < goalsAway){
      print('Entrou em vitoria');
      await repository.updateData(index, nameAway);
      return [1, nameAway];
    }else{
      print('Entrou em empate');
      print('$goalsHome - $goalsAway');
      print(nameHome);
      return [2, 'Empate'];
    }
  }

  Future<List<TeamStatistic>> getStatisticTeam(int idHome, int idAway)async{
    return await repository.getStatisticTeam(idHome, idAway);
  }
}