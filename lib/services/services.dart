import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/drop_down.dart';
import '../widgets/text_widget.dart';

class Services {
  static Future<void> showModalSheet(BuildContext context) async {
    await showModalBottomSheet(
      backgroundColor: scaffoldBgColor,
      context: context,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: TextWidget(
                  label: 'Choosen Model: ',
                  fontsize: 16,
                ),
              ),
              Flexible(
                flex: 2,
                child: ModelDropDownWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}
