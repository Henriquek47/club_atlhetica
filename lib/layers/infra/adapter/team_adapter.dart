import 'package:club_atlhetica/layers/entities/team.dart';

class TeamAdapter{

  TeamAdapter._();

  static TeamRound fromJsonGoals(dynamic data){
    return TeamRound(
        data['fixture']['id']
      );
  }
  static TeamStatistic fromJsonStatistic(dynamic data){
    return TeamStatistic(
        data['teams']['home']['id'], data['teams']['away']['id'], data['goals']['home'], data['goals']['away'], data['statistics']
      );
  }

}