import 'dart:convert';

import 'package:club_atlhetica/layers/domain/round.dart';
import 'package:club_atlhetica/layers/service/repository/model/model.dart';
import 'package:club_atlhetica/layers/service/repository/model/round_model.dart';
import 'package:club_atlhetica/layers/service/repository/repository.dart';
import 'package:club_atlhetica/layers/service/url.dart';
import 'package:http/http.dart' as http;



class GetRoundApi implements Repository {
  
  @override
  getRoundApi(int id) async {
    http.Response response = await http.get(Uri.parse(urlAllNextRound), headers: headers);
    var body = jsonDecode(response.body);
    List allRound = body['response'];
    print(body);
    List<RoundModel> round = allRound.map((e) => RoundModel.fromJson(e)).toList();
    return Round(round[0].fixture?.id, 1, 1, 1);
  }

}