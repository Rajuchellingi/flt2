// ignore_for_file: unused_local_variable, unnecessary_null_comparison, deprecated_member_use, unused_field
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextController extends GetxController {
  var level = 0.0.obs;
  var lastWords = "Tap to speak".obs;
  var _hasSpeech = false.obs;
  late BuildContext context;
  bool _logEvents = false;
  final SpeechToText speech = SpeechToText();
  List<LocaleName> _localeNames = [];
  String _currentLocaleId = '';
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  bool _onDevice = false;

  @override
  void onInit() {
    super.onInit();
    // initSpeechState();
  }

  Future<void> initSpeechState(buildContext) async {
    context = buildContext;
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) {
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      // if (!mounted) return;

      _hasSpeech.value = hasSpeech;
      startListening();
    } catch (e) {
      _hasSpeech.value = false;
    }
  }

  void requestPermissions() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      // print('status $status');
      var result = await Permission.microphone.request();
      // print('reslt');
    }
  }

  void startListening() {
    _logEvent('start listening');
    lastWords.value = 'Listening...';
    final pauseFor = int.tryParse('10');
    final listenFor = int.tryParse('100');
    // Note that `listenFor` is the maximum, not the minimum, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 30),
      pauseFor: Duration(seconds: pauseFor ?? 5),
      listenOptions: SpeechListenOptions(listenMode: ListenMode.dictation),
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      onDevice: _onDevice,
    );
  }

  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    print(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    lastWords.value = result.recognizedWords;
    // Timer(Duration(seconds: 2), () {
    //   Get.toNamed('/searchPage', arguments: {"search": lastWords.value});
    // });

    level.value = 0.0;
  }

  void soundLevelListener(double value) {
    minSoundLevel = min(minSoundLevel, value);
    maxSoundLevel = max(maxSoundLevel, value);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    level.value = value;
  }

  void _logEvent(String eventDescription) {
    print(eventDescription);
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
    }
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
  }

  void statusListener(String status) {
    if (status == 'done' && lastWords.value != "Tap to speak") {
      Timer(Duration(seconds: 2), () {
        Get.back(result: lastWords.value);
      });
    }
    if (status == 'notListening') {
      level.value = 0.0;
      lastWords.value = "Tap to speak";
    }
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
  }

  @override
  void dispose() {
    speech.cancel();
    super.dispose();
  }
}
