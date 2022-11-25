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
      data['statistics'][0]['value'] ?? 0, data['statistics'][1]['value'] ?? 0, data['statistics'][2]['value'] ?? 0, data['statistics'][3]['value'] ?? 0,
      data['statistics'][4]['value']?? 0, data['statistics'][5]['value']?? 0, data['statistics'][6]['value']?? 0, data['statistics'][7]['value'] ?? 0, 
      data['statistics'][8]['value']?? 0, data['statistics'][9]['value']?? '0', data['statistics'][10]['value']?? 0, data['statistics'][11]['value']?? 0, 
      data['statistics'][12]['value']?? 0, data['statistics'][13]['value']?? 0, data['statistics'][14]['value']?? 0, data['statistics'][15]['value']?? 0);
  }
}