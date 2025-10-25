// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/category_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/category/components/category_block_design1_menu.dart';
import 'package:black_locust/view/category/components/category_block_design1_submenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBlockDesign1 extends StatelessWidget {
  CategoryBlockDesign1({
    Key? key,
    required controller,
    this.options,
    required this.menuLists,
  })  : _controller = controller,
        super(key: key);

  final List<dynamic> menuLists;
  final CategoryController _controller;
  final options;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: [
      Expanded(
          child: ListView.builder(
              itemCount: menuLists.length,
              itemBuilder: (context, index) {
                var menu = menuLists[index];
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                                  offset: Offset(0, 0)),
                            ],
                          ),
                          child: CategoryBlockDesign1Menu(
                            headerText: menu['title'],
                            link: menu['link'],
                            showTitle: (options != null &&
                                    options['hide-title'] == true)
                                ? false
                                : true,
                            controller: _controller,
                            image: menu['image'],
                            initiallyExpanded: false,
                            hasSubmenu: (menu['directLink'] == false &&
                                menu['lists'] != null &&
                                menu['lists'].length > 0),
                            content: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var subMenu in menu['lists'])
                                    InkWell(
                                        onTap: () {
                                          _controller.navigateByUrlType(
                                              subMenu['link']);
                                        },
                                        child: (subMenu['directLink'] ==
                                                    false &&
                                                subMenu['lists'] != null &&
                                                subMenu['lists'].length > 0)
                                            ? CategoryBlockDesign1Submenu(
                                                controller: _controller,
                                                hasSubmenu: (subMenu[
                                                            'directLink'] ==
                                                        false &&
                                                    subMenu['lists'] != null &&
                                                    subMenu['lists'].length >
                                                        0),
                                                headerText: subMenu['title'],
                                                link: subMenu['link'],
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    for (var level2
                                                        in subMenu['lists'])
                                                      InkWell(
                                                          onTap: () {
                                                            _controller
                                                                .navigateByUrlType(
                                                                    level2[
                                                                        'link']);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                            child: Text(
                                                                level2['title'],
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
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 5, 15, 15),
                                                child: Text(subMenu['title'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15)),
                                              )
                                        //
                                        )
                                ],
                              ),
                            ),
                          ))
                    ]);
              })),
    ]));
  }
}
