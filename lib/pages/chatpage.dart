import 'package:flutter/material.dart';
import '/controller/babysitter.dart';
import '/controller/messagedata.dart';
import '/controller/userdata.dart';
import 'chatboxpage.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  UserData userData = UserData();
  MessageData messageData = MessageData();
  String babysitterId = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //check if the current user has previous conversation of the babysitter
  bool userHasMessages(String userID) {
    return messageData.sample.any((message) => message.id == userID) ||
        messageData.helloworld.any((message) => message.id == userID) ||
        messageData.hiearth.any((message) => message.id == userID);
  }

  //list of babysitter in the chat page
  Widget babysitterList(Babysitter babysitter) => InkWell(
        onTap: () {
          //check which babysitter is clicked by the current user
          setState(() {
            babysitter.isClicked = !babysitter.isClicked;

            (babysitter.isClicked)
                ? setState(() {
                    babysitterId = babysitter.id;
                  })
                : null;
            babysitter.isClicked = false;
          });

          //navigate to the chatbox of the clicked babysitter
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatBoxPage(babysitterId_: babysitterId),
          ));
        },
        onLongPress: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 60,
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(babysitter.img),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      babysitter.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(babysitter.email),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: ListView(
        children: userData.babysitterList
            .where((babysitter) => userHasMessages(babysitter.id))
            .map((babysitter) {
          return babysitterList(babysitter);
        }).toList(),
      ),
    );
  }
}
