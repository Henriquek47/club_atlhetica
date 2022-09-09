import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsNextGames extends GetView<HomeController> {
  const DetailsNextGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> list = ['Chutes', 'Passes', 'Chutes ao gol', 'Escanteios', 'Posse de bola', 'Chutes ao gol', 'Escanteios', 'Chutes ao gol'];
    return Expanded(child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: Get.height * 0.4,
      width: Get.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(() => controller.statistic.isEmpty ? const Center(child: CircularProgressIndicator())
       : 
       Column(children: [
        SizedBox(height: 20,),
        Text('Estatistica das 10 partidas'),
        SizedBox(height: 20,),
        Expanded(
          child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
        return Padding(padding: EdgeInsets.only(top: 20, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('${controller.statistic[0].statisticAway.fouls}', style: TextStyle(fontSize: 12)),
            Center(child: Text(list[index], style: TextStyle(fontSize: 10),)),
            Text('20', style: TextStyle(fontSize: 12)),
          ],
        )); 
       })),
    ]))));
  }
}