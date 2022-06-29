import 'dart:convert';

import 'package:club_atlhetica/layers/domain/round.dart';
import 'package:club_atlhetica/layers/service/repository/model/round_model.dart';
import 'package:club_atlhetica/layers/service/repository/repository.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class GetRoundApi implements Repository {
  late http.Client client = http.Client();

  GetRoundApi({required this.client});

  @override
  getApi(int? id) async {
    http.Response response =
        await client.get(Uri.parse(urlAllNextRound), headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List allRound = body['response'];
      List<RoundModel> round = allRound.map((e) => RoundModel.fromJson(e)).toList();
      //final date = round[id!].fixture?.date;
      //DateTime now = DateTime.parse(date.toString());
      return round;
    } else {
      return Exception('Falha ao tentar conexão');
    }
  }
}
//'${now.hour <= 9 ? now.hour.toString().padLeft(2, '0') : now.hour.toString()}:${now.minute.toString()}',