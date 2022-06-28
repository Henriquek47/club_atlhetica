import 'package:club_atlhetica/layers/service/repository/get_statistic_teams_api.dart';
import 'package:club_atlhetica/layers/service/repository/model/round_model.dart';
import 'package:club_atlhetica/layers/service/repository/model/teams_model.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:club_atlhetica/layers/use_cases/get_statistic_teams.dart';
import 'package:get/get.dart';

import '../../layers/service/repository/get_round_api.dart';
import '../../layers/service/repository/repository.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final http.Client client = http.Client();

  Future<List<SoccerMatch>> getApiStatisticTeams(int id)async{
   Repository repositoryTeam = GetStatisticTeamsApi(client: client);
    var getTeam = GetStatisticTeams(repositoryTeam);
    List<SoccerMatch> teams = await getTeam.execute(id);
    return teams;
  }

  Future<List<RoundModel>> getRound(int index) async {
    Repository repositoryRound = GetRoundApi(client: client);
    var getRoundVar = GetRound(repository: repositoryRound);
    List<RoundModel> round = await getRoundVar.execute(index);
    return round;
  }
}
