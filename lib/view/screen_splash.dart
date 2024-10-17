import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/controller/user_bloc/user_bloc.dart';
import 'package:k_bus_driver/util/constance/text_style.dart';
import 'package:k_bus_driver/view/screen_home.dart';
import 'package:k_bus_driver/view/screen_login.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(UserTokenCheckingEvent());

    return Scaffold(
      backgroundColor: const Color(0xFFD63942),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) => userLoginValidation(context, state),
            child: Container(
              height: 110,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/location 2.png'))),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Welcome to K Bus',
            style: AppText.largeLight,
          ),
        ],
      ),
    );
  }

  userLoginValidation(BuildContext context, state) async {
    await Future.delayed(const Duration(seconds: 2));
    if (state is UserTokenFoundState) {
      print('home------------------------------');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ScreenHome(),
      ));
    } else if (state is UserTokenNotFoundState) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ScreenLogin(),
      ));
    }
  }
}
