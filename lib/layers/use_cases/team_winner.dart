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
    for (var i = 0; i < round.length; i++) {
      print(DateTime.parse(round[i].date!).hour);
      print(dateTime.hour);
      if(round[i].nextGames == null && round[i].notification == false && DateTime.parse(round[i].date!).hour - clock.now().hour <= 2){
        List<TeamStatistic> statistic = await repository.getStatisticTeam(round[i].idHome, round[i].idAway, i);
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
        return winnerFunc(goalsHome, goalsAway, round[i].nameHome, round[i].nameAway, i);
      }
    }
    return [5, 'Sem Dados'];
  }

  Future<List> winnerFunc(goalsHome, goalsAway, nameHome, nameAway, index)async{
    print(roundsUrl);
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
}