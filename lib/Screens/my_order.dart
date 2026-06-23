import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treding/Controllers/order_controller.dart';
import 'package:treding/Utils/helper.dart';
import 'package:treding/Utils/material_color_generator.dart';

import '../Utils/app_font.dart';
import 'all_order_update_screen.dart';
import 'order_update_screen.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    orderController.getOrdersListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            await orderController.getOrdersListApi();
          }, icon: Icon(Icons.refresh))
        ],
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColor.primaryColor,
        title: Text(
          'My Orders',
          style: Font.bodyText1(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await orderController.getOrdersListApi();
        },
        child: Obx(() => orderController.isOrderLoading.value
            ? const Align(
                alignment: Alignment.center, child: CircularProgressIndicator())
            : orderController.orderList.isNotEmpty
                ? ListView.builder(
                    itemCount: orderController.orderList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 4.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.5),
                                //color of shadow
                                spreadRadius: 0.5,
                                blurRadius: 5,
                                // blur radius
                                // offset: const Offset(
                                //     1, 2), // changes position of shadow
                              )
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      style: ButtonStyle(
                                          shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.red,
                                                    // your color here
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)))),
                                      onPressed: () async {
                                        orderController.commonOrderList.clear();
                                        String symbole = orderController
                                            .orderList[index].tradingsymbol
                                            .toString();
                                        String status = orderController
                                            .orderList[index].status
                                            .toString();

                                        if (status == "rejected" ||
                                            status ==
                                                "cancelled after market order" ||
                                            status == "cancelled" ||
                                            status == "complete") {
                                          Helper().showMessage(
                                              message:
                                                  "Please Check Status...");
                                        } else {
                                          for (int i = 0;
                                              i <
                                                  orderController
                                                      .orderList.length;
                                              i++) {
                                            if (symbole ==
                                                orderController.orderList[i]
                                                    .tradingsymbol) {
                                              if (orderController
                                                          .orderList[i].status
                                                          .toString() ==
                                                      "complete" ||
                                                  orderController
                                                          .orderList[i].status
                                                          .toString() ==
                                                      "rejected" ||
                                                  orderController
                                                          .orderList[i].status
                                                          .toString() ==
                                                      "cancelled after market order") {
                                              } else {
                                                Get.to(AllOrderUpdateScreen(
                                                  orderType: 0,
                                                  transactionType:
                                                      orderController
                                                          .orderList[index]
                                                          .transactiontype
                                                          .toString(),
                                                  symboleToken: orderController
                                                      .orderList[index]
                                                      .symboltoken
                                                      .toString(),
                                                  productType:
                                                      selectedProductType(
                                                          index: index),
                                                  variety: selectedVariety(
                                                      index: index),
                                                  lotSize: orderController
                                                      .orderList[index].lotsize
                                                      .toString(),
                                                  tradingsymbol: orderController
                                                      .orderList[index]
                                                      .tradingsymbol
                                                      .toString(),
                                                  ltp: orderController
                                                      .orderList[index].price
                                                      .toString(),
                                                  exchange: orderController
                                                      .orderList[index].exchange
                                                      .toString(),
                                                ));
                                              }
                                            }
                                          }
                                          print(
                                              "Lee=> ${orderController.commonOrderList.length}");
                                        }
                                      },
                                      child: const Text(
                                        "Bulk Edit",
                                        style: TextStyle(color: Colors.red),
                                      )),
                                  TextButton.icon(
                                    style: ButtonStyle(
                                        shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  color: Colors
                                                      .red, // your color here
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    icon: const Icon(Icons.edit),
                                    label: const Text("Edit"),
                                    onPressed: () async {

                                      String status = orderController
                                          .orderList[index].status
                                          .toString();
                                      if (status == "rejected" ||
                                          status ==
                                              "cancelled after market order" ||
                                          status == "cancelled" ||
                                          status == "complete") {
                                        Helper().showMessage(
                                            message: "Please Check Status....");
                                      } else {
                                        Get.to(OrderUpdateScreen(
                                          orderId: orderController
                                              .orderList[index].orderid
                                              .toString(),
                                          transactionType: orderController
                                              .orderList[index].transactiontype
                                              .toString(),
                                          symboleToken: orderController
                                              .orderList[index].symboltoken
                                              .toString(),
                                          orderid: orderController
                                              .orderList[index].orderid
                                              .toString(),
                                          productType: orderController
                                              .orderList[index].producttype
                                              .toString(),
                                          userName: orderController
                                              .orderList[index].clientName
                                              .toString(),
                                          variety: selectedVariety(index: index),
                                          lotSize: orderController
                                              .orderList[index].lotsize
                                              .toString(),
                                          qty: orderController
                                              .orderList[index].quantity
                                              .toString(),
                                          tradingsymbol: orderController
                                              .orderList[index].tradingsymbol
                                              .toString(),
                                          ltp: orderController
                                              .orderList[index].price
                                              .toString(),
                                          exchange: orderController
                                              .orderList[index].exchange
                                              .toString(),
                                          isRatioOrder: false,
                                        ));
                                      }
                                    },
                                  ),
                                  TextButton.icon(
                                    style: ButtonStyle(
                                        shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  color: Colors
                                                      .red, // your color here
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await orderController.getCancelOrdersApi(
                                          position: index);
                                    },
                                    label: const Text("Delete"),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: Get.width * 0.25,
                                        child: const Text(
                                          "Status :",
                                          style: TextStyle(fontSize: 14),
                                        )),
                                    Container(
                                      padding: const EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                          color: myChangeColor(i: index),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: Get.width * 0.60,
                                      margin: const EdgeInsets.only(
                                          right: 3, bottom: 5),
                                      child: Center(
                                        child: Text(
                                          orderController
                                              .orderList[index].status,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              commanUi(
                                  title: "Client Name :",
                                  value: orderController
                                      .orderList[index].clientName,
                                  color: Colors.black),
                              commanUi(
                                  title: "ProductType :",
                                  value: orderController
                                      .orderList[index].producttype,
                                  color: Colors.black),
                              commanUi(
                                  title: "Symbol :",
                                  value: orderController
                                      .orderList[index].tradingsymbol,
                                  color: Colors.black),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Text("Order Type"),
                                        Text(
                                          orderController
                                              .orderList[index].ordertype,
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text("Price"),
                                        Text(
                                          orderController.orderList[index].price
                                              .toString(),
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text("Trigger Price"),
                                        Text(
                                          orderController
                                              .orderList[index].triggerprice
                                              .toString(),
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Text("Quantity"),
                                        Text(
                                          orderController
                                              .orderList[index].quantity,
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text("TXN"),
                                        Text(
                                          orderController
                                              .orderList[index].transactiontype
                                              .toString(),
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text("Exchanges"),
                                        Text(
                                          orderController
                                              .orderList[index].exchange
                                              .toString(),
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: SizedBox(
                    child: Text("Data Not Available"),
                  ))),
      ),
    );
  }

  Widget commanUi(
      {required String title, required String value, required Color color}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
              width: Get.width * 0.25,
              child: Text(
                title,
                style: const TextStyle(fontSize: 14),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
              width: Get.width * 0.60,
              child: Text(
                overflow: TextOverflow.clip,
                maxLines: 2,
                value,
                style: TextStyle(color: color, fontSize: 16),
              )),
        )
      ],
    );
  }

  myChangeColor({required int i}) {
    if (orderController.orderList[i].status == "rejected") {
      Color c = Colors.red.shade100;
      return c;
    } else if (orderController.orderList[i].status == "cancelled") {
      Color c = Colors.red.shade100;
      return c;
    } else if (orderController.orderList[i].status ==
        "after market order req received") {
      Color c = Colors.blue.shade100;
      return c;
    } else if (orderController.orderList[i].status ==
        "cancelled after market order") {
      Color c = Colors.red.shade100;
      return c;
    } else if (orderController.orderList[i].status == "complete") {
      Color c = Colors.green.shade100;
      return c;
    } else if (orderController.orderList[i].status == "open") {
      Color c = Colors.yellow.shade100;
      return c;
    }
  }

  int selectedVariety({required int index}) {
    int a = 0;
    if (orderController.orderList[index].variety == "AMO") {
      a = 2;
    } else if (orderController.orderList[index].variety == "STOPLOSS") {
      a = 1;
    } else {
      a = 0;
    }
    return a;
  }

  int selectedProductType({required int index}) {
    int a = 0;
    if (orderController.orderList[index].producttype == "INTRADAY") {
      a = 2;
    } else if (orderController.orderList[index].producttype == "CARRYFORWARD") {
      a = 1;
    } else {
      a = 0;
    }
    return a;
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
