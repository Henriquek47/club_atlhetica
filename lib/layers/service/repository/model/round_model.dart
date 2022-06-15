class RoundModel{
  Fixture? fixture;
  Teams? teams;

  RoundModel({this.teams});

  RoundModel.fromJson(Map<String, dynamic> json) {
    fixture = json['fixture'] != null ? Fixture.fromJson(json['fixture']) : null;
    teams = json['teams'] != null ? Teams.fromJson(json['teams']) : null;
  }
}

class Fixture{
  int? id;
  String? date;

  Fixture(this.id, this.date);

  Fixture.fromJson(Map<String, dynamic> json){
    id = json['id'];
    date = json['date'];
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

class TeamHome{
  int? id;
  String? nome;
  String? imageHome;

  TeamHome(this.nome, this.id);

  TeamHome.fromJson(Map<String, dynamic> json){
    nome = json['name'];
    id = json['id'];
  }
}

class TeamAway{
  int? id;
  String? nome;
  String? imageaway;

  TeamAway(this.nome, this.id);

  TeamAway.fromJson(Map<String, dynamic> json){
    nome = json['name'];
    id = json['id'];
  }
}