import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';

class GetRound{
  IRepository? repository;

  GetRound({this.repository});

  nextRounds()async{
    List<Round> round = await repository!.getRounds();
        List<Round> nextRounds = round.where((element) => element.nextGames == null).toList();
        print(nextRounds.length);
        return nextRounds;
  }

  allRounds()async{
    return await repository!.getRounds();
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

