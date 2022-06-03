class SoccerMatch{
  Teams? teams;
  Goals? goals;

  SoccerMatch({this.teams});

  SoccerMatch.fromJson(Map<String, dynamic> json) {
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
    teams = json['teams'] != null ? Teams.fromJson(json['teams']) : null;
  }
}

class Teams{
  TeamHome? home;
  TeamAway? away;

  Teams(this.home, this.away);

  Teams.fromJson(Map<String, dynamic> json){
    home = json['home'] != null ? TeamHome.fromJson(json['home']) : null;
    away = json['away'] != null ? TeamAway.fromJson(json['away']) : null;
  }
}

class Goals{
  int? home;
  int? away;

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
  String? nome;

  TeamAway(this.nome);

  TeamAway.fromJson(Map<String, dynamic> json){
    nome = json['name'];
  }
}

