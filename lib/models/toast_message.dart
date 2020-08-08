import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  BuildContext context;
  int counter = 0;

  ToastMessage(this.context);

  void showToast() {
    counter++;
    var fToast = FToast(context);
    fToast.showToast(
      child: _createToast(),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
    if (counter > 5) {
      fToast.removeQueuedCustomToasts();
      counter = 0;
    }
  }

  Widget _createToast() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.lightBlueAccent,
        ),
        child: Text(
          "You cannot add a new task until your old one is finished",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}
