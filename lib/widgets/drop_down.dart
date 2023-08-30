import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:voice_assistant/providers/models_provider.dart';
import '../constants/constants.dart';
import '../models/chatmodels_model.dart';

class ModelDropDownWidget extends StatefulWidget {
  const ModelDropDownWidget({super.key});

  @override
  State<ModelDropDownWidget> createState() => _ModelDropDownWidgetState();
}

class _ModelDropDownWidgetState extends State<ModelDropDownWidget> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelsProvider.getCurrentModel;
    return FutureBuilder<List<ChatModel>>(
      future: modelsProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          return DropdownButton<String>(
            dropdownColor: scaffoldBgColor,
            isExpanded: true,
            iconEnabledColor: Colors.white,
            items: List<DropdownMenuItem<String>>.generate(
              snapshot.data!.length,
              (index) => DropdownMenuItem<String>(
                  value: snapshot.data![index].root,
                  child: Text(
                    snapshot.data![index].root,
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                    ),
                  )
                  // TextWidget(
                  //   label: snapshot.data![index].root,
                  //   fontsize: 15,
                  //   color: textColor,
                  // ),
                  ),
            ),
            value: currentModel,
            onChanged: (value) {
              setState(() {
                currentModel = value.toString();
              });
              modelsProvider.setCurrentModel(value.toString());
            },
          );
        } else {
          return SizedBox(
            height: 30,
            width: 300,
            child: SpinKitThreeBounce(
              color: textColor,
              size: 18,
            ),
          );
        }
      },
    );
  }
}
