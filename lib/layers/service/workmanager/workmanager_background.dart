import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/service/workmanager/notification.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:workmanager/workmanager.dart';

  void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'fetchBackground':
      print('teste');
      HomeController homeController = HomeController();
      List<TeamStatistic> statistic = await homeController.statisticsTeam();
      print(statistic);
      if(statistic.isNotEmpty){
        NotifcationServirce notifcationServirce = NotifcationServirce();
        notifcationServirce.showNotification(CustomNotification(id: 1, title: 'teste', body: 'acesse', payload: 'aaaa'));
      }
        break;
    }
    return Future.value(true);
  });
}