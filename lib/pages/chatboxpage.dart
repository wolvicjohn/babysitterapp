import 'package:flutter/material.dart';
import '../controller/babysitter.dart';
import '../controller/currentuser.dart';
import '../controller/messagedata.dart';
import '../controller/userdata.dart';
import '../view/chatbox.dart';

class ChatBoxPage extends StatefulWidget {
  final String babysitterId_;
  const ChatBoxPage({
    super.key,
    required this.babysitterId_,
  });

  @override
  State<ChatBoxPage> createState() => _ChatBoxPageState();
}

class _ChatBoxPageState extends State<ChatBoxPage> {
  UserData userData_ = UserData();
  MessageData messageData_ = MessageData();
  late Babysitter babysitter;
  late CurrentUser currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = userData_.currentUser;
    babysitter = userData_.babysitterList.firstWhere(
      (babysitter) => babysitter.id == widget.babysitterId_,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(babysitter.name),
      ),
      body: ChatBox(
          userData: userData_,
          messageData: messageData_,
          babysitterId: widget.babysitterId_,
          babysitter: babysitter,
          currentUser: currentUser),
    );
  }
}
