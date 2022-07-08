import 'dart:convert';

import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/adapter/team_adapter.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:http/http.dart' as http;

import '../../infra/datadource/team_datasource.dart';


class GetStatisticTeamsApi extends TeamDataSource{

  http.Client? client = http.Client();

  GetStatisticTeamsApi({this.client});
  
  @override
  getGoalsTeam(int? idTeam)async{
    http.Response response = await client!.get(Uri.parse(setUrlTeams(idTeam)), headers: headers);
    if(response.statusCode == 200){
    var body = jsonDecode(response.body);
     return body; 
    }else{
      Exception('Falha na conexão');
      return {};
    }
  }
  @override
  getStatisticTeams(int? idTeam, int? idFixtures)async{
    http.Response response = await client!.get(Uri.parse(setUrlTeamsStatistic(idTeam, idFixtures)), headers: headers);
    if(response.statusCode == 200){
    var body = jsonDecode(response.body);
     return body; 
    }else{
      Exception('Erro na conexão');
      return {};
    }
  }
}