import 'dart:ffi';

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/datadource/round_datasource.dart';
import 'package:club_atlhetica/layers/infra/datadource/team_datasource.dart';
import 'package:club_atlhetica/layers/infra/repository/team_statistic_repository.dart';
import 'package:club_atlhetica/layers/service/repository/statistic_teams_api.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:club_atlhetica/layers/use_cases/get_statistic_teams.dart';
import 'package:get/get.dart';

import '../../layers/service/repository/round_api.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final http.Client client = http.Client();

  Future<List<TeamStatistic>> statisticsTeam()async{
    TeamDataSource statisticTeamsApi = GetStatisticTeamsApi(client: client);
    TeamStatisticRepository teamStatisticRepository = TeamStatisticRepository(statisticTeamsApi);
    GetStatisticTeams statisticTeams = GetStatisticTeams(teamStatisticRepository);
    List<Round> round = await getRound();
    List<Round> roundReverse = List.from(round.reversed);
    List<TeamStatistic> statistics = [];
    List<int> lastFixtures = [];
        
    for (var i = 0; i < roundReverse.length; i++) {
      final date = roundReverse[i].date;
      DateTime now = DateTime.parse(date.toString());
      DateTime nowDay = DateTime.now();
      //create random hour to call the game
      if(now.hour != 0 && now.month >= nowDay.month && roundReverse[i].nextGames == null && lastFixtures.contains(roundReverse[i].id) == false){
        await statisticTeams.execute(roundReverse[i].idHome, roundReverse[i].idAway);
        lastFixtures.add(roundReverse[i].id!);
      }
          print(lastFixtures);

    }
    print(statistics);
    return statistics;
  }

  Future<List<Round>> getRound() async {
    RoundDataSource repositoryRound = GetRoundApi(client: client);
    var getRoundVar = GetRound(repository: repositoryRound);
    List<Round> round = await getRoundVar.execute();
    return round;
  }
}
