// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:treding/extra_clone_modules/controllers/new_dashboard_cantroller.dart';
//
// import 'new_extra_position_screen.dart';
// import 'new_home_screens.dart';
// import 'new_my_order_screen.dart';
// import 'new_search_share.dart';
// import 'new_watch_list_screen.dart';
//
// class NewDashboardScreens extends StatefulWidget {
//   const NewDashboardScreens({super.key});
//
//   @override
//   State<NewDashboardScreens> createState() => _NewDashboardScreensState();
// }
//
// class _NewDashboardScreensState extends State<NewDashboardScreens> with SingleTickerProviderStateMixin{
//
//   NewDashboardCtr ctrl = Get.put(NewDashboardCtr());
//
//   // List<String> tablist =["Home","Search Share","Watch List","Orders","Position","Basket Order"];
//
//   @override
//   void initState() {
//     super.initState();
//     ctrl.controller =
//         TabController(length: 5, vsync: this);
//
//     ctrl.controller.addListener(() {
//       ctrl.selectedIndex.value = ctrl.controller.index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 5,
//       child: Scaffold(
//         bottomNavigationBar:  TabBar(
//           tabAlignment: TabAlignment.start,
//           unselectedLabelColor: Colors.black,
//           indicatorSize: TabBarIndicatorSize.label,
//           controller: ctrl.controller,
//           automaticIndicatorColorAdjustment: false,
//           isScrollable: true,
//           overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
//           tabs:   const [
//             Tab(text: "Home",icon: Icon(Icons.home),),
//             Tab(text: "Search Share",icon: Icon(Icons.search)),
//             Tab(text: "Watch List",icon: Icon(Icons.list_alt_outlined)),
//             Tab(text: "Orders",icon: Icon(Icons.bookmark_border)),
//             // Tab(text: "Position",icon: Icon(Icons.polymer_sharp)),
//             Tab(text: "Testing Position",icon: Icon(Icons.polymer_sharp)),
//           ],
//         ),
//         body:  TabBarView(controller: ctrl.controller,
//           children: const [
//             NewHomeScreens(),
//             NewSearchShare(),
//             NewWatchListScreen(),
//             NewMyOrderScreen(),
//             NewExtraPositionScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }
