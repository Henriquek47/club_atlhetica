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
    int roundIndex = 0;
        List<TeamStatistic> statistics = [];
    for (var i = 0; i < round.length; i++) {
      Future.delayed(const Duration(seconds: 50),() {statisticTeams.execute(round[roundIndex].idHome);});
      roundIndex = i;
    }
    return statistics;
  }

  Future<List<Round>> getRound() async {
    RoundDataSource repositoryRound = GetRoundApi(client: client);
    var getRoundVar = GetRound(repository: repositoryRound);
    List<Round> round = await getRoundVar.execute();
    return round;
  }
}
