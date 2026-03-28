import 'package:flutter/material.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';

class AlertArriveDriver extends StatelessWidget {
  const AlertArriveDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        driverArrived.i18n,
        textAlign: TextAlign.center,
        style: StylesForTexts(
          context: context,
        ).headerStyleSmall().copyWith(color: Theme.of(context).primaryColor),
      ),
      content: Text(
        driverArrived.i18n,
        style: StylesForTexts(context: context).bodyStyle(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(ok.i18n),
        ),
      ],
    );
  }
}
