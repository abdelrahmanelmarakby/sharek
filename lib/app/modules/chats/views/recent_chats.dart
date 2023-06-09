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
import 'package:timeago/timeago.dart' as timeago;
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
      height: context.height / 9,
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
          margin: const EdgeInsets.only(top: 2, bottom: 4, right: 8, left: 8),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          decoration: BoxDecoration(
              color: chatRoom.lastSender != widget.myId
                  ? const Color.fromARGB(255, 219, 225, 252)
                  : const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(Sizes.size12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 85,
                child: Row(
                  children: [
                    GestureDetector(
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
                      child: Expanded(
                        flex: 35,
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
                          SizedBox(
                            //    width: Dimensions.getDesirableWidth(45.0),
                            child: Text(
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
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.done_all,
                                size: Sizes.size18,
                                color: ColorsManager.veryDarkGrey,
                              ),
                              Sizes.size10.w(context).widthSizedBox,
                              Expanded(
                                child: Text(
                                  '${chatRoom.lastMsg}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: FontSize.large,
                                    color: ColorsManager.veryDarkGrey,

                                    //           fontSize: Dimensions.getDesirableWidth(4),
                                    //          color: MyColors().textColor,
                                    fontWeight: FontWeight.w500,
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
                    const Spacer(),
                    Text(
                      timeago.format(
                          DateTime.now().subtract(DateTime.now()
                              .difference(chatRoom.lastChat!.toUtc())),
                          locale: 'ar'),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: FontSize.small,
                        color: ColorsManager.darkGrey,
                        //      fontSize: Dimensions.getDesirableWidth(4),
                        //    color: MyColors().textColor,
                        fontWeight: FontWeight.bold,
                      ),
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
