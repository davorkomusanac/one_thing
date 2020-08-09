import 'package:flutter/material.dart';

const kTasksBoxName = 'tasksBox';
const kProjectNameBox = 'projectBox';

const kAddActivityInputDecoration = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.symmetric(
    horizontal: 30.0,
    vertical: 5.0,
  ),
);

const kAlertDialogPadding = EdgeInsets.only(
  left: 20.0,
  right: 20.0,
  top: 35.0,
  bottom: 15.0,
);

const kProjectNamePadding = EdgeInsets.only(
  top: 20.0,
  left: 16.0,
  right: 15.0,
);

const kSubtitlePadding = EdgeInsets.only(
  left: 32.0,
  right: 20.0,
  bottom: 20.0,
  top: 5.0,
);

const kSubtitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
);

const kTasksListBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  ),
);

const kQuotePadding = EdgeInsets.only(
  left: 10.0,
  right: 10.0,
  top: 30.0,
  bottom: 10.0,
);
