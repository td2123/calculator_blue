import 'dart:ui';

import 'package:calculator/calculator/view/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';
import '../controller/slider_controller.dart';

class SliderScreen extends StatelessWidget {
  SliderScreen({super.key});

  final SliderController sliderController = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderController>(builder: (logic) {
      return Scaffold(
        backgroundColor: CColor.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _sliderDetail(),
              _text(context),
              const SizedBox(height: 25),
              _nextButton()
            ],
          ),
        ),
      );
    });
  }
}

_nextButton() {
  return GetBuilder<SliderController>(builder: (logic) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () async {
        if (logic.selectedIndex == logic.sliderList.length - 1) {
          Get.offAll(CalculatorScreen());
        } else {
          logic.imagePageController.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn);
          logic.textPageController.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn);
        }
      },
      child: Container(
        height: 52,
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: CColor.darkThemColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          (logic.selectedIndex == logic.sliderList.length - 1)
              ? "Get Start"
              : "Next",
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              fontFamily: Font.nunito),
        ),
      ),
    );
  });
}

_text(BuildContext context) {
  double screenSize = Get.height;
  bool isSmallDevice = screenSize <= 750;
  return GetBuilder<SliderController>(builder: (logic) {
    return SizedBox(
      height: (isSmallDevice) ? Get.height * 0.2 : Get.height * 0.23,
      child: PageView.builder(
        itemCount: logic.sliderList.length,
        controller: logic.textPageController,
        onPageChanged: (value) {
          logic.imagePageController.jumpToPage(value);
          logic.changeIndex(value);
        },
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.045,
                right: Get.width * 0.045,
                top: Get.height * 0.04),
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        logic.sliderList[index].heading.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                            fontFamily: Font.nunito,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.045, right: Get.width * 0.045),
                      child: Text(
                        logic.sliderList[index].desc.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: Font.nunito,
                          color: CColor.white.withOpacity(0.7),
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  });
}

_sliderDetail() {
  return GetBuilder<SliderController>(builder: (logic) {
    return Container(
      color: CColor.black,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
            height: Get.height * 0.56,
            child: PageView.builder(
              itemCount: logic.sliderList.length,
              controller: logic.imagePageController,
              onPageChanged: (value) {
                logic.textPageController.jumpToPage(value);
                logic.changeIndex(value);
              },
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Expanded(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: logic.selectedIndex == index ? 1.0 : 0.0,
                        curve: Curves.bounceIn,
                        child: Container(
                          child: SvgPicture.asset(
                            logic.sliderList[index].image.toString(),
                            fit: BoxFit.contain,
                            // height: Get.height * 0.5,
                            width: Get.width,
                          ).animate().fadeIn(duration: 800.ms),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          (logic.selectedIndex == logic.sliderList.length - 1)
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.01, right: 15),
                  child: TextButton(
                      onPressed: () {
                        Get.offAll(CalculatorScreen());
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Font.nunito,
                            color: CColor.white),
                      )),
                )
        ],
      ),
    );
  });
}

class SliderData {
  String? desc;
  String? heading;
  String? image;

  SliderData({this.desc, this.image, this.heading});

  SliderData.fromJson(Map json) {
    desc = json['description'];
    heading = json['heading'];
    image = json['img'];
  }

  Map toJson() {
    final Map data = {};
    data['description'] = desc;
    data['heading'] = heading;
    data['img'] = image;

    return data;
  }
}
