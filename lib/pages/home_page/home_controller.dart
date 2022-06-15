import 'package:club_atlhetica/layers/domain/round.dart';
import 'package:club_atlhetica/layers/service/repository/model/teams_model.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:club_atlhetica/layers/use_cases/get_statistic_teams.dart';
import 'package:get/get.dart';

import '../../layers/service/repository/get_round_api.dart';
import '../../layers/service/repository/get_statistic_teams_api.dart';
import '../../layers/service/repository/repository.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final http.Client client = http.Client();

  Future<List<SoccerMatch>> getApiStatisticTeams(int id, bool home)async{
   Repository repositoryTeam = GetStatisticTeamsApi(client: client);
   Round round = await getRound(id);
    var getTeam = GetStatisticTeams(repositoryTeam);
    List<SoccerMatch> teams = await getTeam.execute(home == true ? round.home : round.away);
    return teams;
  }

  Future<Round> getRound(int index) async {
    Repository repositoryRound = GetRoundApi(client: client);
    var getRoundVar = GetRound(repository: repositoryRound);
    Round round = await getRoundVar.execute(index);
    return round;
  }
}
