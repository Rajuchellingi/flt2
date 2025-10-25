// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:black_locust/controller/wishlist_v1_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/constant.dart';

class WishlistV1Body extends StatelessWidget {
  const WishlistV1Body({
    Key? key,
    required this.wController,
  }) : super(key: key);
  final WishlistV1Controller wController;

  void _showDeleteConfirmationDialog(BuildContext context, collectionId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Collection'),
          content:
              const Text('Are you sure you want to delete this collection?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                wController.deleteOverallCollection(context, collectionId);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, collectionId, name) {
    final TextEditingController _nameController =
        TextEditingController(text: name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Collection Name'),
          content: TextField(
            controller: _nameController,
            decoration:
                const InputDecoration(hintText: 'Enter new collection name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                wController.updateCollectionName(
                    _nameController.text, collectionId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, String collectionId, name) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.delete),
                title: Text('Delete Collection'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showDeleteConfirmationDialog(context, collectionId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Collection Name'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showEditDialog(context, collectionId, name);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: wController.collectionAllList
                .asMap()
                .entries
                .map<Widget>((entry) {
              final index = entry.key;
              final filter = entry.value;
              return Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                  onTap: () {
                    wController.navigateToWishlistCollection(filter.sId);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            filter.name ?? '',
                            style: const TextStyle(
                                // color: kPrimaryColor,
                                ),
                            softWrap: true,
                          ),
                        ),
                        if (filter.name != 'My Wishlist')
                          IconButton(
                            icon: const Icon(Icons.more_vert,
                                color: Colors.black),
                            onPressed: () {
                              _showBottomSheet(
                                  context, filter.sId, filter.name);
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
