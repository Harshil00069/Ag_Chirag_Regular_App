import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treding/Controllers/basket_order_controller.dart';
import 'package:treding/Controllers/dashboard_controller.dart';
import 'package:treding/Controllers/order_controller.dart';
import 'package:treding/Utils/app_dialogs.dart';
import 'package:treding/model/basket_order_model.dart';
import 'package:treding/model/place_order_model.dart';
import 'package:treding/model/user_model.dart';

import '../Controllers/homepage_controller.dart';
import '../Controllers/search_share_ctr.dart';
import '../Controllers/watchlist_ctr.dart';
import '../Utils/app_font.dart';
import '../Utils/material_color_generator.dart';
import '../custom_widgets/app_burron.dart';
import '../custom_widgets/app_text_field.dart';

class NewBasketOrderScreen extends StatefulWidget {
  const NewBasketOrderScreen({super.key});

  @override
  State<NewBasketOrderScreen> createState() => _NewBasketOrderScreenState();
}

class _NewBasketOrderScreenState extends State<NewBasketOrderScreen> {
  final ScrollController controller = ScrollController();

  List<String> varityList = ["NORMAL", "STOPLOSS", "AMO"];
  List<String> ordertypeList = [
    "LIMIT",
    "MARKET",
    "STOPLOSS_LIMIT",
    "STOPLOSS_MARKET"
  ];

  List<String> productTypeList = ["DELIVERY", "CARRYFORWARD", "INTRADAY"];

  ValueNotifier varietyNotifier = ValueNotifier(0);
  ValueNotifier ordertypeNotifier = ValueNotifier(0);
  ValueNotifier productTypeNotifier = ValueNotifier(1);

  final WatchListController watchListController =
      Get.isRegistered<WatchListController>()
          ? Get.find<WatchListController>()
          : Get.put(WatchListController());

  final BasketOrderController basketOrderController =
      Get.isRegistered<BasketOrderController>()
          ? Get.find<BasketOrderController>()
          : Get.put(BasketOrderController());

  final SearchShareController searchShareController =
      Get.isRegistered<SearchShareController>()
          ? Get.find<SearchShareController>()
          : Get.put(SearchShareController());

  TextEditingController tradingExchangeCtr = TextEditingController();
  TextEditingController lotSizeCtr = TextEditingController();
  TextEditingController priceCtr = TextEditingController();
  TextEditingController tradingSymbolCtr = TextEditingController();
  TextEditingController TriggerPriceCtr = TextEditingController();
  ValueNotifier buySellSwitch = ValueNotifier(true);
  DashboardCtr ctrl = Get.put(DashboardCtr());
  List<BasketOrderListModel> basketList = [];

  List<GetUserListForOrder> userListWithQty = [];

  HomepageCtr homeScreenController = Get.put(HomepageCtr());
  OrderController orderController = Get.put(OrderController());


