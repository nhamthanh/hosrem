import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

/// The svg icon widget.
class SvgIcon extends StatelessWidget {
  const SvgIcon(this.assetName, {Key key, this.size = 32.0, this.color}) : super(key: key);

  final String assetName;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName, width: size, height: size, color: color);
  }
}
