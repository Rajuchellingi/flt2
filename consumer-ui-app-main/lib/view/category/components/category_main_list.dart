import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryMainList extends StatelessWidget {
  get _controller => Get.find<CategoryController>();
  const CategoryMainList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Map<String, String>> list;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              color: kPrimaryColor,
              onRefresh: _controller.refreshMainPageCategory,
              child: ListView.builder(
                  itemCount: _controller.categoryList.length,
                  itemBuilder: (context, index) {
                    var category =
                        _controller.categoryList[index].categoryDetails;
                    var menu = _controller.categoryList[index];
                    var subMenu = menu.type == 'category'
                        ? category.children.where((e) => e.status == true)
                        : menu.type == 'directlink'
                            ? menu.subMenu.where((e) => e.status == true)
                            : menu.subMenu;
                    return ListTile(
                      onTap: () {
                        var pageIndex = 1;
                        _controller.onTabTapped(pageIndex, category, menu);
                      },
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      // leading: CircleAvatar(
                      //   radius: 30.0,
                      //   backgroundImage: NetworkImage(list[index]["image"]!),
                      //   backgroundColor: Colors.transparent,
                      // ),
                      title: menu.type == 'category'
                          ? Text(
                              category.categoryName,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kTextColor),
                            )
                          : Text(menu.title,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kTextColor)),
                      trailing: subMenu.length > 0
                          ? Padding(
                              padding: EdgeInsets.only(right: kDefaultPadding),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: kTextColor,
                                size: getProportionateScreenHeight(15),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(right: kDefaultPadding),
                            ),
                    );
                  }),
            ),
    );
  }
}
