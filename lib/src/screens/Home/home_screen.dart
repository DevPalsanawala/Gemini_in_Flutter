import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/constants/color.dart';
import 'package:myapp/src/screens/profile/profile_screen.dart';
import 'package:myapp/src/services/auth_service/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatMessage> messages = [];
  final Gemini gemini = Gemini.instance;

  ChatUser currentUser = ChatUser(
      id: "0", firstName: "user", profileImage: "assets/images/profile.png");
  ChatUser geminiuser = ChatUser(
      id: "1", firstName: "Gemini", profileImage: "assets/images/gemini.png");
  @override
  Widget build(BuildContext context) {
    final authcontroller = Get.put(Authentication());
    var mediaquery = MediaQuery.of(context);
    final size = mediaquery.size;
    final brightness = mediaquery.platformBrightness;
    final isDarkmode = brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Gemini Chat"),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(const ProfileScreen());
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: dSecondaryColor.withOpacity(0.2),
                ),
                child: const Image(
                  image: AssetImage("assets/images/profile.png"),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.875,
            width: size.width,
            child: DashChat(
              messageOptions: MessageOptions(
                currentUserContainerColor:
                    isDarkmode ? dPrimaryColor : dPrimaryColor.withOpacity(0.7),
                currentUserTextColor: isDarkmode ? Colors.white : Colors.black,
                containerColor: isDarkmode
                    ? Colors.blueGrey
                    : dSecondaryColor.withOpacity(0.2),
                textColor: isDarkmode ? Colors.white : Colors.black,
              ),
              inputOptions: InputOptions(
                trailing: [
                  IconButton(
                    onPressed: sendMedia,
                    icon: const Icon(
                      Icons.image,
                      color: dPrimaryColor,
                      size: 30,
                    ),
                  ),
                ],
                inputMaxLines: 15,
                inputDecoration: const InputDecoration(
                  hintText: "Message Gemini",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
                sendButtonBuilder: (onPressed) {
                  return IconButton(
                    icon: const Icon(Icons.send), // Use your preferred icon
                    color: dPrimaryColor, // Set the color of the send button
                    onPressed: onPressed,
                  );
                },
              ),
              currentUser: currentUser,
              onSend: sendMessage,
              messages: messages,
            ),
          ),
        ),
      ),
    );
  }

  void sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;

      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }
      gemini.streamGenerateContent(question, images: images).listen((event) {
        ChatMessage? Lastmsg = messages.firstOrNull;
        if (Lastmsg != null && Lastmsg.user == geminiuser) {
          Lastmsg = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          Lastmsg.text += response;
          setState(() {
            messages = [Lastmsg!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiuser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void sendMedia() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Describe this image?",
          medias: [
            ChatMedia(
              url: file.path,
              fileName: "",
              type: MediaType.image,
            ),
          ]);
      sendMessage(chatMessage);
    }
  }
}
