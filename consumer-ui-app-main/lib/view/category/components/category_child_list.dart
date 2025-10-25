import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryChildList extends StatefulWidget {
  const CategoryChildList({
    Key? key,
    required this.subCategory,
  }) : super(key: key);

  final subCategory;

  @override
  _CategoryChildListState createState() => _CategoryChildListState();
}

class _CategoryChildListState extends State<CategoryChildList> {
  get _controller => Get.find<CategoryController>();

  int selected = 0; //attention

  @override
  Widget build(BuildContext context) {
    var subCategory = _controller.subCategoryList.value;
    var menuType = _controller.menuType.value;
    var menu = _controller.menu.value;
    return Container(
      child: menuType == 'category'
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: InkWell(
                          onTap: () {
                            _controller
                                .onBackTapped(_controller.pageIndex.value - 1);
                          },
                          child: Container(
                              height: 30,
                              width: 30,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(Icons.arrow_back))),
                    ),
                    Align(
                        child: Text(
                      subCategory.categoryName,
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(16),
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
                kDefaultHeight(kDefaultPadding),
                Expanded(
                  child: RefreshIndicator(
                    color: kPrimaryColor,
                    onRefresh: _controller.refreshMainPageCategory,
                    child: ListView.builder(
                      key: Key('builder ${selected.toString()}'),
                      itemCount: subCategory.children.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: subCategory.children[index].children.length >
                                    0
                                ? ExpansionTile(
                                    key: Key(index.toString()),
                                    initiallyExpanded: index == selected,
                                    expandedAlignment: Alignment.topLeft,
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    onExpansionChanged: ((newState) {
                                      if (newState)
                                        setState(() {
                                          selected = index;
                                        });
                                      else
                                        setState(() {
                                          selected = -1;
                                        });
                                    }),
                                    title: Text(
                                      subCategory.children[index].categoryName,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: index == selected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          color: kTextColor),
                                    ),
                                    children: List.generate(
                                      subCategory
                                          .children[index].children.length,
                                      (childindex) => InkWell(
                                        onTap: () {
                                          _controller.checkUrlAndNavigate(
                                              subCategory.children[index]
                                                  .children[childindex].link);
                                          // var data = {
                                          //   "categoryLink": subCategory
                                          //       .children[index]
                                          //       .children[childindex]
                                          //       .categoryName,
                                          //   "link": subCategory.children[index]
                                          //       .children[childindex].link,
                                          //   "page": 1
                                          // };
                                          // Get.toNamed('/productList',
                                          //     arguments: data);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: kDefaultPadding + 10,
                                              bottom: kDefaultPadding / 2),
                                          child: Text(
                                            subCategory
                                                .children[index]
                                                .children[childindex]
                                                .categoryName,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      _controller.checkUrlAndNavigate(
                                          subCategory.children[index].link);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: kDefaultPadding + 10,
                                          bottom: kDefaultPadding / 2),
                                      child: Text(
                                        subCategory
                                            .children[index].categoryName,
                                      ),
                                    )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: InkWell(
                          onTap: () {
                            _controller
                                .onBackTapped(_controller.pageIndex.value - 1);
                          },
                          child: Container(
                              height: 30,
                              width: 30,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(Icons.arrow_back))),
                    ),
                    Align(
                        child: Text(
                      menu.title,
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(16),
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
                kDefaultHeight(kDefaultPadding),
                Expanded(
                  child: RefreshIndicator(
                    color: kPrimaryColor,
                    onRefresh: _controller.refreshMainPageCategory,
                    child: ListView.builder(
                      key: Key('builder ${selected.toString()}'),
                      itemCount: menu.subMenu.length,
                      itemBuilder: (context, index) {
                        var subMenuChild =
                            (menu.subMenu[index].children != null &&
                                    menu.subMenu[index].children.length > 0)
                                ? menu.subMenu[index].children
                                    .where((e) => e.status == true)
                                : [];
                        return Container(
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: subMenuChild.length > 0
                                ? ExpansionTile(
                                    key: Key(index.toString()),
                                    initiallyExpanded: index == selected,
                                    expandedAlignment: Alignment.topLeft,
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    onExpansionChanged: ((newState) {
                                      if (newState)
                                        setState(() {
                                          selected = index;
                                        });
                                      else
                                        setState(() {
                                          selected = -1;
                                        });
                                    }),
                                    title: Text(
                                      menu.subMenu[index].title,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: index == selected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          color: kTextColor),
                                    ),
                                    children: List.generate(
                                      menu.subMenu[index].children.length,
                                      (childindex) => InkWell(
                                        onTap: () {
                                          var data = {
                                            "categoryLink": menu
                                                .subMenu[index]
                                                .children[childindex]
                                                .categoryName,
                                            "link": subCategory.children[index]
                                                .children[childindex].link,
                                            "page": 1
                                          };
                                          Get.toNamed('/productList',
                                              arguments: data);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: kDefaultPadding + 10,
                                              bottom: kDefaultPadding / 2),
                                          child: Text(
                                            subCategory
                                                .children[index]
                                                .children[childindex]
                                                .categoryName,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: kDefaultPadding + 10,
                                        bottom: kDefaultPadding / 2),
                                    child: InkWell(
                                        onTap: () {
                                          String combinedTitle =
                                              // "${menu.title} ${menu.subMenu[index].title}";
                                              "${menu.subMenu[index].title}";
                                          _controller.navigateToCollection(
                                              combinedTitle);
                                          // _controller.navigateToCollection(
                                          //     menu.subMenu[index].title);
                                        },
                                        child: Text(menu.subMenu[index].title)),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
