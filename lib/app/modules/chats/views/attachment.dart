// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'dart:io';
import 'dart:math';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sharek/app/data/models/private_message_model.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/widgets/color_sonar_animation.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../../../core/services/chat/private/private_chat.dart';

double getFileSize({required int bytes, int decimals = 0}) {
  const suffixes = ["b", "kb", "mb", "gb", "tb"];
  var i = (log(bytes) / log(1024)).floor();
  return double.parse(
      ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i]);
}

class Attachment {
  final String myId, hisId, hisName, hisImage, myName, myImage;
  String percent = '0';
  final TextEditingController _controller = TextEditingController();

  Attachment({
    required this.myId,
    required this.hisId,
    required this.hisName,
    required this.hisImage,
    required this.myImage,
    required this.myName,
  });

  Widget messageComposer(BuildContext context) {
    String fluff = '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      //height: 100.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {
                fluff.isNotEmpty ? postMsg(fluff: fluff) : null;
              },
              maxLines: 6,
              minLines: 1,
              style: StylesManager.medium(
                  fontSize: FontSize.large, color: ColorsManager.black),
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                fluff = value;
              },
              decoration: InputDecoration(
                fillColor: ColorsManager.offWhite,
                filled: true,

                suffixIcon: IconButton(
                  icon: const Icon(Iconsax.attach_square),
                  iconSize: 25.0,
                  color: ColorsManager.primary,
                  onPressed: () {
                    attachmentDialog(context);
                  },
                ),
                // prefixIcon: IconButton(
                //   icon: const Icon(Iconsax.emoji_happy),
                //   iconSize: 25.0,
                //   color: ColorsManager.primary,
                //   onPressed: () {},
                // ),
                hintText: 'ارسال',
              ),
            ),
          ),
          Sizes.size10.w(context).widthSizedBox,
          Container(
            decoration: const BoxDecoration(
                color: ColorsManager.primary, shape: BoxShape.circle),
            child: IconButton(
              icon: const RotatedBox(
                  quarterTurns: 2, child: Icon(Iconsax.send_14)),
              iconSize: 25.0,
              color: ColorsManager.white,
              onPressed: () {
                fluff.isNotEmpty ? postMsg(fluff: fluff) : null;
              },
            ),
          ),
          // AudioRecorderWidget(
          //   onRecordComplete: (path) {
          //     uploadAudiotoStorage(context, path);
          //   },
          // )
        ],
      ),
    );
  }

  void attachmentDialog(BuildContext ctx) {
    Get.bottomSheet(
        enableDrag: true,
        Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              dialogBtn(
                  icon: Iconsax.image,
                  text: 'صورة',
                  onTap: () {
                    Get.back();
                    uploadImageToStorage(ctx);
                  }),
              dialogBtn(
                  icon: Iconsax.camera,
                  text: 'التقاط من الكاميرا',
                  onTap: () {
                    Get.back();
                    uploadFromCameraToStorage(ctx);
                  }),
              dialogBtn(
                  icon: Icons.play_circle_outline,
                  text: 'فيديو',
                  onTap: () {
                    Get.back();
                    uploadVideoToStorage(ctx);
                  }),
              dialogBtn(
                  icon: Iconsax.document,
                  text: 'ملف',
                  onTap: () {
                    Get.back();
                    uploadDocumentToStorage(ctx);
                  }),
              dialogBtn(
                  icon: Iconsax.location,
                  text: 'موقعك',
                  onTap: () {
                    Get.back();
                    sendMyLocationToStorage(ctx);
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  Future uploadVideoToStorage(BuildContext context) async {
    try {
      final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
      final DateTime now = DateTime.now();
      final int millSeconds = now.millisecondsSinceEpoch;
      final String month = now.month.toString();
      final String date = now.day.toString();
      final String storageId = ('${millSeconds.toString()}+id:$myId+');
      final String today = ('$month-$date');

      // /// create thumbnail from file///////////////////////
      final thumbnail = await VideoThumbnail.thumbnailData(
        video: file!.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth:
            128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 75,
      );

      final tempDir = await getTemporaryDirectory();
      final thumbnailFile = await File('${tempDir.path}/image.jpg').create();
      thumbnailFile.writeAsBytesSync(thumbnail!);

      // /// create thumbnail ref  //////////////////////////////////////////////////
      Reference thumbnailRef = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(today)
          .child(storageId);
      UploadTask thumbnailUploadTask =
          thumbnailRef.putFile(File(thumbnailFile.path));

      /// create video ref  //////////////////////////////////////////////////
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("video")
          .child(today)
          .child(storageId);
      UploadTask uploadTask = ref.putFile(
          File(file.path), SettableMetadata(contentType: 'video/mp4'));
      int size = File(file.path).lengthSync();
      downloadDialog(context, uploadTask, size);

      /// upload video  //////////////////////////////////////////////////
      var storageTaskSnapshot = await uploadTask;
      var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      final String url = downloadUrl.toString();

      /// upload thumbnail image  //////////////////////////////////////////////////
      var storageThumbnailTaskSnapshot = await thumbnailUploadTask;
      var downloadThumbnailUrl =
          await storageThumbnailTaskSnapshot.ref.getDownloadURL();
      final String urlThumbnail = downloadThumbnailUrl.toString();

      Navigator.pop(context);
      postMsg(video: url, image: urlThumbnail);
      print(url);
    } catch (error) {
      print(error);
    }
  }

  //upload file to FirebaseStorage
  Future uploadDocumentToStorage(BuildContext context) async {
    try {
      //request permission
      [Permission.storage, Permission.mediaLibrary].request();

      final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        dialogTitle: "Pick a file",
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx'],
      );
      final DateTime now = DateTime.now();
      final int millSeconds = now.millisecondsSinceEpoch;
      final String month = now.month.toString();
      final String date = now.day.toString();
      final String storageId = ('${millSeconds.toString()}+id:$myId+');
      final String today = ('$month-$date');
      print(storageId);

      Reference ref = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(today)
          .child(storageId);
      UploadTask uploadTask = ref.putFile(File(file?.files.first.path ?? ""));
      int size = File(file?.files.first.path ?? "").lengthSync();
      downloadDialog(context, uploadTask, size);

      var storageTaskSnapshot = await uploadTask;
      var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      final String url = downloadUrl.toString();
      Navigator.pop(context);
      postMsg(fluff: url);
      print(url);
    } catch (error) {
      print(error);
    }
  }

  Future uploadImageToStorage(BuildContext context) async {
    try {
      // set max high & width
      final file = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 100);
      //to create new folder for each day
      final DateTime now = DateTime.now();

      final int millSeconds = now.millisecondsSinceEpoch;
      final String month = now.month.toString();
      final String date = now.day.toString();
      final String storageId = ('${millSeconds.toString()}+id:$myId+');
      final String today = ('$month-$date');
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(today)
          .child(storageId);
      UploadTask uploadTask = ref.putFile(File(file!.path));
      int size = File(file.path).lengthSync();
      downloadDialog(context, uploadTask, size);
      /* uploadTask.events.listen((StorageTaskEvent snapshot) {
        double _progress = (snapshot.snapshot.bytesTransferred.round() * 100) /
            snapshot.snapshot.totalByteCount.round();

        this.percent = '${_progress.round()}';
        print('${_progress.round()}');
      });*/
      var storageTaskSnapshot = await uploadTask;

      var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      final String url = downloadUrl.toString();

      Navigator.pop(context);
      postMsg(image: url);
      print(url);
    } catch (error) {
      print(error);
    }
  }

  Future uploadFromCameraToStorage(BuildContext context) async {
    try {
      // set max high & width
      final file = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 100);
      //to create new folder for each day
      final DateTime now = DateTime.now();
      final int millSeconds = now.millisecondsSinceEpoch;
      final String month = now.month.toString();
      final String date = now.day.toString();
      final String storageId = ('${millSeconds.toString()}+id:$myId+');
      final String today = ('$month-$date');
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(today)
          .child(storageId);
      UploadTask uploadTask = ref.putFile(File(file!.path));
      int size = File(file.path).lengthSync();
      downloadDialog(context, uploadTask, size);
      /* uploadTask.events.listen((StorageTaskEvent snapshot) {
        double _progress = (snapshot.snapshot.bytesTransferred.round() * 100) /
            snapshot.snapshot.totalByteCount.round();
        this.percent = '${_progress.round()}';
        print('${_progress.round()}');
      });*/

      TaskSnapshot storageTaskSnapshot = await uploadTask;
      var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      final String url = downloadUrl.toString();
      Navigator.pop(context);
      postMsg(image: url);
      print(url);
    } catch (error) {
      print(error);
    }
  }

  Future sendMyLocationToStorage(BuildContext context) async {
    try {
      final permission = await Geolocator.checkPermission();
      switch (permission) {
        case LocationPermission.denied:
          await Geolocator.requestPermission();
          break;

        case LocationPermission.deniedForever:
          await Geolocator.requestPermission();
          break;
        case LocationPermission.unableToDetermine:
          await Geolocator.requestPermission();
          break;
        default:
          break;
      }
      //get current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      final String lat = position.latitude.toString();
      final String lng = position.longitude.toString();
      final String location = ('$lat,$lng');
      postMsg(
          fluff:
              'https://www.google.com/maps/search/?api=1&query=$location&zoom=18');
    } catch (e) {
      Get.log(e.toString());
      BotToast.showText(text: "تعذر مشاركة الموقع");
    }
  }

  //image + صورة
  Widget dialogBtn(
      {required IconData icon, required String text, required Function onTap}) {
    return SizedBox(
      height: 50,
      child: GestureDetector(
        onTap: () => onTap(),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: ColorsManager.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: ColorsManager.primary,
                size: 24,
              ),
            ),
          ),
          title: Text(
            text,
            style: StylesManager.medium(
              color: ColorsManager.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  uploadAudiotoStorage(BuildContext context, String path) async {
    try {
      final DateTime now = DateTime.now();
      final int millSeconds = now.millisecondsSinceEpoch;
      final String month = now.month.toString();
      final String date = now.day.toString();
      final String storageId = ('${millSeconds.toString()}+id:$myId+');
      final String today = ('$month-$date');
      print(storageId);

      Reference ref = FirebaseStorage.instance
          .ref()
          .child("audios")
          .child(today)
          .child(storageId);
      UploadTask uploadTask = ref.putFile(
        File(path),
      );
      int size = File(path).lengthSync();
      downloadDialog(context, uploadTask, size);

      var storageTaskSnapshot = await uploadTask;
      var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      final String url = downloadUrl.toString();

      postMsg(
        audio: url,
      );
      Navigator.pop(context);
      print(url);
    } catch (error) {
      print(error);
    }
  }

  void postMsg({
    String? fluff,
    String? image,
    String? video,
    String? audio,
  }) async {
    PrivateMessage newFluff = PrivateMessage(
        sender: myId,
        image: image,
        text: fluff,
        video: video,
        audio: audio,
        time: Timestamp.now().toDate());

    String userA, userB, aName, bName, aImage, bImage;
    if (int.parse(myId) > int.parse(hisId)) {
      userA = myId;
      userB = hisId;
      aName = myName;
      bName = hisName;
      aImage = myImage;
      bImage = hisImage;
    } else {
      userA = hisId;
      userB = myId;
      aName = hisName;
      bName = myName;
      aImage = hisImage;

      bImage = myImage;
    }

    await PrivateChatService(myId: myId, hisId: hisId).postPrivateMessage(
        privateMessage: newFluff,
        userA: userA,
        userB: userB,
        bName: bName,
        bImage: bImage,
        aName: aName,
        aImage: aImage);
    //String hisToken = await ApiProvider().getToken(hisId);
    //todo : send Notification

    _controller.clear();
  }

  downloadDialog(BuildContext context, UploadTask uploadTask, size) {
    // show the dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DownloadDialogContent(context, uploadTask, size);
      },
    );
  }
}

