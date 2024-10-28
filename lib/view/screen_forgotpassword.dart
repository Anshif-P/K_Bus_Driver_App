import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/controller/forgot_pass_bloc/forgot_password_bloc.dart';
import 'package:k_bus_driver/util/constance/text_style.dart';
import 'package:k_bus_driver/util/snack_bar/snack_bar.dart';
import 'package:k_bus_driver/util/validation/validation.dart';
import 'package:k_bus_driver/view/screen_login.dart';
import 'package:k_bus_driver/widgets/comman/button.dart';
import 'package:k_bus_driver/widgets/comman/textfield.dart';

class ScreenForgorPassword extends StatelessWidget {
  ScreenForgorPassword({super.key});
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> forgotPassKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forgor Password ?',
              style: AppText.largeDark,
            ),
            const SizedBox(height: 10),
            const Text("No worries,we'll send you reset instruction"),
            const SizedBox(height: 20),
            Text(
              'Email',
              style: AppText.mediumdark,
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: forgotPassKey,
              child: TextFieldWidget(
                  controller: emailController,
                  validator: (value) =>
                      Validations.emailOrNumberValidation(value)),
            ),
            const SizedBox(height: 20),
            BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotUserPasswordLoadingState) {
                  isLoading = true;
                } else if (state is ForgotUserPasswordFailedState) {
                  isLoading = false;
                  CustomSnackBar.showSnackBar(context, state.message);
                } else if (state is ForgotUserPasswordSuccessState) {
                  isLoading = false;
                  CustomSnackBar.showSnackBar(context, state.message);
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) => ButtonWidget(
                  onpressFunction: () => forgotPassFnc(context),
                  loadingCheck: isLoading,
                  text: 'Request Password',
                  colorCheck: true),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ScreenLogin())),
              child: RichText(
                text: TextSpan(
                    text: "back to ",
                    style: AppText.mediumdark,
                    children: [
                      TextSpan(text: 'login', style: AppText.mediumPrimary)
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  void forgotPassFnc(BuildContext context) {
    if (forgotPassKey.currentState!.validate()) {
      context
          .read<ForgotPasswordBloc>()
          .add(ForgotUserPasswordEvent(email: emailController.text));
    }
  }
}
