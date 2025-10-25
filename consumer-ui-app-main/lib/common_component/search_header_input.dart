// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchHeaderInput extends StatelessWidget {
  SearchHeaderInput({
    Key? key,
    required this.headerOption,
    required this.header,
  }) : super(key: key);
  final headerOption;
  final header;
  final themeController = Get.find<ThemeController>();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
          onTap: () {
            themeController.navigateByType('search');
          },
          child: AbsorbPointer(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 12.0),
              decoration: InputDecoration(
                hintText: headerOption['placeholder'],
                hintStyle: const TextStyle(fontSize: 12.0),
                prefixIcon: Icon(Icons.search,
                    color: header['source']['transparent'] == true
                        ? const Color(0xFFE8E8E8)
                        : brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: header['source']['transparent'] == true
                            ? const Color(0xFFE8E8E8)
                            : brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: header['source']['transparent'] == true
                            ? const Color(0xFFE8E8E8)
                            : brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: header['source']['transparent'] == true
                          ? const Color(0xFFE8E8E8)
                          : brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black),
                ),
                filled: true,
                fillColor: header['source']['transparent'] == true
                    ? Colors.transparent
                    : themeController.headerStyle('backgroundColor',
                        header['style']['search-input']['backgroundColor']),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close,
                            color: header['source']['transparent'] == true
                                ? const Color(0xFFE8E8E8)
                                : brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                        onPressed: _clearSearch,
                      )
                    : headerOption['show-voice-search'] == true
                        ? IconButton(
                            icon: Icon(Icons.mic,
                                color: header['source']['transparent'] == true
                                    ? const Color(0xFFE8E8E8)
                                    : brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                            onPressed: _openVoiceInput,
                          )
                        : null,
              ),
            ),
          ),
        ));
  }

  void _clearSearch() {
    _searchController.clear();
  }

  void _openVoiceInput() {}
}
