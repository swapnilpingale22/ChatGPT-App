import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voice_assistant/widgets/text_widget.dart';
import '../constants/constants.dart';
import '../models/chatmodels_model.dart';
import '../services/api_services.dart';

class ModelDropDownWidget extends StatefulWidget {
  const ModelDropDownWidget({super.key});

  @override
  State<ModelDropDownWidget> createState() => _ModelDropDownWidgetState();
}

class _ModelDropDownWidgetState extends State<ModelDropDownWidget> {
  String currentModel = "gpt-3.5-turbo";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatModel>>(
      future: ApiServices.getModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          return FittedBox(
            child: DropdownButton<String>(
              dropdownColor: scaffoldBgColor,
              iconEnabledColor: Colors.white,
              items: List<DropdownMenuItem<String>>.generate(
                snapshot.data!.length,
                (index) => DropdownMenuItem<String>(
                  value: snapshot.data![index].root,
                  child: TextWidget(
                    label: snapshot.data![index].root,
                    fontsize: 15,
                    color: textColor,
                  ),
                ),
              ),
              value: currentModel,
              onChanged: (value) {
                setState(() {
                  currentModel = value.toString();
                });
              },
            ),
          );
        } else {
          return Flexible(
            flex: 2,
            child: SizedBox(
              height: 30,
              width: 300,
              child: SpinKitThreeBounce(
                color: textColor,
                size: 18,
              ),
            ),
          );
        }
      },
    );
  }
}
