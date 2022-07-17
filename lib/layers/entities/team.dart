class TeamRound{
  int? id;

  TeamRound(this.id);

  int? statisticTeams(List? goals, int? idTeam){
    return goals!.first;
  }
}

class TeamStatistic{
  int? idHome;
  int? idAway;
  int? goalsHome;
  int? goalsAway;
  List? statistics;

  TeamStatistic(this.idHome, this.idAway, this.goalsHome, this.goalsAway, this.statistics);
}