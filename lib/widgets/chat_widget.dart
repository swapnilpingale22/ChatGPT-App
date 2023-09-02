import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:voice_assistant/constants/constants.dart';
import 'package:voice_assistant/widgets/text_widget.dart';
import 'package:lottie/lottie.dart';

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
          color: scaffoldBgColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: chatIndex == 0

                //user text

                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            color: usertextBGColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(1, 1),
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 15,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              chatIndex == 0
                                  ? TextWidget(
                                      label: msg,
                                      color: textColor,
                                    )
                                  : Expanded(
                                      child: DefaultTextStyle(
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
                                              speed: const Duration(
                                                  milliseconds: 20),
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
                      ),
                      const SizedBox(width: 10),
                      chatIndex == 0
                          ? Lottie.asset(
                              'assets/images/avatar_blue.json',
                              height: 45,
                              width: 45,
                            )
                          : Lottie.asset(
                              'assets/images/robot_white.json',
                              height: 35,
                              width: 35,
                            ),
                    ],
                  )

                //Bot text

                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      chatIndex == 0
                          ? Lottie.asset(
                              'assets/images/avatar_blue.json',
                              height: 40,
                              width: 40,
                            )
                          : CircleAvatar(
                              backgroundColor: bottextBGColor,
                              child: Lottie.asset(
                                'assets/images/robot_white.json',
                                height: 35,
                                width: 35,
                              ),
                            ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: bottextBGColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(1, 1),
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              chatIndex == 0
                                  ? TextWidget(
                                      label: msg,
                                      color: textColor,
                                    )
                                  : Expanded(
                                      child: DefaultTextStyle(
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
                                              speed: const Duration(
                                                  milliseconds: 20),
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
                      ),
                    ],
                  ),
          ),
        )
      ],
    );
  }
}
