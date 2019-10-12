import 'package:flutter/material.dart';

/// Loading indicator with scaffold.
class LoadingScaffoldIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
