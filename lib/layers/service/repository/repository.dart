import '../../domain/round.dart';

abstract class Repository{
  getRoundApi(int id){
    return Future<Round>;
  }
}