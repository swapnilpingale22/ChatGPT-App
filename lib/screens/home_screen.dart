import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:voice_assistant/constants/constants.dart';
import 'package:voice_assistant/services/api_services.dart';
import '../models/chat_model.dart';
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

  List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(
      context,
    );
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
              controller: _listScreollController,
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  chatIndex: chatList[index].chatIndex,
                  msg: chatList[index].msg,
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
                        await sendMessageFCT(modelsProvider: modelsProvider);
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
                      await sendMessageFCT(modelsProvider: modelsProvider);
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

  Future<void> sendMessageFCT({modelsProvider}) async {
    try {
      setState(() {
        _isTyping = true;
        chatList.add(
          ChatModel(
            msg: textEditingController.text,
            chatIndex: 0,
          ),
        );
        textEditingController.clear();
        focusNode.unfocus();
      });
      chatList.addAll(
        await ApiServices.sendMessage(
          textEditingController.text,
          modelsProvider.getCurrentModel,
        ),
      );
      setState(() {});
    } catch (e) {
      print("error: $e");
    } finally {
      setState(() {
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }
}
