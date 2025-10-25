// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member, unused_local_variable

import 'package:black_locust/controller/category_controller.dart';
import 'package:black_locust/view/category/components/menu_grid_expansion_panel.dart';
import 'package:black_locust/view/category/components/sub_menu_expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'menu_expansion_panel.dart';

class CategoryBodyV1 extends StatelessWidget {
  final _controller = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 30),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _controller.categoryList.value.length,
                  itemBuilder: (context, index) {
                    var menu =
                        _controller.categoryList.value[index].categoryDetails;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          menu.viewType == 'grid'
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      const BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 0)),
                                    ],
                                  ),
                                  child: MenuGridExpansionPanel(
                                    headerText: menu.categoryName,
                                    menu: menu,
                                    hasSubmenu: menu.children.length > 0,
                                    content: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (var subMenu in menu.children)
                                            InkWell(
                                                onTap: () {
                                                  _controller
                                                      .checkUrlAndNavigate(
                                                          subMenu.link);
                                                },
                                                child:
                                                    (subMenu.children != null &&
                                                            subMenu.children
                                                                    .length >
                                                                0)
                                                        ? SubMenuExpansionPanel(
                                                            hasSubmenu: subMenu
                                                                    .children
                                                                    .length >
                                                                0,
                                                            headerText: subMenu
                                                                .categoryName,
                                                            menu: subMenu,
                                                            content: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                for (var level2
                                                                    in subMenu
                                                                        .children)
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        _controller
                                                                            .checkUrlAndNavigate(level2.link);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                10),
                                                                        child: Text(
                                                                            level2.categoryName,
                                                                            style: const TextStyle(
                                                                                // fontWeight: FontWeight.w500,
                                                                                color: Colors.black,
                                                                                fontSize: 15)),
                                                                      ))
                                                              ],
                                                            ),
                                                          )
                                                        :
                                                        //
                                                        // Text("loading")
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    15,
                                                                    5,
                                                                    15,
                                                                    15),
                                                            child: Text(
                                                                subMenu
                                                                    .categoryName,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15)),
                                                          )
                                                //
                                                )
                                        ],
                                      ),
                                    ),
                                  ))
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: menu.children.length > 0
                                      ? BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                        )
                                      : null,
                                  child: MenuExpansionPanel(
                                    headerText: menu.categoryName,
                                    menu: menu,
                                    hasSubmenu: menu.children.length > 0,
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (var subMenu in menu.children)
                                          InkWell(
                                            onTap: () {
                                              _controller.checkUrlAndNavigate(
                                                  subMenu.link);
                                            },
                                            child: (subMenu.children != null &&
                                                    subMenu.children.length > 0)
                                                ? SubMenuExpansionPanel(
                                                    hasSubmenu: subMenu
                                                            .children.length >
                                                        0,
                                                    headerText:
                                                        subMenu.categoryName,
                                                    menu: subMenu,
                                                    content: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        for (var level2
                                                            in subMenu.children)
                                                          InkWell(
                                                            onTap: () {
                                                              _controller
                                                                  .checkUrlAndNavigate(
                                                                      level2
                                                                          .link);
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          10),
                                                              child: Text(
                                                                level2
                                                                    .categoryName,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 5, 15, 15),
                                                    child: Text(
                                                      subMenu.categoryName,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                        ]);
                  })),
        ])));
  }

  Container getListLevel2(context, categoryList) {
    return Container(
        child: InkWell(
            child: Text(categoryList.title),
            onTap: () {
              Navigator.pop(context);
              _controller.navigateToCollection(categoryList);
            }));
  }
}
