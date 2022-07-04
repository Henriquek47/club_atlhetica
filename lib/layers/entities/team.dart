class Team{
  int? idHome;
  int? idAway;
  int? goalsHome;
  int? goalsAway;

  Team(this.idHome, this.idAway, this.goalsHome, this.goalsAway);

  int? statisticTeams(List? goals, int? idTeam){
    print(goals);
    return goals!.first;
  }
}