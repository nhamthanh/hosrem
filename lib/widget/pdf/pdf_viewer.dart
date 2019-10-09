import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

/// PDF Viewer.
@immutable
class PdfViewer extends StatelessWidget {
  const PdfViewer(this.pdfPath);

  final String pdfPath;

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: const Text('Document'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      path: pdfPath);
  }
}
