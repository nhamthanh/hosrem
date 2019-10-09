import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference_resource.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/widget/pdf/pdf_viewer.dart';
import 'package:hosrem_app/widget/refresher/refresh_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/conference_resources_bloc.dart';
import 'bloc/conference_resources_event.dart';
import 'bloc/conference_resources_state.dart';
import 'conference_detail.dart';
import 'conference_resource_item.dart';
import 'conference_service.dart';

/// Conference resources page.
class ConferenceResources extends StatefulWidget {
  @override
  State<ConferenceResources> createState() => _ConferenceResourcesState();
}

class _ConferenceResourcesState extends BaseState<ConferenceResources> {
  RefreshController _refreshController;
  ConferenceResourcesBloc _conferenceResourcesBloc;
  String pdfPath = '';

  @override
  void initState() {
    super.initState();
    _conferenceResourcesBloc = ConferenceResourcesBloc(conferenceService: ConferenceService(apiProvider));
    _refreshController = RefreshController();

    _onRefresh();

    createFileOfPdfUrl().then((f) {
      setState(() {
        pdfPath = f.path;
        print(pdfPath);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConferenceResourcesBloc>(
      builder: (BuildContext context) => _conferenceResourcesBloc,
      child: BlocListener<ConferenceResourcesBloc, ConferenceResourcesState>(
        listener: (BuildContext context, ConferenceResourcesState state) {
          if (state is ConferenceResourcesFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ConferenceResourcesBloc, ConferenceResourcesState>(
          bloc: _conferenceResourcesBloc,
          builder: (BuildContext context, ConferenceResourcesState state) {
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();

            if (state is RefreshConferenceResourcesCompleted) {
              return _buildRefreshWidget(state.conferenceResources);
            }

            if (state is LoadedConferenceResources) {
              return _buildRefreshWidget(state.conferenceResources);
            }

            return LoadingIndicator();
          }
        )
      )
    );
  }

  RefreshWidget _buildRefreshWidget(List<ConferenceResource> conferenceResources) {
    return RefreshWidget(
      child: ListView.builder(
        itemCount: conferenceResources.length,
        itemBuilder: (BuildContext context, int index) {
          final ConferenceResource conferenceResource = conferenceResources[index];
          return InkWell(
            child: ConferenceResourceItem(conferenceResource),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<bool>(builder: (BuildContext context) => PdfViewer(pdfPath))
            )
          );
        },
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      refreshController: _refreshController
    );
  }

  Future<File> createFileOfPdfUrl() async {
    final String url = 'http://hosrem.org.vn/public/frontend/upload/YHSS_47/02.pdf';
    final filename = url.substring(url.lastIndexOf('/') + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  void _onLoading() {
    _conferenceResourcesBloc.dispatch(LoadMoreConferenceResourcesEvent());
  }

  void _onRefresh() {
    _conferenceResourcesBloc.dispatch(RefreshConferenceResourcesEvent());
  }

  @override
  void dispose() {
    _conferenceResourcesBloc.dispose();
    super.dispose();
  }
}
