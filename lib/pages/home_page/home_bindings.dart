import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/database/db.dart';
import 'package:club_atlhetica/layers/service/repository/statistic_teams_api.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../layers/service/repository/round_api.dart';

class HomeBindings implements Bindings{

  @override
  void dependencies()async{
    Get.lazyPut(() => HomeController(client: http.Client(), repository: Repository(roundDataSource: GetRoundApi(client: http.Client()), teamDataSource: GetStatisticTeamsApi(client: http.Client()))));
  }
}