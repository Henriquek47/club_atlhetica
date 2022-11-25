import 'package:club_atlhetica/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextBarField extends GetView<LoginController> {
  final GlobalKey<FormState> _formKey;
  const TextBarField(this._formKey, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('E-mail', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                const SizedBox(height: 5),
              SizedBox(
            height: Get.height * 0.08,
          child: TextFormField(
            key: UniqueKey(),
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Digite seu e-mail',
                  hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
              controller: controller.controllerEmail,
              onChanged: (text) {},
              validator: (text){
                bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text!);
                if(emailValid == false){
                  return 'E-mail invalido';
                }else{
                  return null;
                }
              },
            ),
          ),])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Senha', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                const SizedBox(height: 5),
              SizedBox(
            height: Get.height * 0.08,
          child: TextFormField(
            showCursor: false,
            key: UniqueKey(),
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Digite sua senha',
                  hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
              controller: controller.controllerPassword,
              onChanged: (text) {},
              validator: (text){
                if(text!.length < 6){
                  return 'A senha tem que ter mais de 6 digitos';
                }else{
                  return null;
                }
              },
            ),
          ),],),),
          Obx(() =>
          controller.signIn.value ? const SizedBox() : Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Confirmar senha', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                const SizedBox(height: 5),
              SizedBox(
            height: Get.height * 0.08,
          child: TextFormField(
            key: UniqueKey(),
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Confirme sua senha',
                  hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
              controller: controller.controllerPasswordConfirm,
              onChanged: (text) {},
              validator: (text){
                 if(text!.length < 6){
                  return 'A senha tem que ter mais de 6 digitos';
                 }else if(text != controller.controllerPassword.text){
                  return 'Senhas diferentes';
                }else{
                  return null;
                }
              },
            ),
          ),],),),),
        ],
      ),
    );
  }
}
