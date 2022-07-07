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
    List team = body['response'];
    List<TeamRound> allRoundTeam = team.map((e) => TeamAdapter.fromJsonGoals(e)).toList();
     return allRoundTeam; 
    }else{
      Exception('Falha na conexão');
      return [];
    }
  }
  @override
  getStatisticTeams(int? idTeam, int? idFixtures)async{
    http.Response response = await client!.get(Uri.parse(setUrlTeamsStatistic(idTeam, idFixtures)), headers: headers);
    if(response.statusCode == 200){
    var body = jsonDecode(response.body);
    List team = body['response'];
    List<TeamStatistic> allStatisticTeamOnFixtures = team.map((e) => TeamAdapter.fromJsonStatistic(e)).toList();
     return allStatisticTeamOnFixtures; 
    }else{
      Exception('Erro na conexão');
      return [];
    }
  }
  @override
  getGoalsTeam2(int? idTeam)async{
    http.Response response = await client!.get(Uri.parse(setUrlTeams(idTeam)), headers: headers);
    if(response.statusCode == 200){
    var body = jsonDecode(response.body);
    List team = body['response'];
     return body; 
    }else{
      Exception('Falha na conexão');
      return {};
    }
  }
  @override
  getStatisticTeams2(int? idTeam, int? idFixtures)async{
    http.Response response = await client!.get(Uri.parse(setUrlTeamsStatistic(idTeam, idFixtures)), headers: headers);
    if(response.statusCode == 200){
    var body = jsonDecode(response.body);
    List team = body['response'];
     return body; 
    }else{
      Exception('Erro na conexão');
      return {};
    }
  }
}