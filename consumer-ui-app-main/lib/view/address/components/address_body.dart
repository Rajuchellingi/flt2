import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/address_controller.dart';
import 'package:black_locust/view/address/components/add_address_button.dart';
import 'package:black_locust/view/address/components/address_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressBody extends StatelessWidget {
  final AddressController _controller;

  const AddressBody(
      {Key? key, required this.isCheckOutPage, required controller})
      : _controller = controller,
        super(key: key);

  final isCheckOutPage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => _controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2, vertical: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isCheckOutPage
                      ? Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 20),
                          child: Text(
                            'Shipping Address',
                            style: headingStyle.copyWith(fontSize: 16),
                          ),
                        )
                      : Container(),
                  AddAddressButton(controller: _controller),
                  kDefaultHeight(kDefaultPadding),
                  Expanded(
                    child: Obx(
                      () => _controller.userAddress.length == 0
                          ? Container()
                          : ListView.builder(
                              itemCount: _controller.userAddress.length,
                              itemBuilder: (context, index) {
                                return AddressDetail(
                                  controller: _controller,
                                  isCheckOutPage: isCheckOutPage ?? false,
                                  address: _controller.userAddress[index],
                                  // isDefault:
                                  //     _controller.userAddress[index].isDefault,
                                  // onSetDefault: () {
                                  //   _controller.setAsDefault(index);
                                  // },
                                );
                              }),
                    ),
                  )
                ],
              ),
            )),
    );
  }

  Padding buildContent(String lable, String value) {
    final brightness = MediaQuery.of(Get.context!).platformBrightness;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lable,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor),
              ),
              kDefaultHeight(kDefaultPadding / 3),
              Text(value),
            ],
          )
        ],
      ),
    );
  }
}
