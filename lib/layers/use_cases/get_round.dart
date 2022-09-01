import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';

class GetRound{
  IRepository? repository;

  GetRound({this.repository});

  getAllRounds()async{
    return await repository!.getRounds();
  }

  nextRounds()async{
    List<Round> round = await getAllRounds();
        List<Round> nextRounds = round.where((element) => element.nextGames == null && DateTime.parse(element.date!).isAfter(dateTime)).toList();
        return nextRounds;
  }

  beforeRounds()async{
    List<Round> round = await getAllRounds();
    List<Round> nextRounds = round.where((element) => element.nextGames != null).toList();
    return nextRounds;
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

