// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/model/notification_history_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/constant.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({Key? key, required controller})
      : _controller = controller,
        super(key: key);
  final _controller;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Obx(() => _controller.isLoading.value
              ? const Center(
                  child: const CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                )
              : (_controller.historyList.value != null &&
                      _controller.historyList.value.length > 0)
                  ? RefreshIndicator(
                      color: kPrimaryColor,
                      onRefresh: _controller.refreshPage,
                      child: Stack(children: [
                        Obx(() => Container(
                            color: const Color.fromARGB(255, 239, 239, 239),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: ListView.builder(
                              controller: _controller.scrollController,
                              itemCount: _controller.historyList.length,
                              itemBuilder: (context, index) {
                                final notification =
                                    _controller.historyList[index];
                                return NotificationCard(
                                  controller: _controller,
                                  notification: notification,
                                );
                              },
                            ))),
                        Obx(() => _controller.loading.value
                            ? Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 80.0,
                                  child: const Center(
                                    child: const CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                              )
                            : Container())
                      ]))
                  : const Center(
                      child: const Text('No Record Found!'),
                    )))
    ]);
  }
}

String formatTimeDifference(dateString) {
  DateTime now = DateTime.now();
  DateTime date = DateTime.parse(dateString); // Convert the String to DateTime
  Duration difference = now.difference(date);

  if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
  } else {
    return 'Just now';
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {Key? key, required this.notification, required controller})
      : _controller = controller,
        super(key: key);
  final _controller;
  final NotificationHistoryDataVM notification;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _controller.onTapNotification(notification);
        },
        child: Card(
            color: notification.notificationStatus == 'unread'
                ? const Color.fromARGB(255, 237, 247, 255)
                : const Color.fromARGB(255, 255, 255, 255),
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title.toString(),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatTimeDifference(notification.creationDate),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (notification.image != null)
                          Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: CachedNetworkImage(
                                imageUrl: notification.image.toString(),
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                placeholder: (context, url) {
                                  return Container(
                                      color: const Color.fromARGB(
                                          255, 205, 205, 205));
                                },
                                errorWidget: (context, url, error) {
                                  return Container(
                                      color: const Color.fromARGB(
                                          255, 205, 205, 205));
                                },
                              )),
                        Expanded(
                          child: Text(notification.description.toString()),
                        ),
                      ],
                    )
                  ],
                ))));
  }
}
