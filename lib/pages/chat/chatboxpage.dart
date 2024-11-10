import 'package:babysitterapp/controller/messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter/material.dart';

import '../../controller/babysitter.dart';
import '../../controller/currentuser.dart';
import '../../controller/messagedata.dart';
import '../../controller/userdata.dart';
import '../../views/customwidget.dart';

class ChatBoxPage extends StatefulWidget {
  final String babysitterId_;
  const ChatBoxPage({super.key, required this.babysitterId_});

  @override
  State<ChatBoxPage> createState() => _ChatBoxPageState();
}

class _ChatBoxPageState extends State<ChatBoxPage> {
  final UserData userData = UserData();
  final MessageData messageData = MessageData();
  final CustomWidget customWidget = CustomWidget();
  //fetch babysitter data based on babysitterId_
  late Babysitter babysitter = userData.babysitterList.firstWhere(
    (babysitter) => babysitter.id == widget.babysitterId_,
  );
  //fetch current user data
  late CurrentUser currentUser = userData.currentUser;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late String selectedOffer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
    selectedOffer = userData.offerList.first;
  }

  //fetch messages
  Widget fetchMessage() {
    return ListView(
      controller: scrollController,
      children: customWidget
          .messageList(widget.babysitterId_, messageData)
          .map((messages) {
        bool isUser = currentUser.id == messages.id;

        onTap() {
          setState(() {
            //check if the message is clicked
            messages.isClicked = !messages.isClicked;
          });
        }

        return Column(
          children: [
            customWidget.messageLine(
                isUser, messages, currentUser, babysitter, onTap),
          ],
        );
      }).toList(),
    );
  }

  //store current user new message
  addMessage(String message) {
    Messages newMessage = Messages(
      id: currentUser.id,
      msg: message,
      time: '10:59 pm',
      isClicked: false,
    );
    setState(() {
      customWidget
          .messageList(widget.babysitterId_, messageData)
          .add(newMessage);
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
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(babysitter.name),
        leading: IconButton(
          onPressed: () {
            setState(() {
              babysitter.isClicked = false;
              Navigator.pop(context);
            });
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(child: fetchMessage()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              //message field
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Message',
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            //send offer function
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return OfferModal(
                                      iconOnPressed: () {
                                        setState(() {
                                          selectedOffer =
                                              userData.offerList.first;
                                        });
                                        Navigator.pop(context);
                                      },
                                      children: userData.offerList.map((offer) {
                                        return RadioListTile<String>(
                                          title: Text('PHP $offer/hr'),
                                          value: offer,
                                          groupValue: selectedOffer,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedOffer = value!;
                                            });
                                          },
                                        );
                                      }).toList(),
                                      buttonOnPressed: () {
                                        addMessage(
                                            'Offer: PHP $selectedOffer/hr');
                                        setState(() {
                                          selectedOffer =
                                              userData.offerList.first;
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.local_offer),
                        ),
                        IconButton(
                          onPressed: () {
                            //add message function
                            if (messageController.text.isNotEmpty) {
                              addMessage(messageController.text);
                            }
                            messageController.clear();
                          },
                          icon: const Icon(CupertinoIcons.paperplane_fill),
                        ),
                      ],
                    ),
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
