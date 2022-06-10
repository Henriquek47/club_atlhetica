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
  Future<String?> getRound(bool home, int index) async {
    Repository repositoryRound = GetRoundApi(client: client);
    var getRoundVar = GetRound(repository: repositoryRound);
    Round round = await getRoundVar.execute(0);
    if(home){
      return round.nameHome;
    }else{
      return round.nameAway;
    }
  }

  Future<int?> getStatisticTeams()async{
    Repository repositoryTeam = GetStatisticTeamsApi(client: client);
    Repository repositoryRound = GetRoundApi(client: client);
    var getRoundVar = GetRound(repository: repositoryRound);
    var getTeam = GetStatisticTeams(repositoryTeam);
    Round round = await getRoundVar.execute(0);
    List<SoccerMatch> teamHome = await getTeam.execute(round.home);
    return teamHome[0].teams?.home?.id;
  }
}
