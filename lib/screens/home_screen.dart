import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
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
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    _listScrollController.dispose();
  }

  // final apiResponse =  ApiServices.sendMessageBard(question);
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
          child: Row(
            children: [
              Lottie.asset(
                'assets/images/google_circle_anim.json',
                height: 40,
                width: 40,
              ),
            ],
          ),
        ),
        title: Text(
          'Google Bard AI',
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
              controller: _listScrollController,
              itemCount: chatProvider.getChatList.length, //chatList.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  author: chatProvider
                      .getChatList[index].author, //chatList[index].author,
                  content: chatProvider
                      .getChatList[index].content, //chatList[index].content,
                  scrollFunction: scrollListToEnd,
                );
              },
              addAutomaticKeepAlives: true,
            ),
          ),
          if (_isTyping) ...[
            SpinKitThreeBounce(
              color: textColor,
              size: 18,
            ),
            const SizedBox(height: 10),
          ],
          Material(
            color: scaffoldBgColor,
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: cardColor,
                        focusColor: textColor,
                        hintText: _isTyping
                            ? 'Please wait a moment'
                            : ' How can I assist you?',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            50.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            50.0,
                          ),
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: _isTyping
                              ? SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    color: textColor,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  Icons.mic,
                                  color: textColor,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: textColor),
                      shape: BoxShape.circle,
                      color: cardColor,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await sendMessageFCT(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider,
                        );
                      },
                      icon: _isTyping
                          ? Image.asset(
                              AssetManager.bardLogo,
                              fit: BoxFit.contain,
                              height: 30,
                              width: 30,
                            )
                          : Icon(Icons.arrow_upward_rounded, color: textColor),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void scrollListToEnd() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 4),
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
          backgroundColor: Colors.red,
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

        // Scroll to the end of the list
        scrollListToEnd();
      });

      //Provider method

      await chatProvider.sendMessageAndGetAnswers(
        msg: msg,
      );

      // Scroll to the end of the list after receiving an answer
      scrollListToEnd();
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
