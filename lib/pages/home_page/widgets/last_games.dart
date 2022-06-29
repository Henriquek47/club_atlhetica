import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LastGames extends StatelessWidget {
  const LastGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.only(left: 20),
        child: Text('Resultado dos jogos', style: TextStyle(fontSize: Get.textScaleFactor * 20),)),
        const SizedBox(height: 10,),
      Expanded(child: ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20),
        child: Column(children: [
        Row(
        children: [
          Container(
            color: index >= 2 ? Colors.red : Colors.blue,
            height: 35,
            width: 4,
          ),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Data: 23/02', style: TextStyle(fontSize: Get.textScaleFactor * 14, fontWeight: FontWeight.w500, height: 2)),
            Row(
              children: [
              Text('Atletico-MG ', style: TextStyle(fontSize: Get.textScaleFactor * 15, fontWeight: FontWeight.w500)),
              const SizedBox(width: 5,),
              Text('1 x 1 ', style: TextStyle(fontSize: Get.textScaleFactor * 15, fontWeight: FontWeight.w500),),
              const SizedBox(width: 5,),
              Text('Sport', style: TextStyle(fontSize: Get.textScaleFactor * 15, fontWeight: FontWeight.w500),),
              SizedBox(width: Get.width * 0.2,),
              Text('Ver mais', style: TextStyle(fontSize: Get.textScaleFactor * 10),)
            ],)
          ]),
        ],
      ),
      const SizedBox(height: 8,),
      const Divider(color: Colors.white70, indent: 25, endIndent: 20, thickness: 1.5,)
      ]));
    })))]));
  }
}