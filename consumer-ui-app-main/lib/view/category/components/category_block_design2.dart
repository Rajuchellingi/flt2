// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:black_locust/const/size_config.dart';

import '../../../controller/category_controller.dart';

class CategoryBlockDesign2 extends StatelessWidget {
  CategoryBlockDesign2({
    Key? key,
    required controller,
    required this.menuLists,
    required this.theme,
  })  : _controller = controller,
        super(key: key);
  final List<dynamic> menuLists;
  final theme;
  final CategoryController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Section (30%)
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: (menuLists.length / getCount()).ceil(),
                itemBuilder: (context, menuIndex) {
                  int startIndex = menuIndex * getCount();
                  int endIndex = startIndex + getCount();
                  if (endIndex > menuLists.length) {
                    endIndex = menuLists.length;
                  }
                  var rowItems = menuLists.sublist(startIndex, endIndex);
                  return Padding(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int index = 0; index < rowItems.length; index++)
                          Container(
                            child: MenuItemWidget(
                              theme: theme,
                              controller: _controller,
                              index: menuIndex,
                              menu: menuLists,
                              menuItem: rowItems[index],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Right Section (70%)
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        _controller.selectedMenu.value['title'] ?? 'Loading...',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              _controller.selectedMenu.value['title'] == null
                                  ? 12
                                  : 17,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    for (var element
                        in _controller.selectedMenu.value['lists'] ?? [])
                      CategoryItem(
                        controller: _controller,
                        element: element,
                        title: _controller.selectedMenu.value['title'],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int getCount() {
    var width = SizeConfig.screenWidth;
    var count = 2;
    if (width > 700) {
      count = 3;
    } else {
      count = 2;
    }
    return count;
  }
}

class MenuItemWidget extends StatelessWidget {
  final menuItem;
  final int index;
  final menu;
  final theme;
  final CategoryController _controller;
  final themeController = Get.find<ThemeController>();

  MenuItemWidget(
      {Key? key,
      required controller,
      required this.menuItem,
      required this.theme,
      required this.index,
      required this.menu})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedIndex = menu.indexWhere((element) =>
        element['title'] == _controller.selectedMenu.value['title']);
    var currentIndex =
        menu.indexWhere((element) => element['title'] == menuItem['title']);

    return Obx(() {
      bool isSelected =
          _controller.selectedMenu.value['title'] == menuItem['title'];
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : themeController.headerStyle(
                  'backgroundColor', theme['style']['backgroundColor']),
          borderRadius: BorderRadius.only(
            bottomRight:
                Radius.circular((currentIndex == selectedIndex - 1) ? 10 : 0),
            topRight:
                Radius.circular(currentIndex == selectedIndex + 1 ? 10 : 0),
          ),
        ),
        child: InkWell(
          onTap: () {
            _controller.clickMenu(index, menuItem, context);
          },
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: isSelected ? 65 : 50,
                height: isSelected ? 65 : 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(
                      _controller.changeImageUrl(menuItem['image']),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  menuItem['title'],
                  style: TextStyle(
                    fontSize: isSelected ? 12 : 10.5,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.blue
                        : Color.fromARGB(255, 110, 110, 110), // Text color
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),

              // Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0),child: Divider(color: Colors.grey[100],),),
//               Container(
//   padding: const EdgeInsets.symmetric(horizontal: 5.0),
//   child: Divider(
//     color: Colors.grey[100],
//   ),
// ),
// Divider(),

              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    });
  }
}

class CategoryItem extends StatefulWidget {
  final element;
  final title;
  final CategoryController _controller;

  CategoryItem(
      {required this.title, required controller, required this.element})
      : _controller = controller;

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    var subMenu = widget.element['lists'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            widget._controller.navigateByUrlType(widget.element['link']);
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  widget.element['title'].toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.74,
          ),
          itemCount: _showAll
              ? subMenu.length
              : 6 > subMenu.length
                  ? subMenu.length
                  : 6,
          itemBuilder: (context, index) {
            var childElement = subMenu[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InkWell(
                onTap: () {
                  widget._controller.navigateByUrlType(childElement['link']);
                },
                child: Column(
                  children: [
                    Container(
                      width: widget._controller.selectedMenu.value['title'] ==
                              childElement['title']
                          ? 55
                          : 55,
                      height: widget._controller.selectedMenu['title'] ==
                              childElement['title']
                          ? 55
                          : 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget._controller
                                .changeImageUrl(childElement['image']),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        childElement['title'].toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (subMenu.length > 6)
          InkWell(
            onTap: () {
              setState(() {
                _showAll = !_showAll;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Icon(
                          _showAll ? Icons.arrow_upward : Icons.arrow_downward,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _showAll ? 'View less' : 'View all',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
