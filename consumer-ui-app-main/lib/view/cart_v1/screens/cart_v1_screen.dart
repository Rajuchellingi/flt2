// ignore_for_file: unused_element, invalid_use_of_protected_member, unnecessary_null_comparison, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/cart_v1_controller.dart';
import 'package:black_locust/controller/order_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart_v1/components/cart_footer.dart';
import 'package:black_locust/view/cart_v1/components/cart_summary_v1.dart';
import 'package:black_locust/view/cart_v1/components/cart_v1_blocks.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartV1Screen extends StatelessWidget {
  final _controller = Get.find<CartV1Controller>();
  final themeController = Get.find<ThemeController>();
  final _orderSettingController = Get.find<OrderSettingController>();

  @override
  Widget build(BuildContext context) {
    var header = _controller.template.value['layout']['header'];
    return Obx(() {
      var footer = _controller.template.value['layout']['footer'];
      var actionButton = themeController.floatingActionButton(footer);
      var isDesign3 = themeController.bottomBarType.value == 'design3';
      var orderType = _orderSettingController.orderSetting.value.orderType;
      print("orderType ---->>>>>>>>>>>>>>>>>>>>>>>>>> ${orderType}");
      final brightness = Theme.of(context).brightness;
      return SafeArea(
          child: Scaffold(
        body: Stack(children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 0.0,
                elevation: 0.0,
                forceMaterialTransparency: true,
                surfaceTintColor: themeController.headerStyle('backgroundColor',
                    header['style']['root']['backgroundColor']),
                backgroundColor: themeController.headerStyle('backgroundColor',
                    header['style']['root']['backgroundColor']),
                title: CommonHeader(header: header),
                bottom: PreferredSize(
                    child: Obx(() => (_controller.isLoading.value ||
                            _controller.isProgress.value)
                        ? LinearProgressIndicator(
                            backgroundColor: (brightness == Brightness.dark &&
                                    kPrimaryColor == Colors.black)
                                ? Colors.white
                                : Color.fromRGBO(
                                    kPrimaryColor.red,
                                    kPrimaryColor.green,
                                    kPrimaryColor.blue,
                                    0.2),
                            color: kPrimaryColor,
                          )
                        : SizedBox.shrink()),
                    preferredSize: Size.fromHeight(3.0)),
                pinned: true,
              ),
              if (_controller.productList.value != null &&
                  _controller.productList.value.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: CartSummary(
                      price: _controller.totlSummary.value,
                      controller: _controller),
                ),
                // SliverAppBar(
                //   expandedHeight: 70,
                //   collapsedHeight: 70,
                //   flexibleSpace: Center(
                //     child: Container(
                //         margin: EdgeInsets.symmetric(horizontal: 15),
                //         child: ElevatedButton(
                //           onPressed: () {
                //             _controller.openCheckoutPage();
                //           },
                //           child: Text("Express Checkout",
                //               style: TextStyle(color: Colors.white)),
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: kPrimaryColor,
                //             minimumSize: Size(double.infinity, 45),
                //           ),
                //         )),
                //   ),
                //   // expandedHeight: 70.0,
                //   automaticallyImplyLeading: false,
                //   pinned: true,
                //   surfaceTintColor: const Color.fromRGBO(250, 250, 250, 1),
                // ),
                SliverAppBar(
                  expandedHeight: 70,
                  collapsedHeight: 70,
                  flexibleSpace: Center(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            _controller.openCheckoutPage(_controller);
                          },
                          child: Text(
                            orderType == 'enquiry'
                                ? "Enquire Now"
                                : orderType == 'booking'
                                    ? "Book Now"
                                    : "Express Checkout",
                            style: TextStyle(
                                color: orderType == 'booking'
                                    ? kPrimaryColor
                                    : kSecondaryColor),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orderType == 'booking'
                                ? Colors.black
                                : kPrimaryColor,
                            minimumSize: Size(double.infinity, 45),
                          ),
                        )),
                  ),
                  // expandedHeight: 70.0,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  surfaceTintColor: const Color.fromRGBO(250, 250, 250, 1),
                ),
              ],
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _controller.isLoading.value
                        ? Container()
                        : (_controller.productList.value != null &&
                                _controller.productList.value.isNotEmpty)
                            ? Container(
                                // height: MediaQuery.of(context).size.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CartBlocksV1(controller: _controller),
                                    SizedBox(height: 15),
                                  ],
                                ),
                              )
                            : Container(
                                height: SizeConfig.screenHeight / 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/empty_cart.png',
                                      height: 150.0,
                                      width: 150.0,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 20.0),
                                    Text(
                                      'Your cart is empty',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  ],
                ),
              ),
            ],
          ),
        ]),
        floatingActionButtonLocation:
            isDesign3 ? FloatingActionButtonLocation.centerDocked : null,
        floatingActionButton: (isDesign3 && actionButton != null)
            ? CustomFAB(
                template: _controller.template.value,
                actionButton: actionButton)
            : null,
        extendBody: themeController.bottomBarType.value == 'design1' &&
            footer['componentId'] == 'footer-navigation',
        bottomNavigationBar: CartFooter(controller: _controller),
      ));
    });
  }
}
