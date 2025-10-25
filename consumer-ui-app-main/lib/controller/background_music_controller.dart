import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get_storage/get_storage.dart';

class MusicController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final RxDouble volume = 0.5.obs;
  final RxDouble speed = 1.0.obs;
  final RxBool isPlaying = false.obs;
  final RxBool isPlayMusic = false.obs;

  var songUrl;

  @override
  void onInit() {
    super.onInit();
  }

  startMusic(playMusic, song) {
    if (playMusic) {
      isPlayMusic.value = true;
      songUrl = song;
      var userId = GetStorage().read('utoken');
      if (userId != null) {
        _audioPlayer.setReleaseMode(ReleaseMode.loop);
        _audioPlayer.play(UrlSource(songUrl));
        isPlaying.value = true;
      }
    }
  }

  startMusicByLogin() {
    if (isPlayMusic.value) {
      var userId = GetStorage().read('utoken');
      if (userId != null) {
        _audioPlayer.setReleaseMode(ReleaseMode.loop);
        _audioPlayer.play(UrlSource(songUrl));
        isPlaying.value = true;
      }
    }
  }

  stopMusic() async {
    if (isPlaying.value) {
      await _audioPlayer.pause();
    }
  }

  void togglePlayPause() async {
    var status = isPlaying.value;
    isPlaying.value = !isPlaying.value;
    if (status) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.setVolume(volume.value);
      await _audioPlayer.setPlaybackRate(speed.value);
      await _audioPlayer.play(UrlSource(songUrl));
    }
  }

  void updateVolume(double val) {
    volume.value = val;
    _audioPlayer.setVolume(val);
  }

  void updateSpeed(double val) {
    speed.value = val;
    _audioPlayer.setPlaybackRate(val);
  }

  @override
  void onClose() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.dispose();
    } catch (e) {
      // Ensure disposal even if error occurs
      debugPrint('Error disposing audio player: $e');
    }
    super.onClose();
  }
}
