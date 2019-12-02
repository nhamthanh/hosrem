import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hosrem_app/common/base_state.dart';

/// Rotation state widget.
abstract class RotationState<T extends StatefulWidget> extends BaseState<T> {

  @override
  void initState() {
    super.initState();
    _enableRotation();
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations(<DeviceOrientation> [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

}