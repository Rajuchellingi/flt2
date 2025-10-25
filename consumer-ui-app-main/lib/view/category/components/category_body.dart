import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../landing_page/components/floating_bottom_app_bar.dart';
import '../components/category_main_list.dart';
import '../components/category_child_list.dart';

class CategoryBody extends StatelessWidget {
  get _controller => Get.find<CategoryController>();
  final List<Map<String, String>> list = [
    // {
    //   "image":
    //       "https://b2b-subscribe.s3.ap-south-1.amazonaws.com/rinteger/category/60fd1a9bfc1c270009224893/72abae43-710c-4e2f-a463-e5b20b7f6554-men.jpg",
    //   "name": "Boy"
    // },
    // {
    //   "image":
    //       "https://b2b-subscribe.s3.ap-south-1.amazonaws.com/rinteger/category/60fd1a9bfc1c270009224893/72abae43-710c-4e2f-a463-e5b20b7f6554-men.jpg",
    //   "name": "Women's Fashion"
    // },
    {
      "image":
          "https://i1.wp.com/www.indiaretailing.com/wp-content/uploads/2019/09/one8-kids-03.jpg?resize=681%2C400&ssl=1",
      "name": "Kids Fashion"
    },
    {
      "image":
          "https://i1.wp.com/www.indiaretailing.com/wp-content/uploads/2019/09/one8-kids-03.jpg?resize=681%2C400&ssl=1",
      "name": "Kids"
    },
    {
      "image":
          "https://i1.wp.com/www.indiaretailing.com/wp-content/uploads/2019/09/one8-kids-03.jpg?resize=681%2C400&ssl=1",
      "name": "Men"
    },
  ];
  @override
  Widget build(BuildContext context) {
    // print()
    return SafeArea(
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: kDefaultPadding),
          child: PageView(
            physics: new NeverScrollableScrollPhysics(),
            children: [
              CategoryMainList(list: list),
              CategoryChildList(subCategory: _controller.subCategoryList.value)
            ],
            onPageChanged: _controller.onPageChanged,
            controller: _controller.pageController,
          ),
        ),
        // Positioned(
        //     bottom: 10, left: 10, right: 10, child: FloatingBottomAppBar()),
      ]),
    );
  }
}
