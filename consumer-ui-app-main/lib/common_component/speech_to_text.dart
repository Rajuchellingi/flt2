// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/speech_to_text_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpeechToTextPopup extends StatefulWidget {
  @override
  State<SpeechToTextPopup> createState() => _SpeechSampleAppState();
}

class _SpeechSampleAppState extends State<SpeechToTextPopup> {
// class SpeechToText extends StatelessWidget {
  final _controller = Get.find<SpeechToTextController>();
  @override
  void initState() {
    super.initState();
    _controller.initSpeechState(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => AlertDialog(
          title: const Text(
            'What are you looking for?',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: .26,
                          spreadRadius: _controller.level.value * 1.5,
                          color: Color(0xffba2f28).withOpacity(.5))
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: InkWell(
                    child: const Icon(
                      Icons.mic,
                      size: 35,
                      color: const Color(0xffba2f28),
                    ),
                    onTap: () {
                      _controller.startListening();
                    },
                  )),
              const SizedBox(height: 15),
              Text(_controller.lastWords.value)
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                backgroundColor: kPrimaryColor,
                foregroundColor: kSecondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Close",
                  style: const TextStyle(color: kSecondaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
