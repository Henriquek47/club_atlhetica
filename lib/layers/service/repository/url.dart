  DateTime dateTime = DateTime.now();
  final acataual = dateTime.hour;
  final actualYear = dateTime.year;
  final monthNext = dateTime.month + 1;
  final actualMonth = dateTime.month <= 9 ? '0'+dateTime.month.toString() : dateTime.month;
  final actualDay = dateTime.day <= 9 ? '0'+dateTime.day.toString() : dateTime.day;
  final lastDay = dateTime.day + 15;

  
  String setUrlTeams(int? id){
    final String url = 'https://v3.football.api-sports.io/fixtures?team=$id&season=$actualYear&last=10';
    return url;
  }

  String setUrlTeamsStatistic(String id){
      final String url = 'https://v3.football.api-sports.io/fixtures?ids=$id';
    return url;
  }

  String setUrlLeagues(int idLeague, int season){
    'https://v3.football.api-sports.io//fixtures?league=475&season=2023&to=2023-01-17&from=2023-01-01';
    final String roundsUrl = 'https://v3.football.api-sports.io//fixtures?league=$idLeague&season=$season&to=$actualYear-${lastDay>30 ? monthNext <= 9 ? '0'+ monthNext.toString() : monthNext : actualMonth}-${lastDay <= 9 ? lastDay.toString().padLeft(2, '0') : lastDay}&from=$actualYear-$actualMonth-01';
    return roundsUrl;
    
  }

  const headers = {
  'x-rapidapi-key': 'eed8207155199a6f783644cd004c18e8',
  'x-rapidapi-host': 'v3.football.api-sports.io'
  };