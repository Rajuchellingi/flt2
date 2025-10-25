import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/category_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBlockDesign6 extends StatelessWidget {
  CategoryBlockDesign6({
    Key? key,
    required controller,
    required this.menuLists,
  })  : _controller = controller,
        super(key: key);

  final List<dynamic> menuLists;
  final CategoryController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (var menu in menuLists)
          if ((menu['directLink'] == false &&
              menu['lists'] != null &&
              menu['lists'].length > 0)) ...[
            Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  trailing: Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Color.fromARGB(255, 213, 213, 213)))),
                      child: Icon(Icons.keyboard_arrow_down_sharp,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor)),
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: EdgeInsets.zero,
                  iconColor: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor,
                  title: Text(
                    menu['title'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor),
                  ),
                  children: [
                    for (var subMenu in menu['lists'])
                      SubItem(
                          text: subMenu['title'],
                          link: subMenu['link'],
                          controller: _controller)
                  ],
                )),
            const Divider(height: 1, color: Color.fromARGB(255, 213, 213, 213)),
          ] else ...[
            MenuTitle(
                text: menu['title'],
                link: menu['link'],
                controller: _controller),
            const Divider(height: 1, color: Color.fromARGB(255, 213, 213, 213)),
          ],
      ],
    );
  }
}

class MenuTitle extends StatelessWidget {
  final String text;
  final dynamic link;
  final CategoryController controller;
  const MenuTitle({required this.text, required this.controller, this.link});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      // visualDensity: const VisualDensity(vertical: -3),
      title: Text(
        text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: brightness == Brightness.dark
                ? Colors.white
                : kPrimaryTextColor),
      ),
      onTap: () {
        controller.navigateByUrlType(link);
      },
    );
  }
}

class SubItem extends StatelessWidget {
  final String text;
  final dynamic link;
  final CategoryController controller;
  const SubItem({required this.text, required this.controller, this.link});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: const VisualDensity(vertical: -3),
      title: Text(
        text,
        style: TextStyle(
            fontSize: 15,
            color: brightness == Brightness.dark
                ? Colors.white
                : kPrimaryTextColor),
      ),
      onTap: () {
        controller.navigateByUrlType(link);
      },
    );
  }
}
