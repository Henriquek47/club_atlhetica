import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/repository/round_api.dart';
import 'package:club_atlhetica/layers/service/repository/statistic_teams_api.dart';
import 'package:club_atlhetica/layers/service/workmanager/notification.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;

  void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'fetchBackground':
      print('teste');
      HomeController homeController = HomeController(client: http.Client(), repository: Repository(roundDataSource: GetRoundApi(client: http.Client()), teamDataSource: GetStatisticTeamsApi(client: http.Client())));
      int statistic = await homeController.statisticsTeam();
      //print('aquuiiiiii $statistic');
      if(statistic == 0){
        NotifcationServirce notifcationServirce = NotifcationServirce();
        notifcationServirce.showNotification(CustomNotification(id: 1, title: 'home', body: 'acesse', payload: 'aaaa'));
      }else if(statistic == 1){
        NotifcationServirce notifcationServirce = NotifcationServirce();
        notifcationServirce.showNotification(CustomNotification(id: 1, title: 'away', body: 'acesse', payload: 'aaaa'));
      }else{
        NotifcationServirce notifcationServirce = NotifcationServirce();
        notifcationServirce.showNotification(CustomNotification(id: 1, title: 'empate', body: 'acesse', payload: 'aaaa'));
      }
        break;
    }
    print('testefail');
    return Future.value(true);
  });
}