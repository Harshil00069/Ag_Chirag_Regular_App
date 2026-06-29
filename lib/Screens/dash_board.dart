import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:treding/Controllers/dashboard_controller.dart';
import 'package:treding/Screens/search_share.dart';
import 'package:treding/Screens/watch_list_screen.dart';

import 'extra_position_check.dart';
import 'home_screen.dart';
import 'my_order.dart';
import 'new_basket_order_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  DashboardCtr ctrl = Get.put(DashboardCtr());

  // List<String> tablist =["Home","Search Share","Watch List","Orders","Position","Basket Order"];
  DateTime? lastBackPressed;

  @override
  void initState() {
    super.initState();
    ctrl.controller = TabController(length: 6, vsync: this);

    ctrl.controller.addListener(() {
      ctrl.selectedIndex.value = ctrl.controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        final now = DateTime.now();

        if (lastBackPressed == null ||
            now.difference(lastBackPressed!) >
                const Duration(seconds: 2)) {
          lastBackPressed = now;

          Get.snackbar(
            "Exit",
            "Press back again to exit",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        } else {
          SystemNavigator.pop();
        }
      },
      child: DefaultTabController(
        length: 7,
        child: Scaffold(backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            height: 75,
            // margin: const EdgeInsets.symmetric(
            //   horizontal: 12,
            //   vertical: 8,
            // ),
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(16),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black.withOpacity(0.08),
            //       blurRadius: 12,
            //       spreadRadius: 1,
            //       offset: const Offset(0, 4),
            //     ),
            //   ],
            // ),
            decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
            child: TabBar(
              tabAlignment: TabAlignment.start,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              controller: ctrl.controller,
              automaticIndicatorColorAdjustment: false,
              isScrollable: true,
              overlayColor:
                  const WidgetStatePropertyAll<Color>(Colors.transparent),
              tabs: const [
                Tab(
                  text: "Home",
                  icon: Icon(Icons.home),
                ),
                Tab(text: "Search Share", icon: Icon(Icons.search)),
                Tab(text: "Watch List", icon: Icon(Icons.list_alt_outlined)),
                Tab(text: "Orders", icon: Icon(Icons.bookmark_border)),
                Tab(text: "Position", icon: Icon(Icons.polymer_sharp)),
                Tab(text: "Basket Order", icon: Icon(Icons.shopping_basket)),
              ],
            ),
          ),
          body: TabBarView(
            controller: ctrl.controller,
            children: const [
              HomeScreen(),
              SearchShare(),
              WatchListScreen(),
              MyOrder(),
              ExtraPositionScreen(),
              NewBasketOrderScreen(),

            ],
          ),
        ),
      ),
    );
  }
}
