import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextGames extends GetView<HomeController> {
  final AsyncSnapshot<List<Round>> snapshot;
  const NextGames(this.snapshot, {Key? key}) : super(key: key);

  String data(int index){
    var data = DateTime.parse(snapshot.data![index].date!);
    String dataFormat = '${data.day <= 9 ? data.day.toString().padLeft(2, '0') : data.day}-${data.month <= 9 ? data.month.toString().padLeft(2, '0') : data.month}';
    return dataFormat;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.5,
                   width: Get.width,
                  child: PageView.builder(
      itemCount: snapshot.data?.length,
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
              Image.network(snapshot.data![index].imageHome!, fit: BoxFit.cover, scale: 1.8,),
              const SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.2,
              color: Colors.transparent,
              child: Text(snapshot.data![index].nameHome!, textAlign: TextAlign.center, style: TextStyle(fontSize: Get.textScaleFactor * 12),)),
        ]),
            Column(children: [
              const Text('Data do jogo'),
              const SizedBox(height: 5,),
              Text(data(index), style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 5,),
              Text('Provavel vencedor\n${snapshot.data![index].winner}', textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
            ]),
            Column(
              children: [
            Image.network(snapshot.data![index].imageAway!, scale: 1.8,),
            const SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.2,
              color: Colors.transparent,
              child: Text(snapshot.data![index].nameAway!, textAlign: TextAlign.center, style: TextStyle(fontSize: Get.textScaleFactor * 12)))
            ])]
        ),
        const SizedBox(height: 10),
        Column(
          children:  [
          GestureDetector(child: const Text('Aposta', style: TextStyle(fontSize: 17)),),
          const SizedBox(height: 10,),
          const Text('Cor-Hand.FT 0.0', style: TextStyle(fontSize: 17),),
          const SizedBox(height: 10,),
          const Text('Ver mais', style: TextStyle(),)
        ]),
      ]
    ))]);
  }));
  }
}