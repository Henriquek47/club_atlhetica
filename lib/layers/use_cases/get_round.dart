import 'package:club_atlhetica/layers/infra/repository/repository.dart';

class GetRound{
  IRepository? repository;

  GetRound({this.repository});

  execute()async{
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

