import '../entities/round.dart';

class RoundAdapter{

  RoundAdapter._();

  static Round fromJson(dynamic data){
    return Round(
      data['fixture']['id'], data['fixture']['date'], data['goals']['home'], data['goals']['away'], data['teams']['home']['name'], data['teams']['home']['logo'],
      data['teams']['away']['name'], data['teams']['away']['home'], data['teams']['home']['id'], data['teams']['away']['id']
      );
  }
}