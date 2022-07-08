import 'package:club_atlhetica/layers/entities/team.dart';

abstract class TeamDataSource{
    Future<Map> getGoalsTeam(int? idTeam);
    Future<Map> getStatisticTeams(int? idTeam, int? idFixtures);
}