import 'package:flutter/material.dart';

/// A loading indicator.
class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
