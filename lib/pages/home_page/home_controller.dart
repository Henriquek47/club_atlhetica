import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:club_atlhetica/layers/use_cases/get_statistic_teams.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final http.Client client;
  final IRepository repository;

  HomeController({required this.client, required this.repository});

  Future<int> statisticsTeam()async{
    GetStatisticTeams statisticTeams = GetStatisticTeams(repository);
    List<Round> round = await getRound();
    List<Round> roundReverse = List.from(round.reversed);
    List<TeamStatistic> statistics = [];
    for (var i = 0; i < roundReverse.length; i++) {
      final date = roundReverse[i].date;
      DateTime now = DateTime.parse(date.toString());
      DateTime nowDay = DateTime.now();
      //create random hour to call the game
      if(now.hour != 0 && now.month >= nowDay.month && roundReverse[i].nextGames == null){
        List<TeamStatistic> list = await statisticTeams.execute(roundReverse[i].idHome, roundReverse[i].idAway);
        statistics.addAll(list);
        if(statistics[i].goalsHome! > statistics[i].goalsAway!){
          i = roundReverse.length;
          return 0;
        }else if(statistics[i].goalsHome! < statistics[i].goalsAway!){
          i = roundReverse.length;
          return 1;
        }else{
          i = roundReverse.length;
          return 2;
        }
      }
    }
    return 5;
  }

  Future<List<Round>> getRound() async {
    GetRound getRoundVar = GetRound(repository: repository);
    List<Round> round = await getRoundVar.execute();
    return round;
  }
}
