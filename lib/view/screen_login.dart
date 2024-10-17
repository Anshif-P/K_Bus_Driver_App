import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/controller/login_bloc/login_bloc.dart';
import 'package:k_bus_driver/controller/signup_bloc/signup_bloc.dart';
import 'package:k_bus_driver/util/constance/text_style.dart';
import 'package:k_bus_driver/util/snack_bar/snack_bar.dart';
import 'package:k_bus_driver/util/validation/validation.dart';
import 'package:k_bus_driver/view/screen_home.dart';
import 'package:k_bus_driver/view/screen_signup.dart';
import 'package:k_bus_driver/widgets/comman/button.dart';
import 'package:k_bus_driver/widgets/comman/textfield.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Welcome', style: AppText.largeDark),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 110,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/location 1.png'))),
                  ),
                  const SizedBox(height: 10),
                  Text('Login', style: AppText.xLarge),
                  const SizedBox(height: 20),
                  Form(
                    key: loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email Or Phone Number',
                          style: AppText.mediumdark,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                            controller: emailController,
                            validator: (value) =>
                                Validations.emailValidation(value)),
                        const SizedBox(height: 10),
                        Text(
                          'Password',
                          style: AppText.mediumdark,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                            textVisibility: true,
                            isObscure: true,
                            controller: passController,
                            validator: (value) =>
                                Validations.isPassword(value)),
                        const SizedBox(height: 30),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginLoadingState) {
                              isLoading = true;
                            } else if (state is LoginSuccessState) {
                              isLoading = false;

                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const ScreenHome(),
                              ));
                            } else if (state is LoginFailedState) {
                              isLoading = false;

                              CustomSnackBar.showSnackBar(
                                  context, state.message);
                            }
                          },
                          builder: (context, state) => ButtonWidget(
                              loadingCheck: isLoading,
                              onpressFunction: () => loginFnc(context),
                              text: 'Sing up',
                              colorCheck: true),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => ScreenSignUp())),
                    child: RichText(
                      text: TextSpan(
                          text: "don't have an account ",
                          style: AppText.mediumdark,
                          children: [
                            TextSpan(
                                text: 'sign up', style: AppText.mediumPrimary)
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginFnc(BuildContext context) {
    if (loginFormKey.currentState!.validate()) {
      context.read<LoginBloc>().add(LoginUserEvent(
          email: emailController.text, password: passController.text));
    }
  }
}
