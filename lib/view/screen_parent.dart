import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:k_bus_driver/util/constance/app_colors.dart';
import 'package:k_bus_driver/view/screen_mybus.dart';
import 'package:k_bus_driver/view/screen_profile.dart';
import 'package:k_bus_driver/view/screen_routes.dart';
import 'screen_home.dart';

class ScreenParentNavigation extends StatelessWidget {
  ScreenParentNavigation({super.key});

  final pageNotifier = ValueNotifier(0);

  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenMyBus(),
    const ScreenRoutes(),
    const ScreenProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: pageNotifier,
          builder: (context, value, _) => _screens[pageNotifier.value]),
      bottomNavigationBar: NavigationBar(pageNotifier: pageNotifier),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key, required this.pageNotifier});
  final ValueNotifier<int> pageNotifier;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (context, value, _) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(top: 4),
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                bottomNavigationItems(
                  icon: CupertinoIcons.home,
                  label: 'Home',
                  onTap: () => pageNotifier.value = 0,
                  isSelected: pageNotifier.value == 0,
                ),
                bottomNavigationItems(
                  icon: CupertinoIcons.bus,
                  label: 'My Bus',
                  onTap: () => pageNotifier.value = 1,
                  isSelected: pageNotifier.value == 1,
                ),
                bottomNavigationItems(
                  icon: Icons.edit_road,
                  label: 'Routes',
                  onTap: () => pageNotifier.value = 2,
                  isSelected: pageNotifier.value == 2,
                ),
                bottomNavigationItems(
                  icon: CupertinoIcons.person,
                  label: 'Profile',
                  onTap: () => pageNotifier.value = 3,
                  isSelected: pageNotifier.value == 3,
                ),
              ],
            ),
          );
        });
  }

  Expanded bottomNavigationItems({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool addTextcolor = false,
    bool hideIcon = false,
    bool isSelected = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(height: 5),
              hideIcon
                  ? const SizedBox(height: 25)
                  : Icon(
                      icon,
                      color: isSelected ? AppColor.primaryColor : AppColor.grey,
                    ),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  color: addTextcolor == false
                      ? isSelected
                          ? AppColor.primaryColor
                          : AppColor.grey
                      : Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
