import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ModelDropDownWidget extends StatefulWidget {
  const ModelDropDownWidget({super.key});

  @override
  State<ModelDropDownWidget> createState() => _ModelDropDownWidgetState();
}

class _ModelDropDownWidgetState extends State<ModelDropDownWidget> {
  String currentModel = "Model 1";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: scaffoldBgColor,
      iconEnabledColor: Colors.white,
      items: getModelsItem(),
      value: currentModel,
      onChanged: (value) {
        setState(() {
          currentModel = value.toString();
        });
      },
    );
  }
}
