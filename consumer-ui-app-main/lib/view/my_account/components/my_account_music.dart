import 'package:black_locust/controller/background_music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicSettingsCard extends StatelessWidget {
  MusicSettingsCard({Key? key}) : super(key: key);
  final _controller = Get.find<MusicController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          // margin: const EdgeInsets.all(16),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Music Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 16),

                // Music Status Row
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFFFF3CC),
                        child: Icon(Icons.music_note, color: Color(0xFFF9A825)),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Music: Playing',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Soothing Pharmacy',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _controller.isPlaying.value == true
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                        ),
                        iconSize: 32,
                        color: const Color(0xFFF9A825),
                        onPressed: () {
                          _controller.togglePlayPause();
                        },
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Volume and Speed labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Volume'),
                    Text('Speed'),
                  ],
                ),
                const SizedBox(height: 8),

                // Volume and Speed sliders
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _controller.volume.value,
                        min: 0,
                        max: 1,
                        divisions: 10,
                        onChanged: (e) {
                          _controller.updateVolume(e);
                        },
                        activeColor: const Color(0xFFF9A825),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Slider(
                        value: _controller.speed.value,
                        min: 0.5,
                        max: 2.0,
                        divisions: 15,
                        onChanged: (e) {
                          _controller.updateSpeed(e);
                        },
                        activeColor: const Color(0xFFF9A825),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // View Settings Button
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Open full settings
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xFFEFFAF1),
                //       foregroundColor: const Color(0xFF2ECC71),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //     ),
                //     child: const Text('View Music Settings'),
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}
