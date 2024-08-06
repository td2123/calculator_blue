import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/slider_screen.dart';

class SliderController extends GetxController {
  int selectedIndex = 0;
  int totalIndex = 0;
  PageController imagePageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  PageController textPageController =
  PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  List<SliderData> sliderList = [];

  changeIndex(value) {
    selectedIndex = value;
    update();
  }

  @override
  void onInit() {
    var sliderData = SliderData();
    sliderData.heading = "Accurate Percentage Calculations";
    sliderData.desc =
        "Easily calculate percentages for discounts, tips, and other everyday needs. Our calculator simplifies percentage calculations, providing quick and accurate results.";
    sliderData.image = "assets/slider_image/Calculator-bro.svg";
    sliderList.add(sliderData);
    sliderData = SliderData();
    sliderData.heading = "Instantaneous Results";
    sliderData.desc =
        "Receive instant feedback on your calculations. Our app is optimized to provide immediate results, ensuring that you can move quickly through your math tasks without delay.";
    sliderData.image = "assets/slider_image/Calculator-amico.svg";
    sliderList.add(sliderData);
    sliderData = SliderData();
    sliderData.heading = "Elegant and Practical Design";
    sliderData.desc =
        "Enjoy an elegant design that combines aesthetics with practicality. Our calculator is visually appealing and designed for optimal usability, making your calculation experience both pleasant and efficient.";
    sliderData.image = "assets/slider_image/Calculator-pana.svg";
    sliderList.add(sliderData);
    super.onInit();
  }
}
