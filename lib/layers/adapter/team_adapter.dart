import 'package:club_atlhetica/layers/entities/team.dart';

import '../entities/round.dart';

class TeamAdapter{

  TeamAdapter._();

  static Team fromJson(dynamic data){
    return Team(
        data['teams']['home']['id'], data['goals']['home']
      );
  }
}