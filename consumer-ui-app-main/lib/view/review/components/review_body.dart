// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/review_controller.dart';
import 'package:black_locust/model/review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewBody extends StatelessWidget {
  const ReviewBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final ReviewController _controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final int totalRatings = _controller.ratingData.value
          .fold<int>(0, (sum, rating) => sum + (rating['count'] as int));
      final double overallAverage = totalRatings > 0
          ? _controller.ratingData.value.fold<double>(0, (sum, rating) {
                final int stars = rating['stars'] as int;
                final int count = rating['count'] as int;
                return sum + (stars * count);
              }) /
              totalRatings
          : 0.0;
      return Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              controller: _controller.scrollController,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: const Text('Customer Reviews',
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center)),
                    const SizedBox(height: 10),
                    _buildOverallAverage(overallAverage),
                    const SizedBox(height: 5),
                    Text("Based On $totalRatings Reviews",
                        style: const TextStyle(fontWeight: FontWeight.w400)),
                    const SizedBox(height: 10),
                    Center(
                        child: Container(
                            width: SizeConfig.screenWidth * 0.7,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _controller.ratingData.value.map((
                                  rating,
                                ) {
                                  final int stars = rating['stars'] as int;
                                  final int count = rating['count'] as int;
                                  final double percentage = totalRatings > 0
                                      ? count / totalRatings
                                      : 0.0;
                                  return RatingProgressBarWithAverage(
                                    stars: stars,
                                    count: count,
                                    percentage: percentage,
                                  );
                                }).toList()))),
                    const SizedBox(height: 15),
                    Center(
                        child: InkWell(
                            onTap: () {
                              _controller.openAddReview();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: SizeConfig.screenWidth * 0.7,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text(
                                "Write a Review",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ))),
                    const SizedBox(height: 10),
                    for (var element in _controller.reviewList) ...[
                      ReviewItem(review: element)
                    ],
                    if (_controller.loading.value)
                      const Center(
                          child: const CircularProgressIndicator(
                              color: kPrimaryColor))
                  ],
                ),
              )));
    });
  }

  Widget _buildOverallAverage(double averageRating) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (index + 1 <= averageRating) {
          return const Icon(Icons.star, color: Colors.amber, size: 24);
        } else if (index < averageRating) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 24);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 24);
        }
      }),
    );
  }
}

class RatingProgressBarWithAverage extends StatelessWidget {
  final int stars;
  final int count;
  final double percentage;

  const RatingProgressBarWithAverage({
    Key? key,
    required this.stars,
    required this.count,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Star count
          Row(
            children: List.generate(
              5,
              (index) => stars > index
                  ? Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    )
                  : Icon(Icons.star_border, size: 16, color: Colors.amber),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: SizeConfig.screenWidth / 4.5,
            child: LinearProgressIndicator(
              value: percentage,
              color: Colors.amber,
              backgroundColor: Colors.grey[300],
              minHeight: 12,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 8),
          Text('${(percentage * 100).toStringAsFixed(1)}%', // Percentage
              style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          Text('($count)',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final ReviewVM review;

  const ReviewItem({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(),
        const SizedBox(height: 5),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.name != null ? "${review.name}" : 'Verified User',
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 2),
            Row(children: [
              for (int i = 1; i <= 5; i++)
                Icon(
                  review.rating! >= i ? Icons.star : Icons.star_border,
                  size: 20,
                  color: Colors.amber,
                ),
            ]),
            if (review.title != null)
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    review.title.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  )),
            if (review.body != null)
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  review.body.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
          ],
        )),
        SizedBox(height: 5),
      ]),
    );
  }
}
