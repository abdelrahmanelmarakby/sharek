// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/theme/theme_export.dart';

class ImagePickerDialog {
  Widget _roundedButton(
      {required String label, Color? bgColor, Color? txtColor}) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        padding: const EdgeInsets.all(15.0),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Color(0xFF696969),
                  offset: Offset(1.0, 6.0),
                  blurRadius: 0.001)
            ]),
        child: Text(label,
            style: TextStyle(
                fontFamily: "cairo",
                color: txtColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)));
  }

  _openCamera(ValueChanged<Media?> onGet, BuildContext context) async {
    await [Permission.photos, Permission.storage].request();

    try {
      var image = await ImagePickers.openCamera();
      onGet(image);
    } catch (e) {
      if (e.toString() != 'The user has cancelled the selection') {
        if (Platform.isIOS) {
          BuildContext context = Get.context!;
          showDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text("S().photo_permission"),
                    content: const Text("S().photo_permission_des"),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text("Deny"),
                        onPressed: () {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text("Open app settings"),
                        onPressed: () => openAppSettings(),
                      ),
                    ],
                  ));
        } else {
          [Permission.photos, Permission.storage].request();
        }
      }
    }
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }
// getVideoFromCamera(ValueChanged<File> onGet, BuildContext context) async{
//   var video = await ImagePicker().getVideo(source: ImageSource.camera);
//   onGet(File(video.path));
//   if(Navigator.of(context).canPop()) Navigator.of(context).pop()
//
// }
// getVideoFromGallery(ValueChanged<File> onGet, BuildContext context) async{
//   var video = await ImagePicker().getVideo(source: ImageSource.gallery);
//   onGet(File(video.path));
//   if(Navigator.of(context).canPop()) Navigator.of(context).pop()
//
// }

  cropImage(File image, ValueChanged<File?> onGet, BuildContext context) async {
    // ImageCropper cropper = ImageCropper();
    // CroppedFile? _croppedFile = await cropper.cropImage(
    //     sourcePath: image.path,
    //     maxWidth: 512,
    //     maxHeight: 512,
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //       CropAspectRatioPreset.ratio3x2,
    //       CropAspectRatioPreset.original,
    //       CropAspectRatioPreset.ratio4x3,
    //       CropAspectRatioPreset.ratio16x9
    //     ],
    //     uiSettings: [
    //       AndroidUiSettings(
    //           toolbarTitle: allTranslations.text('edit_image'),
    //           toolbarColor: MyColors.accentColor,
    //           toolbarWidgetColor: Colors.white,
    //           initAspectRatio: CropAspectRatioPreset.original,
    //           lockAspectRatio: false),
    //       IOSUiSettings(
    //           title: allTranslations.text('edit_image'),
    //           aspectRatioLockDimensionSwapEnabled: true,
    //           aspectRatioLockEnabled: true)
    //     ]);
    // // File _compressed = await _compress(_croppedFile);
    // onGet(File(_croppedFile!.path));
  }

  // Future<File> _compress(File file) async {
  //   final _dir = await path_provider.getTemporaryDirectory();
  //   final _targetPath = _dir.absolute.path +
  //       "/temp${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //       file.absolute.path, _targetPath,
  //       quality: 70);
  //
  //   return result;
  // }
  show({ValueChanged<Media?>? onGet, required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return Material(
              type: MaterialType.transparency,
              child: Opacity(
                  opacity: 1.0,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                                onTap: () => _openCamera(onGet!, context),
                                child: _roundedButton(
                                    label: " S().camera",
                                    bgColor: ColorsManager.accent,
                                    txtColor: Colors.white)),
                            GestureDetector(
                              //onTap: () => openGallery(onGet!, context),
                              onTap: () => pickGalleryImages(maxImage: 1),

                              child: _roundedButton(
                                  label: " S().gallery",
                                  bgColor: const Color(0xFFFFFFFF),
                                  txtColor:
                                      const Color.fromRGBO(31, 32, 34, 1.0)),
                            ),
                            const SizedBox(height: 15.0),
                            GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        30.0, 0.0, 30.0, 0.0),
                                    child: _roundedButton(
                                        label: "S().cancel",
                                        bgColor: Colors.black,
                                        txtColor: Colors.white)))
                          ]))));
        });
  }

  Future<void> pickGalleryImages(
      {ValueChanged<List<Media>>? onGet,
      BuildContext? context,
      required int maxImage}) async {
    List<Media> listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: maxImage,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: ColorsManager.accent),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    onGet!(listImagePaths);
  }
}
