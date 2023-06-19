// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/routes/app_pages.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:provider/provider.dart';
import 'package:sharek/app/data/models/chat_model.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';
import 'package:sharek/core/extensions/widget.dart';
import '../chat_screen.dart';

class RecentChats extends StatefulWidget {
  String myId;

  RecentChats({super.key, this.myId = ""});

  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  // UserModel? user;

  @override
  Widget build(BuildContext context) {
    final getRecentChat = Provider.of<List<ChatRoom>>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          'الرسائل',
          style: TextStyle(
            fontSize: FontSize.xlarge,
            color: ColorsManager.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: getRecentChat.isNotEmpty ? getRecentChat.length : 0,
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) {
          final ChatRoom chatRoom = getRecentChat[index];

          return Column(
            children: [
              rowChat(context, chatRoom),
              const Divider(
                height: .5,
                thickness: .5,
                color: ColorsManager.lightGrey,
              ),
            ],
          ).horizontalScreenPadding;
        },
      ),
    );
  }

  /*getUser() async {
    user = await User(serverResponse: []).getUser();
  }*/

  Widget rowChat(BuildContext context, ChatRoom chatRoom) {
    return SizedBox(
      height: context.height / 12,
      child: OpenContainer(
        closedElevation: 0,
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (context, action) => ChatScreen(
          hisId: chatRoom.userA.toString() == widget.myId.toString()
              ? chatRoom.userB.toString()
              : chatRoom.userA.toString(),
          myId: widget.myId,
          myName: chatRoom.userA.toString() != widget.myId.toString()
              ? chatRoom.bName.toString()
              : chatRoom.aName.toString(),
          myImage: chatRoom.userA.toString() != widget.myId.toString()
              ? chatRoom.bImage.toString()
              : chatRoom.aImage.toString(),
          hisName: chatRoom.userA.toString() == widget.myId.toString()
              ? chatRoom.bName.toString()
              : chatRoom.aName.toString(),
          hisImage: chatRoom.userA.toString() == widget.myId.toString()
              ? chatRoom.bImage.toString()
              : chatRoom.aImage.toString(),
        ),
        closedBuilder: (context, action) => Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: chatRoom.lastSender != widget.myId
                ? const Color.fromARGB(255, 219, 225, 252)
                : const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 85,
                child: Row(
                  children: [
                    Expanded(
                      flex: 35,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.ANOTHER_USER_PROFILE,
                            arguments: {
                              "userId": int.parse(chatRoom.userA ?? "") ==
                                      int.parse(widget.myId)
                                  ? int.parse(chatRoom.userB ?? "")
                                  : int.parse(chatRoom.userA ?? ""),
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorsManager.primary,
                                )),
                            child: CachedNetworkImage(
                              imageUrl: chatRoom.userA == widget.myId
                                  ? chatRoom.bImage.toString()
                                  : chatRoom.aImage.toString(),
                              fit: BoxFit.cover,
                              height: 48.h(context),
                              width: 48.h(context),
                              placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(
                                      color: ColorsManager.primary),
                              errorWidget: (context, url, error) =>
                                  const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: ColorsManager.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Sizes.size12.w(context).widthSizedBox,
                    Expanded(
                      flex: 65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chatRoom.userA == widget.myId.toString()
                                ? chatRoom.bName.toString()
                                : chatRoom.aName.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: FontSize.xlarge,
                              color: ColorsManager.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  '${chatRoom.lastMsg}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: FontSize.large,
                                    fontWeight: FontWeight.w600,
                                    color: ColorsManager.veryDarkGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${DateTime.now().subtract(DateTime.now().difference(chatRoom.lastChat!.toUtc())).hour}:${DateTime.now().subtract(DateTime.now().difference(chatRoom.lastChat!.toUtc())).minute}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: FontSize.medium,
                        color: ColorsManager.darkGrey,
                        //      fontSize: Dimensions.getDesirableWidth(4),
                        //    color: MyColors().textColor,
                        fontWeight: chatRoom.lastSender != widget.myId
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: chatRoom.lastSender != widget.myId
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: const Text('رسالة جديدة!',
                                  style: TextStyle(
                                      // fontSize: Dimensions.getDesirableWidth(4),
                                      color: ColorsManager.selection,
                                      fontWeight: FontWeight.bold)))
                          : const Text(''),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    required this.text,
    required this.icon,
    this.onTap,
    Key? key,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              color: ColorsManager.primary,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: StylesManager.light(
                  color: ColorsManager.primary, fontSize: FontSize.medium),
            ),
          ],
        ),
      ),
    );
  }
}
