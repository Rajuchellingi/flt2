import 'package:black_locust/const/constant.dart';
import 'package:black_locust/view/enquiry_history/components/enquiry_history_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnquiryHistoryBody extends StatelessWidget {
  const EnquiryHistoryBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: _controller.refreshPage,
        child: _controller.isLoading.value
            ? const Center(
                child: const CircularProgressIndicator(),
              )
            : _controller.orderList.isNotEmpty
                ? Stack(
                    children: [
                      ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _controller.scrollController,
                        itemCount: _controller.orderList.length,
                        itemBuilder: (context, index) {
                          return EnquiryHistoryDetail(
                              controller: _controller,
                              orderItem: _controller.orderList[index]);
                        },
                      ),
                      if (_controller.loading.value)
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 80.0,
                            child: const Center(
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                        )
                    ],
                  )
                : ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4),
                      const Center(
                        child: const Text('No Orders Found!'),
                      ),
                    ],
                  ),
      ),
    );
  }
}
