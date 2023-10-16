import 'package:flutter/material.dart';
import 'package:test_tech_digital_paca/network/network_api_service.dart';
import 'package:test_tech_digital_paca/res/color.dart';
import 'package:test_tech_digital_paca/res/components/round_button.dart';
import 'package:test_tech_digital_paca/utils/utils.dart';
import 'package:test_tech_digital_paca/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController.text = "test-tech-dp-api_front@gmail.com";
    _passwordController.text = "#j3apZAYBAm@Q4T2C!dQa";
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: SafeArea(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  minWidth: MediaQuery.of(context).size.width),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 84,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Image(
                          image: AssetImage(
                              'images/DigitalPACA-Logo_Round_poulpe-en-haut.png'),
                          height: 120,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 3 * 2,
                              child: const Text(
                                "Se connecter :",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3 * 2,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              focusNode: emailFocusNode,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Adresse mail',
                              ),
                              onFieldSubmitted: (valu) {
                                Utils.fieldFocusChange(
                                    context, emailFocusNode, passwordFocusNode);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ValueListenableBuilder(
                              valueListenable: _obsecurePassword,
                              builder: (context, value, child) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3 * 2,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: _passwordController,
                                    obscureText: _obsecurePassword.value,
                                    focusNode: passwordFocusNode,
                                    obscuringCharacter: "*",
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      hintText: 'Mot de passe',
                                      fillColor: Colors.white,
                                      filled: true,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            _obsecurePassword.value =
                                                !_obsecurePassword.value;
                                          },
                                          child: Icon(_obsecurePassword.value
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility)),
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          RoundButton(
                            title: 'Login',
                            loading:
                                authViewMode.loadingStatus == Status.loading,
                            onPress: () {
                              if (_emailController.text.isEmpty) {
                                Utils.snackBar('Please enter email',
                                    Colors.orange, context);
                              } else if (_passwordController.text.isEmpty) {
                                Utils.snackBar('Please enter password',
                                    Colors.orange, context);
                              } else if (_passwordController.text.length < 6) {
                                Utils.snackBar('Please enter 6 digit password',
                                    Colors.orange, context);
                              } else {
                                Map data = {
                                  'email': _emailController.text.toString(),
                                  'password':
                                      _passwordController.text.toString(),
                                };

                                authViewMode.loginApi(data, context);
                              }
                            },
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                        ],
                      ),
                    ]),
              ),
            ));
      })),
    );
  }
}
