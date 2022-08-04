import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/database/db.dart';
import 'package:club_atlhetica/layers/service/repository/statistic_teams_api.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../../layers/service/repository/round_api.dart';

class HomeBindings implements Bindings{

  http.Client client = http.Client();
  Database? db = DB.instance.database;

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(client: http.Client(), repository: Repository(roundDataSource: GetRoundApi(client: client), teamDataSource: GetStatisticTeamsApi(client: client), db: db)));
  }
}