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
        if(snapshot.hasData){
                return Expanded( 
                  child: PageView.builder(
      itemCount: snapshot.data?.round.length,
      itemBuilder: (conxtext, index){
      return FutureBuilder<Round>(
              future: controller.getRound(index),
              builder: (context, snapshot){ 
              if(snapshot.hasData){
                return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
            Container(color: Colors.blue, padding: const EdgeInsets.all(50)),
            
            Text(snapshot.data!.nameHome.toString())
        ]),
            Column(children: const [
              Text('Data do jogo'),
              SizedBox(height: 5,),
              Text('22/05', style: TextStyle(fontSize: 20),),
            ]),
            Column(
              children: [
            Container(color: Colors.amber, padding: const EdgeInsets.all(50)),
            Text(snapshot.data!.nameAway.toString())
            ]),          ]
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
      return const CircularProgressIndicator();
    }});
  }));}else{return const CircularProgressIndicator(color: Colors.deepOrange,);}
  });
  }
}