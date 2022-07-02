
import 'package:club_atlhetica/layers/entities/round.dart';

abstract class Repository{
  getApi(int? id){
    return Future<Round>;
  }
}