import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../layers/entities/round.dart';

class LastGames extends StatelessWidget {
  final AsyncSnapshot<List<Round>> snapshot;
  const LastGames({Key? key, required this.snapshot}) : super(key: key);

  String data(int index){
    var data = DateTime.parse(snapshot.data![index].date!);
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
      Expanded(child: ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20),
        child: Column(children: [
        Row(
        children: [
          Padding(padding: const EdgeInsets.only(top: 15),
          child: Container(
            color: index >= 2 ? Colors.red : Colors.blue,
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
              Text(snapshot.data![index].nameHome!, style: TextStyle(fontSize: Get.textScaleFactor * 13, fontWeight: FontWeight.normal)),
              const SizedBox(width: 5,),
              Text('1 x 1 ', style: TextStyle(fontSize: Get.textScaleFactor * 15, fontWeight: FontWeight.w500),),
              const SizedBox(width: 5,),
              Text(snapshot.data![index].nameAway!, style: TextStyle(fontSize: Get.textScaleFactor * 13, fontWeight: FontWeight.normal),),
              SizedBox(width: Get.width * 0.2,),
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