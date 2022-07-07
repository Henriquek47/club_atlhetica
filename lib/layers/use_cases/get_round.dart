import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/datadource/round_datasource.dart';
import 'package:club_atlhetica/layers/service/repository/get_round_api.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';


class GetRound{
  RoundDataSource? repository;

  GetRound({this.repository});

  execute(int id)async{
    List<Round> round = await repository?.getApi(id);
    final date = round[id].date;
    DateTime now = DateTime.parse(date.toString());
    bool fisnishOrProgress = finishedOrInProgress(now, dateTime);
    return round;
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

