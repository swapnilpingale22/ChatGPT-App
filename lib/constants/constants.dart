import 'package:flutter/material.dart';
import 'package:voice_assistant/constants/secrets.dart';

Color scaffoldBgColor = const Color(0xff9EB384);
Color cardColor = const Color(0xff435334);
Color textColor = const Color(0xffFAF1E4);
Color usertextBGColor = const Color(0xff183D3D);
Color bottextBGColor = const Color(0xff4E3636);

const String bardUrl =
    "https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=$bardApiKey";

const String bardModelUrl =
    "https://generativelanguage.googleapis.com/v1beta2/models?key=$bardApiKey";
