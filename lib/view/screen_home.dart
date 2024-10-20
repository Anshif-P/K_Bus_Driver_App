import 'package:flutter/material.dart';
import 'package:k_bus_driver/util/constance/text_style.dart';
import 'package:k_bus_driver/view/screen_add_bus.dart';
import 'package:k_bus_driver/widgets/comman/button.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: AppText.defautTitleDark,
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
                'Welcome to K Bus Driver! Track routes in real-time, update passengers, and manage your schedule easily for a smooth ride',
                style: AppText.mediumdark),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 170,
            width: 240,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/image/Rectangle 211.png'))),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ButtonWidget(
                    onpressFunction: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ScreenAddBus())),
                    text: 'ADD BUS',
                    colorCheck: true),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ButtonWidget(
                    onpressFunction: () {}, text: 'START', colorCheck: true),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      )),
    );
  }
}
