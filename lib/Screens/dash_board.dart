import 'package:flutter/material.dart';
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
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        bottomNavigationBar: TabBar(
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
            Tab(text: "Basket Order", icon: Icon(Icons.shopping_basket)),
            Tab(text: "Position", icon: Icon(Icons.polymer_sharp)),
          ],
        ),
        body: TabBarView(
          controller: ctrl.controller,
          children: const [
            HomeScreen(),
            SearchShare(),
            WatchListScreen(),
            MyOrder(),
            NewBasketOrderScreen(),
            ExtraPositionScreen()
          ],
        ),
      ),
    );
  }
}
