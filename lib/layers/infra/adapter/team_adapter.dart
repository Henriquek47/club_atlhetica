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
        data['teams']['home']['id'], data['teams']['away']['id'], data['goals']['home'], data['goals']['away'], TeamAdapter.fromStatistic(data, 0),
        TeamAdapter.fromStatistic(data, 1),
      );
  }
  static Statistic fromStatistic(dynamic data, int index){
    if(data['statistics'] == null  || data['statistics'] == []){
      return Statistic(0, 0, 0, 0, 0, 0, 0, 0, 0, '0', 0, 0, 0, 0, 0, '0');
    }else{
      return Statistic(
        data['statistics'][index]['statistics'][0]['value'] , data['statistics'][index]['statistics'][1]['value'] , data['statistics'][index]['statistics'][2]['value'] , data['statistics'][index]['statistics'][3]['value'] ,
        data['statistics'][index]['statistics'][4]['value'], data['statistics'][index]['statistics'][5]['value'], data['statistics'][index]['statistics'][6]['value'], data['statistics'][index]['statistics'][7]['value'] , 
        data['statistics'][index]['statistics'][8]['value'], data['statistics'][index]['statistics'][9]['value']?? '0', data['statistics'][index]['statistics'][10]['value'], data['statistics'][index]['statistics'][11]['value'], 
        data['statistics'][index]['statistics'][12]['value'], data['statistics'][index]['statistics'][13]['value'], data['statistics'][index]['statistics'][14]['value'], data['statistics'][index]['statistics'][15]['value']);
    }
  }
}