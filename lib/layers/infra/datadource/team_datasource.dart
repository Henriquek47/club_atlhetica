import 'package:club_atlhetica/layers/entities/team.dart';

abstract class TeamDataSource{
    Future<Map> last10RoundsTeam(int? idTeam);
    Future<Map> statisticRound(List<int> ids);
}