import 'package:club_atlhetica/layers/domain/round.dart';
import 'package:club_atlhetica/layers/service/repository/model/round_model.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextGames extends GetView<HomeController> {
  const NextGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RoundModel>>(
      future: controller.getRound(1),
      builder: (context, snapshot){
        if(snapshot.hasData){
                return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.35,
                   width: Get.width,
                  child: PageView.builder(
      itemCount: snapshot.data?.length,
      itemBuilder: (conxtext, index){
                return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Image.network(snapshot.data![index].teams!.home!.imageHome.toString(), fit: BoxFit.cover, scale: 2,),
              const SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.2,
              color: Colors.transparent,
              child: Text(snapshot.data![index].teams!.home!.nome.toString(), textAlign: TextAlign.center,))
        ]),
            Column(children: const [
              Text('Data do jogo'),
              SizedBox(height: 5,),
              Text('22/05', style: TextStyle(fontSize: 20),),
            ]),
            Column(
              children: [
            Image.network(snapshot.data![index].teams!.away!.imageaway.toString(), scale: 2,),
            const SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.2,
              color: Colors.transparent,
              child: Text(snapshot.data![index].teams!.away!.nome.toString(), textAlign: TextAlign.center,))
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
    );
  }));}else{return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.445,
                   width: Get.width,
                   alignment: Alignment.center,
                  child: const CircularProgressIndicator());}
  });
  }
}