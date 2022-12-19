abstract class TeamDataSource{
    Future<Map> last10RoundsTeam(int? idTeam);
    Future<Map> statisticRound(String ids);
}