import 'package:black_locust/const/constant.dart';
import 'package:black_locust/view/order_history/components/order_history_detail_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListDesign3 extends StatelessWidget {
  const OrderListDesign3({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return SafeArea(
      child: Obx(
        () => RefreshIndicator(
          color: kPrimaryColor,
          onRefresh: _controller.refreshPage,
          child: _controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _controller.orderList.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Stack(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  controller: _controller.scrollController,
                                  itemCount: _controller.orderList.length,
                                  itemBuilder: (context, index) {
                                    return OrderHistoryDetailDesign3(
                                        controller: _controller,
                                        orderItem:
                                            _controller.orderList[index]);
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
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                              ],
                            ))
                          ]))
                  : ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4),
                        Center(
                          child: Text('No Orders Found!',
                              style: TextStyle(
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : kPrimaryTextColor)),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
