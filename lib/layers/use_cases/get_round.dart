import 'package:clock/clock.dart';
import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';

class GetRound{
  IRepository? repository;

  GetRound({this.repository});

  getAllRounds(int idLeague)async{
    return await repository!.getRounds(idLeague);
  }

  nextRounds(int idLeague)async{
    List<Round> round = await getAllRounds(idLeague);
        List<Round> nextRounds = round.where((element) => element.nextGames == null && DateTime.parse(element.date!).isAfter(clock.now())).toList();
        return nextRounds;
  }

  beforeRounds(int idLeague)async{
    List<Round> round = await getAllRounds(idLeague);
    List<Round> nextRounds = round.where((element) => DateTime.parse(element.date!).isBefore(clock.now()) && element.nextGames != null).toList();
    return nextRounds.reversed.toList();
  }
}

