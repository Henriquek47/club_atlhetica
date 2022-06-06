class Round{
  int? id;
  DateTime date;
  String? home;
  String? away;
  String? hour;

  Round(this.id, this.date, this.home, this.away, this.hour);

  finishedOrInProgress(DateTime hour){
    DateTime now = DateTime.now();
    if(now == hour){
      return true;
    }else{
      return false;
    }
  }  
}