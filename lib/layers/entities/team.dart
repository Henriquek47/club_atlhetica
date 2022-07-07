class Team{
  int? id;
  List? statistics;

  Team(this.id, this.statistics);
}

class TeamRound{
  int? id;
  int? goalsHome;
  int? goalsAway;
  List? statistics;

  TeamRound(this.id, this.goalsHome, this.goalsAway, this.statistics);

  int? statisticTeams(List? goals, int? idTeam){
    return goals!.first;
  }
}

class TeamStatistic{
  int? id;
  List? statistics;

  TeamStatistic(this.id, this.statistics);
}