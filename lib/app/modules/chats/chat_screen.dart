// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:sharek/app/data/models/private_message_model.dart';
import 'package:sharek/app/modules/chats/views/build_msg.dart';
import 'package:sharek/app/routes/app_pages.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';
import 'package:sharek/core/extensions/widget.dart';
import 'package:sharek/core/services/chat/private/private_chat.dart';
import 'package:sharek/core/widgets/network_image.dart';

import 'views/attachment.dart';

class ChatScreen extends StatelessWidget {
  String myId, hisId, hisName, hisImage, myName, myImage;

  ChatScreen(
      {super.key,
      this.myId = '',
      this.hisId = '',
      this.hisName = '',
      this.hisImage = '',
      this.myImage = '',
      this.myName = ''});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PrivateMessage>>.value(
      value: PrivateChatService(
        hisId: hisId,
        myId: myId,
      ).getLivePrivateMessage,
      initialData: const [],
      child: ChatScreenX(
        myId: myId,
        hisId: hisId,
        hisName: hisName,
        myImage: myImage,
        myName: myName,
        hisImage: hisImage,
      ),
    );
  }
}

class ChatScreenX extends StatelessWidget {
  String myId, hisId, hisName, hisImage, myName, myImage;

  ChatScreenX(
      {super.key,
      this.myId = '',
      this.hisId = '',
      this.hisName = '',
      this.hisImage = '',
      this.myImage = '',
      this.myName = ''});

  @override
  Widget build(BuildContext context) {
    final getFluffs = Provider.of<List<PrivateMessage>>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.0,
        title: GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.ANOTHER_USER_PROFILE,
              arguments: {
                "userId": int.parse(hisId),
              },
            );
          },
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: ColorsManager.primary, shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: AppCachedNetworkImage(
                      imageUrl: hisImage,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      customErrorWidget: const Icon(
                        Iconsax.user,
                        color: Colors.white,
                      )),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  hisName,
                  overflow: TextOverflow.fade,
                  style: StylesManager.semiBold(
                    color: Colors.black,
                    fontSize: FontSize.large,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  reverse: true,
                  itemCount: getFluffs.length,
                  //padding: const EdgeInsets.only(
                  //  bottom: Dimensions.getDesirableHeight(2.2),
                  //  right: Dimensions.getDesirableHeight(1.2),
                  // left: Dimensions.getDesirableHeight(1.2),
                  // top: Dimensions.getDesirableHeight(2.2)),
                  // ),
                  itemBuilder: (context, index) {
                    final PrivateMessage? old = index != getFluffs.length - 1
                        ? getFluffs[index + 1]
                        : null;
                    final PrivateMessage msg = getFluffs[index];
                    bool isMe = msg.sender == myId;
                    return Column(
                      children: [
                        if (((old != null) &&
                                (msg.time?.day != old.time?.day ||
                                    msg.time?.month != old.time?.month)) ||
                            (index == getFluffs.length - 1))
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Card(
                                color: ColorsManager.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Text(
                                    '${msg.time?.day}/${msg.time?.month}/${msg.time?.year}',
                                    style: const TextStyle(
                                        color: ColorsManager.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                )),
                          )
                        else
                          const SizedBox(),
                        MessageBuilder(
                          msg: msg,
                          isMe: isMe,
                          hisId: hisId,
                          myID: myId,
                        ).horizontalScreenPadding,
                      ],
                    );
                  },
                ),
              ),
              Attachment(
                myId: myId,
                hisId: hisId,
                hisName: hisName,
                hisImage: hisImage,
                myImage: myImage,
                myName: myName,
              ).messageComposer(context),
            ],
          ),
        ),
      ),
    );
  }
}
