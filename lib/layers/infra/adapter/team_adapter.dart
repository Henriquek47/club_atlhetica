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
        data['teams']['home']['id'], data['teams']['away']['id'], data['goals']['home'], data['goals']['away'], TeamAdapter.fromStatistic(data['statistics'][0]),
        TeamAdapter.fromStatistic(data['statistics'][1]),
      );
  }
  static Statistic fromStatistic(dynamic data){
    return Statistic(
      data['team']['id'],
      data['statistics'][0]['value'], data['statistics'][1]['value'], data['statistics'][2]['value'], data['statistics'][3]['value'],
      data['statistics'][4]['value'], data['statistics'][5]['value'], data['statistics'][6]['value'], data['statistics'][7]['value'], 
      data['statistics'][8]['value'], data['statistics'][9]['value'], data['statistics'][10]['value'], data['statistics'][11]['value'], 
      data['statistics'][12]['value'], data['statistics'][13]['value'], data['statistics'][14]['value'], data['statistics'][15]['value']);
  }
}