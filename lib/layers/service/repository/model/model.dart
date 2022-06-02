class SoccerMatch{
  late Teams teams;
  late Goals goals;

  SoccerMatch(this.teams, this.goals);

  SoccerMatch.fromJson(Map<String, dynamic> json) {
    goals = json['goals'];
    teams = json['teams'];
  }
}

class Teams{
  late TeamHome home;
  late TeamAway away;

  Teams(this.home, this.away);

  Teams.fromJson(Map<String, dynamic> json){
    home = json['home'];
    away = json['away'];
  }
}

class Goals{
  late int home;
  late int away;

  Goals(this.home, this.away);

  Goals.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }
}

class TeamHome{
  String? nome;

  TeamHome(this.nome);

  TeamHome.fromJson(Map<String, dynamic> json){
    nome = json['name'];
  }
}

class TeamAway{
  late String nome;

  TeamAway(this.nome);

  TeamAway.fromJson(Map<String, dynamic> json){
    nome = json['name'];
  }
}

