import 'package:flutter/material.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';

class AlertArriveDriver extends StatelessWidget {
  const AlertArriveDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(driverArrived.i18n),
      content: Text(driverArrived.i18n),
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
