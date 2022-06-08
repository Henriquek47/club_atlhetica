import '../../domain/round.dart';

abstract class Repository{
  getApi(int? id){
    return Future<Round>;
  }
}