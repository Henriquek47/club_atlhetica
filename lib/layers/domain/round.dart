class Round{
  int? id;
  DateTime? date;
  String? nameHome;
  String? imageHome;
  String? nameAway;
  String? imageAway;
  int? home;
  int? away;
  String? hour;
  List round;

  Round(this.id, this.date, this.nameHome, this.imageHome, this.nameAway, this.imageAway, this.home, this.away, this.hour, this.round);

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