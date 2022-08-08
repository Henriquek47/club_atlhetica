import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';

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
      final date = round[i].date;
      DateTime now = DateTime.parse(date.toString());
      DateTime nowDay = DateTime.now();
      //create random hour to call the game
      if(now.hour != 0 && now.month >= nowDay.month && round[i].nextGames == null){
        List<TeamStatistic> statistics = await repository.getStatisticTeam(round[i].idHome, round[i].idAway);
        if(statistics[i].goalsHome! > statistics[i].goalsAway!){
          i = round.length;
          return 0;
        }else if(statistics[i].goalsHome! < statistics[i].goalsAway!){
          i = round.length;
          return 1;
        }else{
          i = round.length;
          return 2;
        }
      }
    }
    return 5;

  }
}