import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LogoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 40.0,
        child: Icon(
          MdiIcons.numeric1,
          color: Colors.lightBlueAccent,
          size: 80.0,
        ),
      ),
    );
  }
}
