import 'dart:convert';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../infra/datadource/team_datasource.dart';


class GetStatisticTeamsApi extends TeamDataSource{

  http.Client client = http.Client();

  GetStatisticTeamsApi({required this.client});
  
  @override
  last10RoundsTeam(int? idTeam)async{
    http.Response response = await client.get(Uri.parse(setUrlTeams(idTeam)), headers: headers);
    if(response.statusCode == 200){
    var body = jsonDecode(response.body);
    print('teamRound');
     return body; 
    }else{
      Exception('Falha na conexão');
      return {};
    }
  }
  @override
  statisticRound(List<int> ids)async{
    http.Response response = await client.get(Uri.parse(setUrlTeamsStatistic(ids)), headers: headers);
    if(response.statusCode == 200){
    var body = jsonDecode(response.body);
    print('statistic');
     return body; 
    }else{
      Exception('Erro na conexão');
      return {};
    }
  }
}