import 'package:calculator/calculator/controller/calculator_controller.dart';
import 'package:get/get.dart';

class CalculatorBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CalculatorController>(()=>CalculatorController());
  }

}