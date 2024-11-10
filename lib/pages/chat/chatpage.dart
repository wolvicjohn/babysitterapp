import 'package:babysitterapp/styles/colors.dart';
import 'package:flutter/cupertino.dart';
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
  late bool isLongPressed;
  List<String> selectedBabysitterId = [];

  @override
  void initState() {
    isLongPressed = false;
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
          if (isLongPressed) {
            setState(() {
              //Add or remove babysitter id to the selected list
              if (selectedBabysitterId.contains(babysitter.id)) {
                selectedBabysitterId.remove(babysitter.id);
              } else {
                selectedBabysitterId.add(babysitter.id);
              }
            });
          } else {
            // Check which babysitter is clicked by the current user
            setState(() {
              babysitter.isClicked = true;

              if (babysitter.isClicked!) {
                babysitterId = babysitter.id;
              }
            });

            // Navigate to the chat box of the clicked babysitter
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatBoxPage(babysitterId_: babysitterId),
            ));
          }
        },
        onLongPress: () {
          setState(() {
            //Add babysitter id to the selected list
            selectedBabysitterId.add(babysitter.id);
            isLongPressed = true;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 60,
          child: Row(
            children: [
              //if longpressed is true diplay the checkbox
              if (isLongPressed)
                Checkbox(
                  value: selectedBabysitterId.contains(babysitter.id),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        //Add babysitter id to the selected list
                        selectedBabysitterId.add(babysitter.id);
                      } else {
                        //Remove babysitter id to the selected list
                        selectedBabysitterId.remove(babysitter.id);
                      }
                    });
                  },
                ),
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
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Change Appbar content based on isLongPressed value
      appBar: (isLongPressed)
          ? AppBar(
              title: Text('${selectedBabysitterId.length} Selected'),
              //cancel button
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    isLongPressed = false;
                    selectedBabysitterId = [];
                  });
                },
                icon: const Icon(CupertinoIcons.clear),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      //delete function
                      print(selectedBabysitterId);
                      isLongPressed = false;
                      selectedBabysitterId = [];
                    });
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            )
          : AppBar(
              title: const Text('Messages'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLongPressed = true;
                    });
                  },
                  child: const Text(
                    'Select',
                    style: TextStyle(color: primaryFgColor),
                  ),
                ),
              ],
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
