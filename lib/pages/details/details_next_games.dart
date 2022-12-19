import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsNextGames extends GetView<HomeController> {
  const DetailsNextGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> list = ['Goals', 'Chures no gol', 'Defesas', 'Posse de bola', 'Escanteio', 'Faltas', 'Cartão amarelo', 'Cartão Vermelho'];
    return Expanded(child: Obx(() => Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: Get.height * 0.4,
      width: Get.width * 0.8,
      decoration: BoxDecoration(
        color: controller.darkBool.value ?Colors.grey[850] : Colors.green[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: controller.statisticHome.isEmpty || controller.statisticAway.isEmpty ?
      Center(child: CircularProgressIndicator(color: controller.darkBool.value ? Theme.of(context).primaryColor : Colors.white,))
       : 
       Column(children: [
        const SizedBox(height: 20,),
        const Text('Estatística das partidas'),
        const SizedBox(height: 20,),
        Expanded(
          child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
        return Padding(padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('${controller.statisticHome[index]}', style: const TextStyle(fontSize: 12)),
            Center(child: Text(list[index], style: const TextStyle(fontSize: 10),)),
            Text('${controller.statisticAway[index]}', style: const TextStyle(fontSize: 12)),
          ],
        )); 
       })),
    ]))));
  }
}