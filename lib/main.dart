import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/controller/add_bus_bloc/add_bus_bloc.dart';
import 'package:k_bus_driver/controller/login_bloc/login_bloc.dart';
import 'package:k_bus_driver/controller/signup_bloc/signup_bloc.dart';
import 'package:k_bus_driver/controller/user_bloc/user_bloc.dart';
import 'package:k_bus_driver/network/shared_preferences/shared_pref_model.dart';
import 'package:k_bus_driver/view/screen_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefModel.instance.initSharedPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => AddBusBloc(),
        )
      ],
      child: const MaterialApp(
        home: ScreenSplash(),
      ),
    );
  }
}
