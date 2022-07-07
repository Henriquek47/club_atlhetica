import 'package:club_atlhetica/layers/entities/team.dart';

class TeamAdapter{

  TeamAdapter._();

  static TeamRound fromJsonGoals(dynamic data){
    return TeamRound(
        data['teams']['home']['id'], data['goals']['home'], data['goals']['away'], data['statistic']
      );
  }
  static TeamStatistic fromJsonStatistic(dynamic data){
    return TeamStatistic(
        data['team']['id'], data['statistics'],
      );
  }

  static Team fromjson(dynamic data){
    return Team(data['teams']['home']['id'], data['statistics']);
  }

}