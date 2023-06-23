import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:sharek/app/data/models/private_message_model.dart';

import '../../../../core/widgets/network_image.dart';
import 'build_msg.dart';

class MessageOptions extends StatefulWidget {
  const MessageOptions({super.key, required this.msg, required this.heroTAG});
  final PrivateMessage msg;
  final String heroTAG;

  @override
  State<MessageOptions> createState() => _MessageOptionsState();
}

class _MessageOptionsState extends State<MessageOptions> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.network(widget.msg.video ?? "")
          ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: (widget.msg.time?.millisecondsSinceEpoch ?? 0).toString(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if ((widget.msg.image == null || widget.msg.image == 'null') &&
                  widget.msg.text != null &&
                  (widget.msg.video == null || widget.msg.video == 'null'))
                LinkPreviewText(
                  url: '${widget.msg.text}',
                )
              else
                const SizedBox(),
              if (widget.msg.image != null &&
                  (widget.msg.text == null || widget.msg.text == '') &&
                  (widget.msg.video == null || widget.msg.video == ''))
                InstaImageViewer(
                  disposeLevel: DisposeLevel.high,
                  child: AppCachedNetworkImage(
                    imageUrl: widget.msg.image ?? '',
                    //fit: BoxFit.cover,
                  ),
                )
              else
                const SizedBox(),
              if (widget.msg.video != null)
                CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController,
                )
              else
                const SizedBox(),
              const SizedBox(
                height: 1,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.check,
                    //    size: Dimensions.getDesirableWidth(4),
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
