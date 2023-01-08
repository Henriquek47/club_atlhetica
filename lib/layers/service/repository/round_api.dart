import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:http/http.dart' as http;

import '../../infra/datadource/round_datasource.dart';

class GetRoundApi extends RoundDataSource{
  final http.Client client;

  GetRoundApi({required this.client});

  @override
  getApi(int idLeague, int season) async {
    http.Response response =
        await client.get(Uri.parse(setUrlLeagues(idLeague, season)), headers: headers);
    if(response.statusCode == 200){
      return response.body;
    }else{
      Exception('Falha na conexão');
      return {};
    }
  }
}
//'${now.hour <= 9 ? now.hour.toString().padLeft(2, '0') : now.hour.toString()}:${now.minute.toString()}',