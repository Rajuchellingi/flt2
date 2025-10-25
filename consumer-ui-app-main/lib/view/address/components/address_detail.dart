// ignore_for_file: deprecated_member_use

import 'package:black_locust/common_component/circle_icon_button.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/address_controller.dart';
import 'package:flutter/material.dart';

class AddressDetail extends StatelessWidget {
  final AddressController _controller;
  const AddressDetail({
    Key? key,
    required controller,
    required this.address,
    // required this.isDefault,
    // required this.onSetDefault,
    this.isCheckOutPage = false,
    this.isEdit = true,
  })  : _controller = controller,
        super(key: key);

  final address;
  final isEdit;
  final isCheckOutPage;
  // final bool isDefault;
  // final Function onSetDefault;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.5,
                color: brightness == Brightness.dark
                    ? Colors.white
                    : kPrimaryTextColor),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Text(address.city + ', ' + address.province),
                  Text(
                    name(address),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor),
                  ),
                  kDefaultWidth(kDefaultPadding / 2),
                  // isEdit
                  //     ? address.billingAddress
                  //         ? ColorTextOrButton(
                  //             itemValue: 'billing',
                  //             colorCode: kPrimaryColor,
                  //             onPress: () {},
                  //           )
                  //         : Container()
                  //     : Container(),
                  // kDefaultWidth(kDefaultPadding / 2),
                  // isEdit
                  //     ? address.shippingAddress
                  //         ? ColorTextOrButton(
                  //             itemValue: 'shipping',
                  //             colorCode: kPrimaryColor,
                  //             onPress: () {},
                  //           )
                  //         : Container()
                  //     : Container()
                ],
              ),
              // Text(address.companyName),
              Text(address.address != null ? address.address : '',
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor)),
              Text(address.phone != null ? address.phone.toString() : '',
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor)),
              // Text(address.city),
              // Text(address.city + ', ' + address.province),
              Text(
                  (address.province == null || address.province == '')
                      ? address.city != null
                          ? address.city
                          : ''
                      : address.city + ', ' + address.province,
                  style: TextStyle(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor)),

              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(address.country != null ? address.country : '',
                      style: TextStyle(
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor)),
                  Text(address.zip != null ? ', ' + address.zip : '',
                      style: TextStyle(
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor)),
                ],
              ),
              kDefaultHeight(kDefaultPadding / 2),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  address.isDefault
                      ? InkWell(
                          onTap: () {
                            _controller.updateDefaltAddress(address.sId);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: isDarkMode
                                        ? kPrimaryColor == Colors.black
                                            ? Colors.white
                                            : kPrimaryColor.withOpacity(0.1)
                                        : kPrimaryColor.withOpacity(0.1)),
                                color: kPrimaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Default Address',
                              style: TextStyle(
                                color: isDarkMode
                                    ? kPrimaryColor == Colors.black
                                        ? Colors.white
                                        : kPrimaryColor
                                    : kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            _controller.updateDefaltAddress(address.sId);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: isDarkMode
                                        ? kPrimaryColor == Colors.black
                                            ? Colors.white
                                            : kPrimaryColor.withOpacity(0.1)
                                        : kPrimaryColor.withOpacity(0.1)),
                                color: kPrimaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Make Default Address',
                              style: TextStyle(
                                color: isDarkMode
                                    ? kPrimaryColor == Colors.black
                                        ? Colors.white
                                        : kPrimaryColor
                                    : kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                  isEdit
                      ? Row(
                          children: [
                            CircleIconButton(
                                icon: Icons.edit,
                                height: 35,
                                width: 35,
                                color: isDarkMode
                                    ? kPrimaryColor == Colors.black
                                        ? Colors.white
                                        : kPrimaryColor
                                    : kPrimaryColor,
                                onPressed: () {
                                  _controller.editAddress(address);
                                }),
                            kDefaultWidth(kDefaultPadding / 2),
                            CircleIconButton(
                                icon: Icons.delete_forever_rounded,
                                height: 35,
                                width: 35,
                                color: isDarkMode
                                    ? kPrimaryColor == Colors.black
                                        ? Colors.white
                                        : kPrimaryColor
                                    : kPrimaryColor,
                                onPressed: () {
                                  _controller.removeAddress(address.sId);
                                })
                          ],
                        )
                      : Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  name(detail) {
    if (detail.firstName != null && detail.lastName != null)
      return '${detail.firstName} ${detail.lastName}';
    else if (detail.firstName != null)
      return detail.firstName;
    else if (detail.lastName != null)
      return detail.lastName;
    else
      return '';
  }
}
