import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BasketOrderController extends GetxController {

  RxInt selectedTredingSymbolePosition = 0.obs;
RxString lotSize = "".obs;
RxString symboltoken = "".obs;

  void onChange(int pos) {
    selectedTredingSymbolePosition.value = pos;

  }



}