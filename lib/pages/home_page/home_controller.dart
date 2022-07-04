import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/service/repository/get_statistic_teams_api.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:club_atlhetica/layers/use_cases/get_statistic_teams.dart';
import 'package:get/get.dart';

import '../../layers/service/repository/get_round_api.dart';
import '../../layers/service/repository/repository.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final http.Client client = http.Client();

  Future<List<Team>> getApiStatisticTeams(int id)async{
   GetStatisticTeamsApi repositoryTeam = GetStatisticTeamsApi(client: client);
    var getTeam = GetStatisticTeams(repositoryTeam);
    List<Team> teams = await getTeam.execute(id, 0);
    return teams;
  }

  Future<List<Round>> getRound(int index) async {
    GetRoundApi repositoryRound = GetRoundApi(client: client);
    var getRoundVar = GetRound(repository: repositoryRound);
    List<Round> round = await getRoundVar.execute(index);
    return round;
  }
}
