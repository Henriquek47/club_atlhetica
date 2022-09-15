abstract class TeamDataSource{
    Future<Map> last10RoundsTeam(int? idTeam, int idLeague);
    Future<Map> statisticRound(List<int> ids);
}