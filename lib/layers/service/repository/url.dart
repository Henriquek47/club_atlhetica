  DateTime dateTime = DateTime.now();
  final acataual = dateTime.hour;
  final actualYear = dateTime.year;
  final actualMonth = dateTime.month <= 9 ? '0'+dateTime.month.toString() : dateTime.month;
  final actualDay = dateTime.day <= 9 ? '0'+dateTime.day.toString() : dateTime.day;
  final lastDay = dateTime.day + 5;

  //Brasileirão------------------------------------------------------------------------------------------------------------
  
  String setUrlTeams(int? id){
    final String url = 'https://v3.football.api-sports.io/fixtures?team=$id&season=$actualYear&league=71&last=10';
    return url;
  }

  String setUrlTeamsStatistic(int? idTeam, int? idFixtures){
    final String url = 'https://v3.football.api-sports.io/fixtures/statistics?fixture=$idFixtures&team=$idTeam';
    return url;
  }

  final String urlAllNextRound = 'https://v3.football.api-sports.io/fixtures?season=$actualYear&from=$actualYear-$actualMonth-$actualDay&to=$actualYear-$actualMonth-${lastDay <= 9 ? lastDay.toString().padLeft(2, '0') : lastDay}&league=71';
  
  //Brasileirão------------------------------------------------------------------------------------------------------------

  const headers = {
  'x-rapidapi-key': 'eed8207155199a6f783644cd004c18e8',
  'x-rapidapi-host': 'v3.football.api-sports.io'
  };