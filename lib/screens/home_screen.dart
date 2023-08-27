import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voice_assistant/constants/constants.dart';
import '../services/api_services.dart';
import '../services/asset_manager.dart';
import '../services/services.dart';
import '../widgets/chat_widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final bool _isTyping = true;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetManager.openAiLogo),
        ),
        title: Text(
          'ChatGPT',
          style: TextStyle(
            color: textColor,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context);
            },
            icon: Icon(
              Icons.more_vert,
              color: textColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  chatIndex:
                      int.parse(chatMessages[index]['chatIndex'].toString()),
                  msg: chatMessages[index]['message'].toString(),
                );
              },
            ),
          ),
          if (_isTyping) ...[
            SpinKitThreeBounce(
              color: textColor,
              size: 18,
            ),
            const SizedBox(height: 10),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: textColor,
                        ),
                        controller: textEditingController,
                        onSubmitted: (value) {
                          //function send msg
                        },
                        decoration: const InputDecoration(
                          hintText: 'Message',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await ApiServices.getModels();
                        } catch (e) {
                          print('error: $e');
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
