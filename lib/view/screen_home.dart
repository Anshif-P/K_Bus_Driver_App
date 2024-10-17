import 'package:flutter/material.dart';
import 'package:k_bus_driver/network/shared_preferences/shared_pref_model.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          InkWell(
              onTap: () {
                SharedPrefModel.instance.removeData('token');
              },
              child: const Text("Log out"))
        ],
      )),
    );
  }
}
