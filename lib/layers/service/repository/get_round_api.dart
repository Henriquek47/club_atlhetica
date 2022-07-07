import 'dart:convert';

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/adapter/round_adapter.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:http/http.dart' as http;

import '../../infra/datadource/round_datasource.dart';

class GetRoundApi extends RoundDataSource{
  late http.Client client = http.Client();

  GetRoundApi({required this.client});

  @override
  getApi(int? id) async {
    http.Response response =
        await client.get(Uri.parse(urlAllNextRound), headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List allRound = body['response'];
      List<Round> round = allRound.map((e) => RoundAdapter.fromJson(e)).toList();
      //final date = round[id!].fixture?.date;
      //DateTime now = DateTime.parse(date.toString());
      return round;
    } else {
      return Exception('Falha ao tentar conexão');
    }
  }
}
//'${now.hour <= 9 ? now.hour.toString().padLeft(2, '0') : now.hour.toString()}:${now.minute.toString()}',