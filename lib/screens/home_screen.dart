import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:voice_assistant/constants/constants.dart';
import '../providers/chat_provider.dart';
import '../providers/models_provider.dart';
import '../services/asset_manager.dart';
import '../services/services.dart';
import '../widgets/chat_widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController _listScreollController;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    _listScreollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    _listScreollController.dispose();
  }

  //for regular method keep this list below
  // List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
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
            fontWeight: FontWeight.bold,
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
              controller: _listScreollController,
              itemCount: chatProvider.getChatList.length, //chatList.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  chatIndex: chatProvider.getChatList[index]
                      .chatIndex, //chatList[index].chatIndex,
                  msg: chatProvider
                      .getChatList[index].msg, //chatList[index].msg,
                );
              },
            ),
          ),
          if (_isTyping) ...[
            SpinKitThreeBounce(
              color: textColor,
              size: 18,
            ),
          ],
          const SizedBox(height: 10),
          Material(
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      style: TextStyle(
                        color: textColor,
                      ),
                      controller: textEditingController,
                      onSubmitted: (value) async {
                        await sendMessageFCT(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider,
                        );
                      },
                      decoration: const InputDecoration(
                        hintText: ' How can I assist you?',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await sendMessageFCT(
                        modelsProvider: modelsProvider,
                        chatProvider: chatProvider,
                      );
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
        ],
      ),
    );
  }

  void scrollListToEnd() {
    _listScreollController.animateTo(
      _listScreollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.linear,
    );
  }

  Future<void> sendMessageFCT({modelsProvider, chatProvider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "You can't send multiple messages at a time.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
      return;
    }
    if (textEditingController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Please provide any text!",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
      return;
    }

    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;

        //regular method

        // chatList.add(
        //   ChatModel(
        //     msg: textEditingController.text,
        //     chatIndex: 0,
        //   ),
        // );

        // //Provider method

        chatProvider.addUserMessage(
          msg: msg,
        );
        textEditingController.clear();
        focusNode.unfocus();
      });

      //Provider method

      await chatProvider.sendMessageAndGetAnswers(
        msg: msg,
        choosenModel: modelsProvider.getCurrentModel,
      );

      //regular method

      // chatList.addAll(
      //   await ApiServices.sendMessage(
      //     textEditingController.text,
      //     modelsProvider.getCurrentModel,
      //   ),
      // );

      setState(() {});
    } catch (error) {
      print("error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }
}
