// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/address_controller.dart';
import 'package:flutter/material.dart';

class AddAddressButton extends StatelessWidget {
  final AddressController _controller;
  const AddAddressButton({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return InkWell(
      onTap: () {
        _controller.addAddressPage();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.5,
                color: brightness == Brightness.dark
                    ? Colors.white
                    : kPrimaryTextColor),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add,
                  size: 24,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor),
              Text(
                'Add New Address',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
