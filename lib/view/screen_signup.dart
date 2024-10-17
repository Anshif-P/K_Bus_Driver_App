import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/controller/signup_bloc/signup_bloc.dart';
import 'package:k_bus_driver/util/constance/text_style.dart';
import 'package:k_bus_driver/util/snack_bar/snack_bar.dart';
import 'package:k_bus_driver/util/validation/validation.dart';
import 'package:k_bus_driver/view/screen_home.dart';
import 'package:k_bus_driver/view/screen_login.dart';
import 'package:k_bus_driver/widgets/comman/button.dart';
import 'package:k_bus_driver/widgets/comman/textfield.dart';

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
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
                  Text('register', style: AppText.xLarge),
                  const SizedBox(height: 20),
                  Form(
                    key: registerFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email or Phone Number',
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
                        BlocConsumer<SignupBloc, SignupState>(
                          listener: (context, state) {
                            if (state is SignupLoadingState) {
                              print('singup loading');

                              isLoading = true;
                            } else if (state is SignupSuccessState) {
                              isLoading = false;
                              print('singup success');
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const ScreenHome(),
                              ));
                            } else if (state is SignupFailedState) {
                              isLoading = false;

                              CustomSnackBar.showSnackBar(
                                  context, state.message);
                            }
                          },
                          builder: (context, state) => ButtonWidget(
                              onpressFunction: () => singUpFnc(context),
                              loadingCheck: isLoading,
                              text: 'Sing up',
                              colorCheck: true),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ScreenLogin())),
                    child: RichText(
                      text: TextSpan(
                          text: "Already have an account ",
                          style: AppText.mediumdark,
                          children: [
                            TextSpan(
                                text: 'login', style: AppText.mediumPrimary)
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

  singUpFnc(BuildContext context) {
    if (registerFormKey.currentState!.validate()) {
      context.read<SignupBloc>().add(SignupUserEvent(
          email: emailController.text, password: passController.text));
    }
  }
}
