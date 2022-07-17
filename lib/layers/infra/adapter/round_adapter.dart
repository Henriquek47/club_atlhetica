
import '../../entities/round.dart';

class RoundAdapter{

  RoundAdapter._();

  static Round fromJson(dynamic data){
    return Round(
      data['fixture']['id'], data['fixture']['date'], data['teams']['home']['name'], data['teams']['home']['logo'],
      data['teams']['away']['name'], data['teams']['away']['logo'], data['teams']['home']['id'], data['teams']['away']['id']
      );
  }
}