import 'package:club_atlhetica/layers/domain/round.dart';
import 'package:club_atlhetica/layers/service/repository/get_api.dart';
import 'package:club_atlhetica/layers/service/repository/model/model.dart';
import 'package:club_atlhetica/layers/service/repository/repository.dart';
import 'package:club_atlhetica/layers/service/url.dart';

class GetRoundApi extends GetApi implements Repository {
  @override
  getRoundApi(int id) async {
    var response = getApi(url);
    List teams = await response['response'];
    List<SoccerMatch> team = teams.map((e) => SoccerMatch.fromJson(e)).toList();
    return Round(team[id].goals.home, team[id].goals.away, 1);
  }

}