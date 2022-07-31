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
  Statistic statisticHome;
  Statistic statisticAway;

  TeamStatistic(
    this.idHome, this.idAway, this.goalsHome, this.goalsAway, this.statisticHome, this.statisticAway);
}

class Statistic{
  int? idTeam;
  int? goalsHome;
  int? goalsAway;
  int? shotsOnGoal;
  int? shotsOffGoal;
  int? totalShots;
  int? blockedShots;
  int? shotsInsideBox;
  int? shotsOutsideBox;
  int? fouls;
  int? cornerKicks;
  int? offSides;
  String? ballPossession;
  int? yellowCards;
  int? redCards;
  int? goalkeeperSaves;
  int? totalPasses;
  int? passesAcurate;
  String? percPasses;

  Statistic(this.idTeam, this.shotsOnGoal, this.shotsOffGoal,
    this.totalShots, this.blockedShots, this.shotsInsideBox, this.shotsOutsideBox, this.fouls,
    this.cornerKicks, this.offSides, this.ballPossession, this.yellowCards, this.redCards, this.goalkeeperSaves,
    this.totalPasses, this.passesAcurate, this.percPasses,);
}