import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextGames extends GetView<HomeController> {
  const NextGames({Key? key}) : super(key: key);

  String data(int index){
    var data = DateTime.parse(controller.roundNext[index].date!);
    String dataFormat = '${data.day <= 9 ? data.day.toString().padLeft(2, '0') : data.day}-${data.month <= 9 ? data.month.toString().padLeft(2, '0') : data.month}';
    String format24hour = data.hour.isEqual(0) ? ('${data.day <= 9 ? (data.day-1).toString().padLeft(2, '0') : data.day - 1}-${data.month <= 9 ? data.month.toString().padLeft(2, '0') : data.month}').toString() : dataFormat;
    return format24hour;
  }

  String hour(int index){
    var data = DateTime.parse(controller.roundNext[index].date!);
    int hour = data.hour.isEqual(0) ? (data.hour + 24) - 3 : data.hour - 3;
    String dataFormat = '${hour <= 9 ? hour.toString().padLeft(2, '0') : hour}:${data.minute <= 9 ? data.minute.toString().padLeft(2, '0') : data.minute}';
    return dataFormat;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.45,
                   width: Get.width,
                  child: Obx(() {
                    if(controller.roundNext.isEmpty){
                      return const Center(child: Text('Sem jogos no momento'));
                    }else{
                    return PageView.builder(
                    onPageChanged: ((value) => controller.details.value = false),
      itemCount: controller.roundNext.length,
      itemBuilder: (conxtext, index){
                return Stack(children: [
                    Align(
                      alignment: const Alignment(0, -0.9),
                      child: Text('Club Athletica', style: TextStyle(fontSize: Get.textScaleFactor * 10),),
                    ),
                    Padding(padding: EdgeInsets.only(top: Get.height * 0.155),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
               SizedBox(
              height: Get.height * 0.1,
              width: Get.width * 0.3,
              child:Image.network(controller.roundNext[index].imageHome!, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                return const Center(child: CircularProgressIndicator());
              })),
              const SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.2,
              color: Colors.transparent,
              child: Text(controller.roundNext[index].nameHome!, textAlign: TextAlign.center, style: TextStyle(fontSize: Get.textScaleFactor * 12),)),
        ]),
            Column(children: [
              const Text('Data do jogo'),
              const SizedBox(height: 5,),
              Text(data(index), style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 5,),
              Text('Provavel vencedor\n${controller.roundNext[index].winner ?? 'Analisando'}', textAlign: TextAlign.center,style: const TextStyle(fontSize: 12),),
            ]),
            Column(
              children: [
            SizedBox(
              height: Get.height * 0.1,
              width: Get.width * 0.3,
              child:
            Image.network(controller.roundNext[index].imageAway!, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                return const Center(child: CircularProgressIndicator());
              })),
            const SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.2,
              color: Colors.transparent,
              child: Text(controller.roundNext[index].nameAway!, textAlign: TextAlign.center, style: TextStyle(fontSize: Get.textScaleFactor * 12)))
            ])]
        ),
        const SizedBox(height: 5),
        Column(
          children:  [
          GestureDetector(child: const Text('Horário', style: TextStyle(fontSize: 14)),),
          const SizedBox(height: 5,),
          Text(hour(index), style: const TextStyle(fontSize: 15),),
          const SizedBox(height: 5,),
          GestureDetector(
            onTap: ()async{
              controller.details.value = !controller.details.value;
              if(controller.details.value){
                await controller.statisticTeamHome(controller.roundNext[index].idHome);
                await controller.statisticTeamAway(controller.roundNext[index].idAway);
              }
            },
            child: const Text('Ver mais', style: TextStyle(fontSize: 12))),
             const SizedBox(height: 5,),
          GestureDetector(
            onTap: ()async{
              print(controller.roundNext[index].id );
              print(controller.roundNext[index].winner);
              if(controller.roundNext[index].id != null){
                controller.showRewardedAd(controller.roundNext[index].idHome, controller.roundNext[index].idAway, controller.roundNext[index].nameHome!,controller.roundNext[index].nameAway!, controller.roundNext[index].id!);
              }else{
                Get.snackbar('ERROR', 'ERROR');
              }
            },
            child: const Text('Ver previsão', style: TextStyle(fontSize: 12))),
        ]),
      ]
    ))]);
  });}}));
  }
}