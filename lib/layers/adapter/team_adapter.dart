import 'package:club_atlhetica/layers/entities/team.dart';

class TeamAdapter{

  TeamAdapter._();

  static Team fromJson(dynamic data){
    return Team(
        data['teams']['home']['id'], data['teams']['away']['id'], data['goals']['home'], data['goals']['away']
      );
  }
}