  @override
  void initState() {
    super.initState();
    orderController.placeOrderList.clear();
    for (var item in homeScreenController.userList) {
      userListWithQty.add(GetUserListForOrder(
        userModel: item,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColor.primaryColor,
          title: Text(
            'Basket Orders',
            style: Font.bodyText1(),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            const Text(
                              "Select Variety",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            ValueListenableBuilder(
                                valueListenable: varietyNotifier,
                                builder: (ctx, val, _) {
                                  return Wrap(
                                    spacing: 6.0,
                                    runSpacing: 6.0,
                                    children: List.generate(
                                        varityList.length,
                                        (index) => Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              child: ChoiceChip(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                onSelected: (val) {
                                                  varietyNotifier.value = index;
                                                },
                                                label: Text(varityList[index]),
                                                selectedColor:
                                                    varietyNotifier.value ==
                                                            index
                                                        ? Colors.blue
                                                        : Colors.transparent,
                                                showCheckmark: false,
                                                labelStyle: TextStyle(
                                                    color:
                                                        varietyNotifier.value ==
                                                                index
                                                            ? Colors.white
                                                            : Colors.black),
                                                selected:
                                                    varietyNotifier.value ==
                                                            index
                                                        ? true
                                                        : false,
                                              ),
                                            )),
                                  );
                                }),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            const Text(
                              "Select Order Type",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            ValueListenableBuilder(
                                valueListenable: ordertypeNotifier,
                                builder: (ctx, val, _) {
                                  return Wrap(
                                    spacing: 6.0,
                                    runSpacing: 6.0,
                                    children: List.generate(
                                        ordertypeList.length,
                                        (index) => Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              child: ChoiceChip(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                onSelected: (val) {
                                                  ordertypeNotifier.value =
                                                      index;
                                                },
                                                label:
                                                    Text(ordertypeList[index]),
                                                selectedColor:
                                                    ordertypeNotifier.value ==
                                                            index
                                                        ? Colors.blue
                                                        : Colors.transparent,
                                                showCheckmark: false,
                                                labelStyle: TextStyle(
                                                    color: ordertypeNotifier
                                                                .value ==
                                                            index
                                                        ? Colors.white
                                                        : Colors.black),
                                                selected:
                                                    ordertypeNotifier.value ==
                                                            index
                                                        ? true
                                                        : false,
                                              ),
                                            )),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            const Text(
                              "Select Product Type",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            ValueListenableBuilder(
                                valueListenable: productTypeNotifier,
                                builder: (ctx, val, _) {
                                  return Wrap(
                                    spacing: 6.0,
                                    runSpacing: 6.0,
                                    children: List.generate(
                                        productTypeList.length,
                                        (index) => Container(
                                              margin: const EdgeInsets.only(
                                                  right: 5),
                                              child: ChoiceChip(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                onSelected: (val) {
                                                  productTypeNotifier.value =
                                                      index;
                                                },
                                                label: Text(
                                                    productTypeList[index]),
                                                selectedColor:
                                                    productTypeNotifier.value ==
                                                            index
                                                        ? Colors.blue
                                                        : Colors.transparent,
                                                showCheckmark: false,
                                                labelStyle: TextStyle(
                                                    color: productTypeNotifier
                                                                .value ==
                                                            index
                                                        ? Colors.white
                                                        : Colors.black),
                                                selected:
                                                    productTypeNotifier.value ==
                                                            index
                                                        ? true
                                                        : false,
                                              ),
                                            )),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          selectWhereHouseDropDownUI(),
                          Row(
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Exchanges",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.25,
                                    child: RegTxtField(
                                      isReadOnly: true,
                                      ctr: tradingExchangeCtr,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Lot Size",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.20,
                                      child: RegTxtField(
                                        isReadOnly: true,
                                        ctr: lotSizeCtr,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: Get.width * 0.30,
                                  child: RegTxtField(
                                    isReadOnly: true,
                                    ctr: priceCtr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Enter Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                RegTxtField(
                                    ctr: TriggerPriceCtr,
                                    hintTxt: "Enter Amount",
                                    keyboardType: TextInputType.number),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ValueListenableBuilder(
                          valueListenable: buySellSwitch,
                          builder: (ctx, val, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Sell",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Switch(
                                  value: buySellSwitch.value,
                                  onChanged: (val) {
                                    buySellSwitch.value = val;
                                  },
                                  activeThumbColor: Colors.green,
                                  inactiveThumbColor: Colors.red,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Buy",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Center(child: Text("Client Name"))),
                        // Expanded(child: Center(child: Text("Net"))),
                        Expanded(child: Center(child: Text("qty"))),
                        Expanded(child: Center(child: Text("Total"))),
                      ],
                    ),
                    const Divider(),
                    Column(
                      children: List.generate(userListWithQty.length,
                          (index) => userListWithQty[index]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButton(
                          text: "Add To Bucket",
                          onPress: () {
                            setState(() {
                              for (int i = 0; i < userListWithQty.length; i++) {
                                print("CC=> ${userListWithQty[i].userModel.clientcode}");
                                if (userListWithQty[i].totalCtr.text != "0") {
                                  basketList.add(BasketOrderListModel(
                                      clientCode: userListWithQty[i].userModel.clientcode,
                                      producttype: productTypeList[
                                      productTypeNotifier.value],
                                      ordertype: buySellSwitch.value ? "BUY" : "SELL",
                                      variety: varityList[varietyNotifier.value],
                                      symboltoken:
                                      basketOrderController.symboltoken.value,
                                      exchange: tradingExchangeCtr.text,
                                      privateKey:
                                      userListWithQty[i].userModel.privateKey,
                                      jwtToken:
                                      userListWithQty[i].userModel.jwtToken,
                                      username:
                                      userListWithQty[i].userModel.username,
                                      totalQty: userListWithQty[i].totalCtr.text,
                                      tradingsymbol: tradingSymbolCtr.text,
                                      oderType: buySellSwitch.value ? "BUY" : "SELL",
                                      price: TriggerPriceCtr.text));
                                }
                              }

                              basketList.sort(
                                      (a, b) => b.oderType!.compareTo(a.oderType!));

                              for (var item in basketList) {
                                print("item=> ${item.clientCode}");
                              }
                              print("LLeee=> ${basketList.length}");
                              print("LLeee=> ${varityList[varietyNotifier.value]}");
                            });
                        },
                        ),
                        AppButton(onPress: () async {

                          if (basketList.isNotEmpty) {
                            for (int i = 0; i < basketList.length; i++) {
                              orderController.placeOrderList.add(
                                  PlaceOrderModel(
                                      clientcode: basketList[i].clientCode.toString(),
                                      variety: basketList[i].variety.toString(),
                                      tradingsymbol: basketList[i]
                                          .tradingsymbol
                                          .toString(),
                                      symboltoken:
                                      basketList[i].symboltoken.toString(),
                                      transactiontype:
                                      basketList[i].ordertype.toString(),
                                      exchange:
                                      basketList[i].exchange.toString(),
                                      ordertype: "LIMIT",
                                      producttype:
                                      basketList[i].producttype.toString(),
                                      duration: "DAY",
                                      price: basketList[i].price.toString(),
                                      quantity:
                                      basketList[i].totalQty.toString()));
                            }
                            var cleanList = orderController.placeOrderList.map((e) => e.toJson()).toList();
                            print("Json Basket => ${jsonEncode(cleanList)}");
                            orderController.getPlaceOrdersApi(isBasketOrder: true,
                                placeOderList: orderController.placeOrderList);
                          }
                        }, text: "Confirm Order")
                      ],
                    ),
                    SizedBox(
                      height: 500,
                      width: Get.width,
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: basketList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      //color of shadow
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      // blur radius
                                      offset: const Offset(
                                          1, 2), // changes position of shadow
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${basketList[index].tradingsymbol}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                basketList.removeAt(index);
                                              });
                                            },
                                            child: const Icon(Icons.delete))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "Oder Price : ${basketList[index].price}",
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          Text(
                                            "${basketList[index].oderType}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: basketList[index]
                                                            .oderType ==
                                                        "BUY"
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                        "Lot Size : ${basketList[index].totalQty}",
                                        style: const TextStyle(fontSize: 16)),
                                    Text("User : ${basketList[index].username}",
                                        style: const TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() => orderController.isPlaceOrderLoading.value
                ? Container(
              color: Colors.grey.withValues(alpha: 0.3),
              child: Center(
                child: AppDialogs.progressWidget(),
              ),
            )
                : const SizedBox(),
            ),
          ],
        ));
  }

  Widget selectWhereHouseDropDownUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Trading Symbol",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            .paddingSymmetric(horizontal: 4.0),
        Obx(
          () => watchListController.basketWatchlist.isNotEmpty
              ? Container(
                  decoration: BoxDecoration(
                      // color: AppColor.active,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      // buttonColor: AppColor.black,
                      alignedDropdown: true,
                      child: DropdownButton(
                        isExpanded: true,
                        elevation: 4,
                        // iconEnabledColor: AppColor.black,
                        borderRadius: BorderRadius.circular(12),
                        items: watchListController.basketWatchlist.map((e) {
                          return DropdownMenuItem<int>(
                            value: e.position,
                            child: Text(e.tradingsymbol.toString(),
                                style: const TextStyle(color: Colors.black54)),
                          );
                        }).toList(),
                        value: basketOrderController
                            .selectedTredingSymbolePosition.value,
                        onChanged: (value) {
                          basketOrderController.onChange(value as int);
                          // GetSharePrice(i: value);
                          TriggerPriceCtr.clear();
                          tradingSymbolCtr.text = watchListController
                              .basketWatchlist[basketOrderController
                                  .selectedTredingSymbolePosition.value]
                              .tradingsymbol
                              .toString();
                          priceCtr.text = watchListController
                              .basketWatchlist[basketOrderController
                                  .selectedTredingSymbolePosition.value]
                              .ltp
                              .toString();
                          tradingExchangeCtr.text = watchListController
                              .basketWatchlist[basketOrderController
                                  .selectedTredingSymbolePosition.value]
                              .exchange
                              .toString();
                          lotSizeCtr.text = watchListController
                              .basketWatchlist[basketOrderController
                                  .selectedTredingSymbolePosition.value]
                              .lotsize
                              .toString();
                          basketOrderController.lotSize.value = lotSizeCtr.text;
                          basketOrderController.symboltoken.value =
                              watchListController
                                  .basketWatchlist[basketOrderController
                                      .selectedTredingSymbolePosition.value]
                                  .symboltoken
                                  .toString();
                        },
                      ),
                    ),
                  ),
                )
              : const SizedBox(child: Text("No dt ")),
        )
      ],
    );
  }
}

class GetUserListForOrder extends StatelessWidget {
  UserModel userModel;
  TextEditingController qtyCtr = TextEditingController(text: "0");
  TextEditingController lotSizeCtr = TextEditingController(text: "0");
  TextEditingController totalCtr = TextEditingController(text: "0");
  // String lotSize;

  GetUserListForOrder({required this.userModel});

  final BasketOrderController basketOrderController =
      Get.isRegistered<BasketOrderController>()
          ? Get.find<BasketOrderController>()
          : Get.put(BasketOrderController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Center(child: Text("${userModel.username}"))),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: Get.width * 0.30,
                child: Center(
                  child: RegTxtField(keyboardType: TextInputType.phone,
                    ctr: qtyCtr,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        try {
                          totalCtr.text = ((int.parse(
                                      basketOrderController.lotSize.value)) *
                                  int.parse(val))
                              .toString();

                          print(totalCtr.text);
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        try {
                          totalCtr.text = ((int.parse(
                                      basketOrderController.lotSize.value)) *
                                  0)
                              .toString();

                          print(totalCtr.text);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: Get.width * 0.30,
                child: Center(
                  child: RegTxtField(isReadOnly: true, ctr: totalCtr),
                ),
              ),
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
