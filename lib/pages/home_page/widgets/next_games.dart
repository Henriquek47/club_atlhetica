import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextGames extends GetView<HomeController> {
  const NextGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Round>>(
      future: controller.getRound(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          print(controller.statisticsTeam());
                return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.6,
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
              Image.network(snapshot.data![index].imageHome.toString(), fit: BoxFit.cover, scale: 1.8,),
              const SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.2,
              color: Colors.transparent,
              child: Text(snapshot.data![index].nameHome.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: Get.textScaleFactor * 12),))
        ]),
            Column(children: const [
              Text('Data do jogo'),
              SizedBox(height: 5,),
              Text('22/05', style: TextStyle(fontSize: 20),),
            ]),
            Column(
              children: [
            Image.network(snapshot.data![index].imageAway.toString(), scale: 1.8,),
            const SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.2,
              color: Colors.transparent,
              child: Text(snapshot.data![index].nameAway.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: Get.textScaleFactor * 12)))
            ])]
        ),
        const SizedBox(height: 10),
        Column(
          children:  [
          GestureDetector(child: Text('Aposta', style: TextStyle(fontSize: 17)),),
          SizedBox(height: 10,),
          Text('Cor-Hand.FT 0.0', style: TextStyle(fontSize: 17),),
          SizedBox(height: 10,),
          Text('Ver mais', style: TextStyle(),)
        ]),
      ]
    ))]);
  }));}else{return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.445,
                   width: Get.width,
                   alignment: Alignment.center,
                  child: const CircularProgressIndicator());}
  });
  }
}