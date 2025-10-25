import 'package:black_locust/common_component/circle_icon_button.dart';
import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';
import '../../../controller/profile_controller.dart';
import 'package:get/get.dart';

class MyProfileBody extends StatelessWidget {
  const MyProfileBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  _buildNameCard(),
                  if (controller.phoneNumber != null) _buildPhoneCard(),
                  _buildEmailCard(),
                ],
              ),
      ),
    );
  }

  Widget _buildNameCard() {
    return Card(
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameContent(),
              _buildEditButton(() => controller.updateProfilePage("name")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNameContent() {
    final userProfile = controller.userProfile.value;
    final name = userProfile.contactName != null
        ? userProfile.contactName.toString()
        : "${userProfile.firstName.toString()} ${userProfile.lastName.toString()}";

    return buildContent('Customer Name', name);
  }

  Widget _buildPhoneCard() {
    return Card(
      surfaceTintColor: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildContent('Mobile Number', controller.phoneNumber!),
          _buildEditButton(() => controller.updateProfilePage("mobile")),
        ],
      ),
    );
  }

  Widget _buildEmailCard() {
    return Card(
      surfaceTintColor: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: buildContent(
              'Email Id',
              controller.userProfile.value.emailId.toString(),
            ),
          ),
          _buildEditButton(() => controller.updateProfilePage("email")),
        ],
      ),
    );
  }

  Widget _buildEditButton(VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
        horizontal: kDefaultPadding,
      ),
      child: CircleIconButton(
        height: 30,
        width: 30,
        icon: Icons.edit,
        color: kPrimaryColor,
        onPressed: onPressed,
      ),
    );
  }

  Padding buildContent(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
        horizontal: 8,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
