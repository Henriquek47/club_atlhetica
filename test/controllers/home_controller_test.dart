import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test homController', ()async{
   HomeController homeController = HomeController();
   List<TeamStatistic> home = await homeController.statisticsTeam();
  },
  timeout: const Timeout(Duration(seconds: 31)));
}