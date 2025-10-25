import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/add_review_controller.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/view/add_review/components/review_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReviewBody extends StatelessWidget {
  const AddReviewBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final AddReviewController _controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              const Text('Add a review',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () => _controller.addStarRating(i),
                    child: Icon(
                      _controller.rating.value >= i
                          ? Icons.star
                          : Icons.star_border,
                      size: 30,
                      color: Colors.amber,
                    ),
                  ),
              ]),
              const SizedBox(height: 30),
              ReviewInput(
                textEditingController: _controller.titleController!,
                hintText: "Give your review a title",
                labelText: "Review Title",
                errorMsg: 'Review title is required',
                maxlength: 100,
                inputType: InputType.text,
                controller: _controller,
              ),
              const SizedBox(height: 30),
              ReviewInput(
                textEditingController: _controller.descriptionController!,
                hintText: "Write your review here",
                labelText: "Review",
                errorMsg: 'Review is required',
                maxlength: 5000,
                inputType: InputType.multiLine,
                controller: _controller,
              ),
              const SizedBox(height: 30),
              Center(
                  child: InkWell(
                      onTap: () {
                        _controller.submitReview();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Submit Review",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ))),
            ])))));
  }
}
