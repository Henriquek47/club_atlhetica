import 'package:club_atlhetica/pages/login/login_controller.dart';
import 'package:club_atlhetica/pages/login/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => SingleChildScrollView(child: SizedBox(
            height: Get.height * 1,
            width: Get.width * 1,
            child: Stack(
        children: [
          Container(
            height: Get.height * 1,
            width: Get.width * 1,
            color: Colors.white,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.luminosity),
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
            child: TextBarField(_formKey),
          ),
          Align(
            alignment: const Alignment(0, 0.65),
            child: GestureDetector(
                onTap: () async {
                  _formKey.currentState?.validate();
                  if (_formKey.currentState?.validate() == true) {
                    if (controller.signIn.value) {
                      final user = await controller.loginSubmit(
                          controller.controllerEmail,
                          controller.controllerPassword,
                          context);
                      if (user != null) {
                        Get.offNamed('/home');
                      }
                    } else {
                      final user = await controller.register(
                          controller.controllerEmail,
                          controller.controllerPassword,
                          context);
                      if (user != null) {
                        Get.offNamed('/home');
                      }
                    }
                    controller.controllerEmail.clear();
                    controller.controllerPassword.clear();
                    controller.controllerPasswordConfirm.clear();
                  }
                },
                child: Container(
              alignment: Alignment.center,
              height: Get.height * 0.05,
              width: Get.width * 0.45,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: Theme.of(context).primaryColor),
              child: Text(
                  !controller.signIn.value ? 'Registrar' : 'Entrar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.signIn.value = !controller.signIn.value;
              controller.controllerPasswordConfirm.clear();
            },
            child: Align(
              alignment: const Alignment(0, 0.78),
              child: Text(
                !controller.signIn.value
                    ? 'Faça o login'
                    : 'Crie uma nova conta',
                style: TextStyle(
                    fontSize: Get.textScaleFactor * 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.85),
            child: !controller.signIn.value
                ? const SizedBox.shrink()
                : Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                        fontSize: Get.textScaleFactor * 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54),
                  ),
          ),
        ],
      ),
    ))));
  }
}
