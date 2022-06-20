import 'package:club_atlhetica/layers/domain/round.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextGames extends GetView<HomeController> {
  const NextGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Round>(
      future: controller.getRound(0),
      builder: (context, snapshot){
        if(true){
                return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.35,
                   width: Get.width,
                  child: PageView.builder(
      itemCount: snapshot.data?.round.length,
      itemBuilder: (conxtext, index){
      return FutureBuilder<Round>(
              future: controller.getRound(index),
              builder: (context, snapshot){ 
              if(true){
                return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              Image.asset('assets/corinthians.png', fit: BoxFit.cover, scale: 17,),
              const SizedBox(height: 10,),
            Text('Corinthians')
        ]),
            Column(children: const [
              Text('Data do jogo'),
              SizedBox(height: 5,),
              Text('22/05', style: TextStyle(fontSize: 20),),
            ]),
            Column(
              children: [
            Image.asset('assets/flamengo.png', scale: 18,),
            const SizedBox(height: 10,),
            Text('Flamengo')
            ])]
        ),
        const SizedBox(height: 10),
        Column(
          children: const [
          Text('Aposta', style: TextStyle(fontSize: 17),),
          SizedBox(height: 10,),
          Text('Cor-Hand.FT 0.0', style: TextStyle(fontSize: 17),),
          SizedBox(height: 10,),
          Text('Ver mais', style: TextStyle(),)
        ]),
      ]
    );}else{
      return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.445,
                   width: Get.width,
                   alignment: Alignment.center,
                  child: const CircularProgressIndicator());}
    });
  }));}else{return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.445,
                   width: Get.width,
                   alignment: Alignment.center,
                  child: const CircularProgressIndicator());}
  });
  }
}