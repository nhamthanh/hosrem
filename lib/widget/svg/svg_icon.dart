import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

/// The svg icon widget.
class SvgIcon extends StatelessWidget {
  const SvgIcon(this.assetName, {Key key, this.size = 32}) : super(key: key);

  final String assetName;
  final int size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName, width: 32.0, height: 32.0);
  }
}
