
import 'package:club_atlhetica/layers/domain/round.dart';

import '../service/repository/repository.dart';

class GetRound{
  Repository repository;

  GetRound(this.repository);

  execute(int id)async{
    Round round = await repository.getRoundApi(id);
    round.finishedOrInProgress(round.date);
    return round;
  }
}