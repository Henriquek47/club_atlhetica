class Round{
  int? id;
  String? date;
  String? nameHome;
  String? imageHome;
  String? nameAway;
  String? imageAway;
  int? idHome;
  int? idAway;
  int? nextGames;
  bool? notification;
  String? winner;
  int? goalsAway;
  int? goalsHome;

  Round(this.id, this.date, this.nameHome, this.imageHome, this.nameAway, this.imageAway, this.idHome, this.idAway, this.nextGames, this.notification, this.winner, this.goalsAway, this.goalsHome);
}