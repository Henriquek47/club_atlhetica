import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextGames extends GetView<HomeController> {
  const NextGames({Key? key}) : super(key: key);

  String data(int index){
    var data = DateTime.parse(controller.roundNext[index].date!);
    String dataFormat = '${data.day <= 9 ? data.day.toString().padLeft(2, '0') : data.day}-${data.month <= 9 ? data.month.toString().padLeft(2, '0') : data.month}';
    return dataFormat;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.5,
                   width: Get.width,
                  child: Obx(() => PageView.builder(
      itemCount: controller.roundNext.length,
      itemBuilder: (conxtext, index){
                return Stack(children: [
                    Align(
                      alignment: const Alignment(0, -0.9),
                      child: Text('Club Athletica', style: TextStyle(fontSize: Get.textScaleFactor * 10),),
                    ),
                    Padding(padding: EdgeInsets.only(top: Get.height * 0.155),
                  child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Image.network(controller.roundNext[index].imageHome!, fit: BoxFit.cover, scale: 1.8,),
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
              Text('Provavel vencedor\n${controller.roundNext[index].winner}', textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
            ]),
            Column(
              children: [
            Image.network(controller.roundNext[index].imageAway!, scale: 1.8,),
            const SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.2,
              color: Colors.transparent,
              child: Text(controller.roundNext[index].nameAway!, textAlign: TextAlign.center, style: TextStyle(fontSize: Get.textScaleFactor * 12)))
            ])]
        ),
        const SizedBox(height: 10),
        Column(
          children:  [
          GestureDetector(child: const Text('Provavel', style: TextStyle(fontSize: 14)),),
          const SizedBox(height: 10,),
          Text(controller.roundNext[index].winner!, style: const TextStyle(fontSize: 15),),
          const SizedBox(height: 10,),
          const Text('Ver mais', style: TextStyle(fontSize: 12),)
        ]),
      ]
    ))]);
  })));
  }
}