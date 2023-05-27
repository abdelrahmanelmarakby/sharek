import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:provider/provider.dart';
import 'package:sharek/app/data/models/chat_model.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';
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
        centerTitle: true,
        title: const Text(
          'الرسائل',
          style: TextStyle(
            fontSize: FontSize.xlarge,
            color: ColorsManager.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: getRecentChat.isNotEmpty ? getRecentChat.length : 0,
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) {
          final ChatRoom chatRoom = getRecentChat[index];

          return rowChat(context, chatRoom);
        },
      ),
    );
  }

  /*getUser() async {
    user = await User(serverResponse: []).getUser();
  }*/

  Widget rowChat(BuildContext context, ChatRoom chatRoom) {
    return OpenContainer(
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(5, 5),
                )
              ],
              color: chatRoom.lastSender != widget.myId
                  ? const Color.fromARGB(255, 219, 225, 252)
                  : const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(Sizes.size12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
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
                            )),
                  ),
                  Sizes.size12.h(context).heightSizedBox,
                  Column(
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
                            color: ColorsManager.primary,
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: context.width * (.1),
                      ),
                      SizedBox(
                          width: context.width * .35,
                          child: Text('${chatRoom.lastMsg}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: FontSize.medium,
                                  color: ColorsManager.darkGrey,
                                  //           fontSize: Dimensions.getDesirableWidth(4),
                                  //          color: MyColors().textColor,
                                  fontWeight: FontWeight.w500))),
                    ],
                  )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: context.width * .1,
                      height: context.height * .02,
                      //  height: Dimensions.getDesirableHeight(4.0),
                      //  width: Dimensions.getDesirableWidth(12.0),
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
                    SizedBox(
                      height: context.height * .05,
                    ),
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
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          )),
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
