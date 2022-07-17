  DateTime dateTime = DateTime.now();
  final acataual = dateTime.hour;
  final actualYear = dateTime.year;
  final monthNext = dateTime.month + 1;
  final actualMonth = dateTime.month <= 9 ? '0'+dateTime.month.toString() : dateTime.month;
  final actualDay = dateTime.day <= 9 ? '0'+dateTime.day.toString() : dateTime.day;
  final lastDay = dateTime.day + 5;

  //Brasileirão------------------------------------------------------------------------------------------------------------
  
  String setUrlTeams(int? id){
    final String url = 'https://v3.football.api-sports.io/fixtures?team=$id&season=$actualYear&league=71&last=10';
    return url;
  }

  String setUrlTeamsStatistic(List<int> ids){
      final String url = 'https://v3.football.api-sports.io/fixtures?ids=${ids[0]}-${ids[1]}';
    return url;
  }

  final String roundsUrl = 'https://v3.football.api-sports.io//fixtures?league=71&season=$actualYear&to=$actualYear-${lastDay>30 ? monthNext <= 9 ? '0'+ monthNext.toString() : monthNext : actualMonth}-${lastDay <= 9 ? lastDay.toString().padLeft(2, '0') : lastDay}&from=$actualYear-01-01';
  //Brasileirão------------------------------------------------------------------------------------------------------------

  const headers = {
  'x-rapidapi-key': 'eed8207155199a6f783644cd004c18e8',
  'x-rapidapi-host': 'v3.football.api-sports.io'
  };