class DownloadDialogContent extends StatefulWidget {
  const DownloadDialogContent(this.context, this.uploadTask, this.size,
      {Key? key})
      : super(key: key);
  final BuildContext context;
  final UploadTask uploadTask;
  final int size;
  @override
  _DownloadDialogContentState createState() => _DownloadDialogContentState();
}

class _DownloadDialogContentState extends State<DownloadDialogContent> {
  double _prog = 0;
  @override
  void initState() {
    widget.uploadTask.snapshotEvents.listen((event) {
      setState(() {
        print('_prog : $_prog');
        _prog = event.bytesTransferred.toDouble();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("جاري الرفع"),
        content: SizedBox(
          height: 60,
          child: Column(
            children: [
              const Text("رجاء الانتظار ...."),
              const SizedBox(
                height: 20,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: LinearProgressIndicator(
                  color: ColorsManager.success,
                  value: _prog / widget.size,
                ),
              )
            ],
          ),
        ));
  }
}

class AudioRecorderWidget extends StatefulWidget {
  const AudioRecorderWidget({super.key, required this.onRecordComplete});

  final void Function(String path) onRecordComplete;

  @override
  State<AudioRecorderWidget> createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  late final RecorderController recorderController;
  bool isRecording = false;
  String audioPath = '';

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
  }

  @override
  void dispose() {
    recorderController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          recorderController.record();
          setState(() {
            isRecording = true;
          });
        },
        onLongPressUp: () async {
          audioPath = await recorderController.stop() ?? "";
          Get.log('audioPath : $audioPath');
          widget.onRecordComplete(audioPath);
          setState(() {
            isRecording = false;
          });
          //todo : send audio
        },
        child: !isRecording
            ? const Icon(
                Iconsax.microphone,
                color: ColorsManager.primary,
              )
            : const ColorSonar(
                waveMotion: WaveMotion.smooth,
                child: Icon(
                  Iconsax.microphone,
                  color: ColorsManager.primary,
                ),
              ));
  }
}
