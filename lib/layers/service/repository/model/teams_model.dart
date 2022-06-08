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
  TeamHomeModel? home;
  TeamAwayModel? away;

  Teams(this.home, this.away);

  Teams.fromJson(Map<String, dynamic> json){
    home = json['home'] != null ? TeamHomeModel.fromJson(json['home']) : null;
    away = json['away'] != null ? TeamAwayModel.fromJson(json['away']) : null;
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

class TeamHomeModel{
  int? id;

  TeamHomeModel(this.id);

  TeamHomeModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
  }
}

class TeamAwayModel{
  int? id;

  TeamAwayModel(this.id);

  TeamAwayModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
  }
}

