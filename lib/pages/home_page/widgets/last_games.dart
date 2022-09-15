import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../layers/entities/round.dart';

class LastGames extends GetView<HomeController> {
  const LastGames({Key? key}) : super(key: key);

  String data(int index){
    var data = DateTime.parse(controller.roundAll[index].date!);
    String dataFormat = '${data.day <= 9 ? data.day.toString().padLeft(2, '0') : data.day}-${data.month <= 9 ? data.month.toString().padLeft(2, '0') : data.month}';
    return dataFormat;
  }

  @override
  Widget build(BuildContext context) {  
    return Expanded(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.only(left: 20),
        child: Text('Resultado dos jogos', style: TextStyle(fontSize: Get.textScaleFactor * 20),)),
        const SizedBox(height: 10,),
      Expanded(child: Obx(() => ListView.builder(
        itemCount: controller.roundAll.length,
        itemBuilder: ((context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20),
        child: Column(children: [
        Row(
        children: [
          Padding(padding: const EdgeInsets.only(top: 15),
          child: Container(
            color: controller.roundAll[index].winner != 'Analisando' ? Colors.red : Colors.blue,
            height: 35,
            width: 4,
          )),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Data: ${data(index)}', style: TextStyle(fontSize: Get.textScaleFactor * 14, fontWeight: FontWeight.normal, height: 2)),
            Row(
              children: [
              Text(controller.roundAll[index].nameHome!.length > 19 ? '${controller.roundAll[index].nameHome!.substring(0,19)}...' : controller.roundAll[index].nameHome!,
                style: TextStyle(fontSize: Get.textScaleFactor * 13, fontWeight: FontWeight.normal), ),
              const SizedBox(width: 5,),
              Text(controller.roundAll[index].goalsHome != null ? '${controller.roundAll[index].goalsHome} x ${controller.roundAll[index].goalsAway}' : '0 x 0', style: TextStyle(fontSize: Get.textScaleFactor * 15, fontWeight: FontWeight.w500),),
              const SizedBox(width: 5,),
                Container(
                  width: Get.width * 0.35,
                color: Colors.transparent,
                child: Text(controller.roundAll[index].nameAway!, style: TextStyle(fontSize: Get.textScaleFactor * 13, fontWeight: FontWeight.normal), overflow: TextOverflow.fade, maxLines: 1, softWrap: false,),),
            ],)
          ]),
        ],
      ),
      const SizedBox(height: 8,),
      const Divider(color: Colors.white70, indent: 25, endIndent: 20, thickness: 1.5,)
      ]));
    }))))]));
  }
}