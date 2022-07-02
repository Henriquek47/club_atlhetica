import 'dart:convert';

import 'package:club_atlhetica/layers/adapter/team_adapter.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/service/repository/repository.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:http/http.dart' as http;


class GetStatisticTeamsApi implements Repository{

  http.Client? client = http.Client();

  GetStatisticTeamsApi({this.client});

  @override
  getApi(int? idTeam)async{
    http.Response response = await client!.get(Uri.parse(setUrlTeams(idTeam)), headers: headers);
    if(response.statusCode == 200){
    var body = jsonDecode(response.body);
    List team = body['response'];
    List<Team> allRoundTeam = team.map((e) => TeamAdapter.fromJson(e)).toList();
     return allRoundTeam; 
    }else{
      return Exception('Falha na conexão');
    }
  }
}