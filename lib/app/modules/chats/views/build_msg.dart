// ignore_for_file: must_be_immutable, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:developer';
import 'package:background_downloader/background_downloader.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart' hide Size;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/widgets/network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sharek/app/data/models/private_message_model.dart';

import '../../../../core/constants/theme/theme_export.dart';
import '../../../../core/services/chat/private/private_chat.dart';

class MessageBuilder extends StatefulWidget {
  final PrivateMessage? msg;
  final bool isMe;
  final String hisId;
  final String myID;

  const MessageBuilder(
      {super.key,
      this.msg,
      this.isMe = true,
      required this.hisId,
      required this.myID});

  @override
  State<MessageBuilder> createState() => _MessageBuilderState();
}

class _MessageBuilderState extends State<MessageBuilder> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.network(widget.msg?.video ?? "")
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
    if (widget.isMe) {
      return CupertinoContextMenu(
        actions: [
          if (widget.msg?.text != null)
            CupertinoContextMenuAction(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(
                    text: widget.msg?.text ?? "",
                  ),
                );
                Navigator.pop(context);
              },
              trailingIcon: Iconsax.copy,
              child: const Text("نسخ "),
            ),
          if (widget.msg?.image != null)
            CupertinoContextMenuAction(
              onPressed: () async {
                /// define the download task (subset of parameters shown)
                final task = DownloadTask(
                    url: widget.msg?.image ?? "",
                    requiresWiFi: false,
                    retries: 5,
                    allowPause: true,
                    metaData: 'sharek video');

// Start download, and wait for result. Show progress and status changes
// while downloading
                final result = await FileDownloader().download(
                  task,
                );

// Act on the result
                switch (result.status) {
                  case TaskStatus.complete:
                    BotToast.showText(text: "تم تحميل الصورة ");
                    break;

                  case TaskStatus.canceled:
                    log('Download was canceled');
                    break;

                  case TaskStatus.paused:
                    log('Download was paused');
                    break;

                  default:
                    log('Download not successful');
                }
              },
              trailingIcon: Iconsax.document_download,
              child: const Text("تحميل الصورة"),
            ),
          if (widget.msg?.video != null)
            CupertinoContextMenuAction(
              onPressed: () async {
                /// define the download task (subset of parameters shown)
                final task = DownloadTask(
                    url: widget.msg?.video ?? "",
                    requiresWiFi: false,
                    retries: 5,
                    allowPause: true,
                    metaData: 'sharek video');

// Start download, and wait for result. Show progress and status changes
// while downloading
                try {
                  final result = await FileDownloader().download(
                    task,
                  );
                  log(result.status.name);

// Act on the result
                  switch (result.status) {
                    case TaskStatus.complete:
                      BotToast.showText(text: "تم تحميل مقطع الفيديو");
                      break;

                    case TaskStatus.canceled:
                      log('Download was canceled');
                      break;

                    case TaskStatus.paused:
                      log('Download was paused');
                      break;

                    default:
                      log('Download not successful');
                  }
                } catch (e) {
                  log(e.toString());
                }
              },
              trailingIcon: Iconsax.document_download,
              child: const Text("تحميل الفيديو"),
            ),
          if (widget.isMe)
            CupertinoContextMenuAction(
              onPressed: () async {
                log(widget.msg?.msgId.toString() ??"");
                BotToast.showLoading();
                try {
                  await PrivateChatService(
                          myId: widget.myID, hisId: widget.hisId)
                      .deletePrivateMessage(widget.msg?.msgId ?? "");
                } catch (e) {
                  log(e.toString());

                  BotToast.closeAllLoading();
                  BotToast.showText(text: "فشل حذف الرسالة");
                  Get.back();
                  return;
                }
                Get.back();
                BotToast.closeAllLoading();
              },
              isDestructiveAction: true,
              trailingIcon: CupertinoIcons.delete,
              child: const Text("حذف الرسالة "),
            ),
        ],
        child: Material(
          color: Colors.transparent,
          child: Bubble(
            margin: const BubbleEdges.only(top: 10),
            alignment: Alignment.topRight,
            padding: const BubbleEdges.only(left: 15, right: 15),
            nip: BubbleNip.rightTop,
            elevation: 0,
            color: ColorsManager.offWhite,
            child: msgBuilder(
              context: context,
              msg: widget.msg as PrivateMessage,
              isMe: true,
            ),
          ),
        ),
      );
    } else {
      return Bubble(
        elevation: 0,
        margin: const BubbleEdges.only(top: 10),
        alignment: Alignment.topLeft,
        padding: const BubbleEdges.only(left: 15, right: 15),
        nip: BubbleNip.leftTop,
        color: ColorsManager.offWhite.withOpacity(.6),
        child: msgBuilder(
          context: context,
          msg: widget.msg as PrivateMessage,
          isMe: false,
        ),
      );
    }
  }

  Widget msgBuilder(
      {required PrivateMessage msg,
      bool? isMe,
      required BuildContext context}) {
    //notify user when he get a new message
    //if (!isMe) {}
    int hour = msg.time?.hour ?? 0;
    String amPm = '';
    if (msg.time?.hour == 0) {
      hour = 12;
      amPm = 'AM';
    } else if (msg.time?.hour == 12) {
      amPm = 'PM';
    } else if ((msg.time?.hour ?? 0) > 12) {
      hour = (msg.time?.hour ?? 0) - 12;
      amPm = 'PM';
    } else {
      amPm = 'AM';
    }
    if (msg.image == null && msg.text != null && msg.video == null) {
      log('${msg.text} ${msg.video} ${msg.image}');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (msg.text != null)
          LinkPreviewText(
            url: '${msg.text}',
          )
        else
          const SizedBox(),
        if (msg.image != null)
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 150.h(context), maxWidth: context.width / 1.3),
            child: InstaImageViewer(
              disposeLevel: DisposeLevel.high,
              child: AppCachedNetworkImage(
                imageUrl: msg.image ?? '',
              ),
            ),
          )
        else
          const SizedBox(),
        // if (msg.video != null)
        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: 150.h(context), maxWidth: context.width / 1.3),
          child: CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController),
        ),
        // else
        //   const SizedBox(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isMe == true
                ? const Icon(
                    Icons.done,
                    //    size: Dimensions.getDesirableWidth(4),
                    color: ColorsManager.grey,
                    size: Sizes.size18,
                  )
                : const SizedBox(),
            const SizedBox(
              width: 6,
            ),
            Text(
              '$hour:${msg.time?.minute} $amPm',
              style: const TextStyle(
                  //   fontSize: Dimensions.getDesirableWidth(3),
                  color: ColorsManager.veryDarkGrey,
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}

class LinkPreviewText extends StatefulWidget {
  LinkPreviewText({
    super.key,
    required this.url,
  });
  String url;
  Map<String, PreviewData> datas = {};
  @override
  State<LinkPreviewText> createState() => _LinkPreviewTextState();
}

class _LinkPreviewTextState extends State<LinkPreviewText> {
  @override
  Widget build(BuildContext context) {
    bool isLink = false;
    widget.url = widget.url;
    widget.url.split(' ').forEach((element) {
      element = element.toLowerCase();
      if (element.contains('http') ||
          element.contains('https') ||
          element.contains('www') ||
          element.contains('.com')) {
        isLink = true;
        widget.datas[element] = const PreviewData();
      }
    });
    if (isLink) {
      return LinkPreview(
        enableAnimation: true,
        onPreviewDataFetched: (data) {
          setState(() {
            widget.datas = {
              ...widget.datas,
              widget.url: data,
            };
          });
        },
        onLinkPressed: (url) {
          launchUrl(
            Uri.parse(url),
            mode: LaunchMode.externalApplication,
          );
        },
        previewData: widget.datas[widget.url],
        text: widget.url,
        textStyle: StylesManager.regular(
          color: Colors.white,
          fontSize: FontSize.medium,
        ),
        linkStyle: StylesManager.regular(
          color: Colors.blue,
          fontSize: FontSize.medium,
        ),
        openOnPreviewImageTap: true,
        openOnPreviewTitleTap: true,
        width: MediaQuery.of(context).size.width - 100,
      );
    } else {
      return RichText(
        text: TextSpan(
          text: widget.url,
          style: StylesManager.medium(
            color: Colors.black,
            fontSize: FontSize.medium,
          ),

          // style: Theme.of(context).textTheme.headline6,
        ),
      );
    }
  }
}
