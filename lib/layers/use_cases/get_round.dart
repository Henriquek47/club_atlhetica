import 'package:clock/clock.dart';
import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';

class GetRound{
  IRepository? repository;

  GetRound({this.repository});

  getAllRounds()async{
    return await repository!.getRounds();
  }

  nextRounds()async{
    List<Round> round = await getAllRounds();
        List<Round> nextRounds = round.where((element) => element.nextGames == null && DateTime.parse(element.date!).isAfter(clock.now())).toList();
        return nextRounds;
  }

  beforeRounds()async{
    List<Round> round = await getAllRounds();
    List<Round> nextRounds = round.where((element) => DateTime.parse(element.date!).isBefore(clock.now())).toList();
    return nextRounds.reversed.toList();
  }

  finishedOrInProgress(DateTime roundDate, DateTime now){
    if(now.hour >= roundDate.hour){
      if(now.hour == roundDate.hour){
        if(now.minute >= roundDate.minute){
          return true;
        } else{
          return false;
        }
      }else{
        return true;
      }
    }else{
      return false;
    }
  }  
}

