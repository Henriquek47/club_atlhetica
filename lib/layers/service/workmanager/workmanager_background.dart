import 'package:club_atlhetica/layers/service/workmanager/notification.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:workmanager/workmanager.dart';

  void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'fetchBackground':
      print('teste');
      HomeController homeController = HomeController();
        NotifcationServirce notifcationServirce = NotifcationServirce();
        notifcationServirce.showNotification(CustomNotification(id: 1, title: 'teste', body: 'acesse', payload: 'aaaa'));
        break;
    }
    return Future.value(true);
  });
}