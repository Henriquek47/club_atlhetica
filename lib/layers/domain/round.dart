class Round{
  int? id;
  DateTime? date;
  int? home;
  int? away;
  String? hour;

  Round(this.id, this.date, this.home, this.away, this.hour);

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