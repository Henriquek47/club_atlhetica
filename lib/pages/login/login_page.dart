import 'package:club_atlhetica/pages/login/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height * 1,
            width: Get.width * 1,
            color: Colors.white,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.luminosity),
              child: Image.asset(
                'assets/estadio.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: Get.height * 0.25,
            left: 0,
            right: 0,
            child: const TextBarField(),
          ),
          Align(
            alignment: const Alignment(0, 0.65),
            child: InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                height: Get.height * 0.05,
                width: Get.width * 0.45,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    color: Theme.of(context).primaryColor),
                child: const Text('Entrar'),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.78),
            child:Text('Crie uma nova conta', style: TextStyle(fontSize: Get.textScaleFactor * 12, fontWeight: FontWeight.bold),),),
          Align(
            alignment: const Alignment(0, 0.85),
            child:Text('Esqueci minha senha', style: TextStyle(fontSize: Get.textScaleFactor * 10, fontWeight: FontWeight.bold),),),
        ],
      ),
    );
  }
}
