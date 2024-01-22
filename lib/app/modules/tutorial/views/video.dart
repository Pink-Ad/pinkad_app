import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pink_ad/app/modules/signup/views/signup_view.dart';
import 'package:video_player/video_player.dart';

class PromoScreem extends StatefulWidget {
  const PromoScreem({Key? key, required this.videoUrl, required this.promoText})
      : super(key: key);
  final String videoUrl;
  final String promoText;

  @override
  State<PromoScreem> createState() => _PromoScreemState();
}

class _PromoScreemState extends State<PromoScreem> {
  late Future<void> _initializeVideoPlayerFuture;
  // VideoPlayerController _controller;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayerFuture =
        VideoPlayerController.network(widget.videoUrl).initialize();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      // aspectRatio: videoPlayerController.value.aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
      // allowFullScreen: true,
      // allowPlaybackSpeedChanging: true,
      // fullScreenByDefault: true,

      errorBuilder: (context, errorMessage) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  bool mute = false;
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double height = media.height;
    double width = media.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Chewie(controller: chewieController);
                } else {
                  return Container(
                    height: height,
                    width: width,
                    color: Colors.transparent,
                    child: MyProcessLoading(),
                  );
                }
              },
            ),
            Positioned(
              top: 10,
              left: 10,
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                  height: 35.h,
                  width: 35.h,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
