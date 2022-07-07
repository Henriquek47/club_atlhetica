import 'package:club_atlhetica/layers/entities/team.dart';

abstract class TeamDataSource{
    Future<List<TeamRound>> getGoalsTeam(int? idTeam);
    Future<List<TeamStatistic>>getStatisticTeams(int? idTeam, int? idFixtures);
    Future<Map> getGoalsTeam2(int? idTeam);
    Future<Map> getStatisticTeams2(int? idTeam, int? idFixtures);
}