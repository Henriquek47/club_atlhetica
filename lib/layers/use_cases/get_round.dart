
import 'package:club_atlhetica/layers/domain/round.dart';

import '../service/repository/repository.dart';

class GetRound{
  Repository repository;

  GetRound(this.repository);

  execute(int id){
    Round round = repository.getRoundApi(id);
    return (round.golsHome + round.golsAway);
  }
}