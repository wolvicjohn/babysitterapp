import '/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '/controller/babysitter.dart';
import '/controller/currentuser.dart';
import '/controller/messagedata.dart';
import '/controller/messages.dart';
import '/controller/userdata.dart';

class ChatBox extends StatefulWidget {
  final UserData userData;
  final MessageData messageData;
  final String babysitterId;
  final Babysitter babysitter;
  final CurrentUser currentUser;

  const ChatBox({
    super.key,
    required this.userData,
    required this.messageData,
    required this.babysitterId,
    required this.babysitter,
    required this.currentUser,
  });

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  //messages of the current user
  Widget userMessage(
          Messages messages, Babysitter babysitter, CurrentUser currentUser) =>
      InkWell(
        onTap: () {
          setState(() {
            messages.isClicked = (messages.isClicked) ? false : true;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            chatName(babysitter, messages, currentUser),
            Container(
                constraints: const BoxConstraints(maxWidth: 250),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                //check if the message is image or text
                child: (messages.msg.contains('jpg'))
                    ? Image.asset(messages.msg)
                    : Text(
                        messages.msg,
                        style: const TextStyle(color: primaryFgColor),
                      )),
          ],
        ),
      );

  //messages of the babysitter
  Widget babySitterMessage(
          Messages messages, Babysitter babysitter, CurrentUser currentUser) =>
      InkWell(
        onTap: () {
          setState(() {
            messages.isClicked = (messages.isClicked) ? false : true;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chatName(babysitter, messages, currentUser),
            Container(
                constraints: const BoxConstraints(maxWidth: 250),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 201, 201, 201),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: (messages.msg.contains('jpg'))
                    ? Image.asset(messages.msg)
                    : Text(messages.msg)),
          ],
        ),
      );

  //chat name above the chat message
  Widget chatName(
      Babysitter babysitter, Messages messages, CurrentUser currentUser) {
    bool isUser = babysitter.id == messages.id;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        (isUser) ? babysitter.name : currentUser.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //message line including profile picture
  Widget messageContent(
      Messages messages, Babysitter babysitter, CurrentUser currentUser) {
    bool isUser = messages.id == currentUser.id;
    //check if the message line was from babysitter or current user
    return (isUser)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              userMessage(messages, babysitter, currentUser),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(currentUser.img),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(babysitter.img),
              ),
              const SizedBox(width: 10),
              babySitterMessage(messages, babysitter, currentUser),
            ],
          );
  }

  //display the time message sent
  Widget showTime(Messages messages) => (messages.isClicked)
      ? Column(
          children: [
            Text(messages.time),
            const SizedBox(height: 10),
          ],
        )
      : Container();

  //box format for message
  Widget messageBox(
          Messages messages, Babysitter babysitter, CurrentUser accounts) =>
      Column(
        children: [
          showTime(messages),
          messageContent(messages, babysitter, accounts),
          const SizedBox(height: 20),
        ],
      );

  //temporary chat messages
  Widget printMessage() {
    if (widget.babysitterId == 'sample') {
      return ListView(
        controller: scrollController,
        children: widget.messageData.sample.map((messages) {
          return messageBox(messages, widget.babysitter, widget.currentUser);
        }).toList(),
      );
    } else if (widget.babysitterId == 'helloworld') {
      return ListView(
        controller: scrollController,
        children: widget.messageData.helloworld.map((messages) {
          return messageBox(messages, widget.babysitter, widget.currentUser);
        }).toList(),
      );
    } else if (widget.babysitterId == 'hiearth') {
      return ListView(
        controller: scrollController,
        children: widget.messageData.hiearth.map((messages) {
          return messageBox(messages, widget.babysitter, widget.currentUser);
        }).toList(),
      );
    } else {
      return const Center(child: Text('No chat selected.'));
    }
  }

  //store current user new message
  addMessage(CurrentUser currentUser) {
    Messages newMessage = Messages(
      id: currentUser.id,
      msg: messageController.text,
      time: '10:59 pm',
      isClicked: false,
    );
    setState(() {
      if (widget.babysitterId == 'sample') {
        return widget.messageData.sample.add(newMessage);
      } else if (widget.babysitterId == 'helloworld') {
        return widget.messageData.helloworld.add(newMessage);
      } else if (widget.babysitterId == 'hiearth') {
        return widget.messageData.hiearth.add(newMessage);
      } else {
        return;
      }
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  //scroll to most recent message
  scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: printMessage(),
        ),
        //chat text field
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Message',
                    suffixIcon: IconButton(
                      onPressed: () {
                        addMessage(widget.currentUser);
                        messageController.clear();
                      },
                      icon: const Icon(CupertinoIcons.paperplane_fill),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
