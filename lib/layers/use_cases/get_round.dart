

import 'package:club_atlhetica/layers/domain/round.dart';
import 'package:club_atlhetica/layers/service/url.dart';

import '../service/repository/repository.dart';

class GetRound{
  Repository? repository;

  GetRound({this.repository});

  execute(int id)async{
    Round round = await repository?.getApi(id);
    round.finishedOrInProgress(round.date!, dateTime);
    return round;
  }
}