import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/datadource/round_datasource.dart';
import 'package:club_atlhetica/layers/infra/datadource/team_datasource.dart';
import 'package:club_atlhetica/layers/infra/repository/team_statistic_repository.dart';
import 'package:club_atlhetica/layers/service/repository/get_statistic_teams_api.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:club_atlhetica/layers/use_cases/get_statistic_teams.dart';
import 'package:get/get.dart';

import '../../layers/service/repository/get_round_api.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final http.Client client = http.Client();

  Future<List<Team>> statisticsTeam(int? idTeam, int? idFixtures)async{
    TeamDataSource statisticTeamsApi = GetStatisticTeamsApi(client: client);
    TeamStatisticRepository teamStatisticRepository = TeamStatisticRepository(statisticTeamsApi);
    GetStatisticTeams statisticTeams = GetStatisticTeams(teamStatisticRepository);
    List<Team> statistics = await statisticTeams.execute(idTeam, idFixtures);
    print(statistics[3].statistics);
    print(statistics.length);
    return statistics;
  }

  Future<List<Round>> getRound(int index) async {
    RoundDataSource repositoryRound = GetRoundApi(client: client);
    var getRoundVar = GetRound(repository: repositoryRound);
    List<Round> round = await getRoundVar.execute(index);
    return round;
  }
}
