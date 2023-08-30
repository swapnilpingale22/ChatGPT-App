import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:voice_assistant/constants/constants.dart';
import 'package:voice_assistant/services/asset_manager.dart';
import 'package:voice_assistant/widgets/text_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
  });

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBgColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0
                      ? AssetManager.userImage
                      : AssetManager.botImage,
                  color: chatIndex == 0 ? null : Colors.white,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: chatIndex == 0
                      ? TextWidget(
                          label: msg,
                        )
                      : DefaultTextStyle(
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                          ),
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(
                                speed: const Duration(milliseconds: 20),
                                msg.trim(),
                              ),
                            ],
                          ),
                        ),
                ),
                chatIndex == 0
                    ? Container()
                    : const Row(
                        children: [
                          Icon(
                            Icons.thumb_up_off_alt,
                            size: 16,
                            color: Colors.white60,
                          ),
                          SizedBox(width: 3),
                          Icon(
                            Icons.thumb_down_off_alt,
                            size: 16,
                            color: Colors.white60,
                          )
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
