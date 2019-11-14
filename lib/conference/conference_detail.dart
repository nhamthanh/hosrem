import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/document/document.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/connection/connection_provider.dart';
import 'package:hosrem_app/image/image_viewer.dart';
import 'package:hosrem_app/pdf/pdf_viewer.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'bloc/conference_bloc.dart';
import 'bloc/conference_event.dart';
import 'bloc/conference_state.dart';
import 'conference_overview.dart';
import 'conference_resources.dart';
import 'conference_service.dart';
import 'document_service.dart';

/// Conference detail page.
@immutable
class ConferenceDetail extends StatefulWidget {
  const ConferenceDetail(this.conferenceId, { this.selectedIndex = 0});

  final String conferenceId;
  final int selectedIndex;

  @override
  _ConferenceDetailState createState() => _ConferenceDetailState();
}

class _ConferenceDetailState extends BaseState<ConferenceDetail> with SingleTickerProviderStateMixin {
  final List<Widget> tabs = <Widget>[
    Container(child: const Tab(text: 'Tổng Quan'), width: 80.0),
    Container(child: const Tab(text: 'Chi Tiết'), width: 80.0),
    Container(child: const Tab(text: 'Tài Liệu'), width: 80.0),
  ];

  ConferenceBloc _conferenceBloc;
  DocumentService _documentService;
  TabController _tabController;
  AppBar _appBar;
  TabBar _tabBar;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: widget.selectedIndex, length: tabs.length);
    _documentService = DocumentService(apiProvider);
    _conferenceBloc = ConferenceBloc(conferenceService: ConferenceService(apiProvider),
        documentService: _documentService);
    _conferenceBloc.dispatch(LoadConferenceEvent(conferenceId: widget.conferenceId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConferenceBloc>(
      builder: (BuildContext context) => _conferenceBloc,
      child: BlocListener<ConferenceBloc, ConferenceState>(
        listener: (BuildContext context, ConferenceState state) {
          if (state is LoadedConferenceState) {
            _downloadAndCacheDocuments(state.documents);
          }
        },
        child: BlocBuilder<ConferenceBloc, ConferenceState>(
          bloc: _conferenceBloc,
          builder: (BuildContext context, ConferenceState state) {
            _appBar = AppBar(
              title: Text(state is LoadedConferenceState ? state.conference.title : ''),
              centerTitle: true,
            );

            _tabBar = _buildTabBar();
            return Scaffold(
              appBar: _appBar,
              body: Container(
                color: Colors.white,
                child: BlocProvider<ConferenceBloc>(
                  builder: (BuildContext context) => _conferenceBloc,
                  child: BlocListener<ConferenceBloc, ConferenceState>(
                    listener: (BuildContext context, ConferenceState state) {
                      if (state is LoadedConferenceState) {
                        _downloadAndCacheDocuments(state.documents);
                      }
                    },
                    child: BlocBuilder<ConferenceBloc, ConferenceState>(
                      bloc: _conferenceBloc,
                      builder: (BuildContext context, ConferenceState state) {
                        return ConnectionProvider(
                          child: LoadingOverlay(
                            isLoading: state is ConferenceLoading,
                            child: state is LoadedConferenceState
                              ? _buildConferenceWidget(context, state.conference, state.documents)
                              : Container()
                          )
                        );
                      }
                    )
                  )
                )
              )
            );
          }
        )
      )
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: AppColors.unselectLabelColor,
      labelStyle: TextStyles.textStyle16,
      unselectedLabelStyle: TextStyles.textStyle16,
      labelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BubbleTabIndicator(
        indicatorHeight: 36.0,
        indicatorColor: AppColors.lightPrimaryColor,
        indicatorRadius: 20.0,
        tabBarIndicatorSize: TabBarIndicatorSize.tab,
      ),
      tabs: tabs,
      controller: _tabController
    );
  }

  Column _buildConferenceWidget(BuildContext context, Conference conference, List<Document> documents) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 5.0),
        _buildTabBar(),
        const SizedBox(height: 5.0),
        Expanded(
          child: Container(
            color: Colors.white,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ConferenceOverview(conference: conference),
                _buildPdfWidget(documents, context),
                ConferenceResources(conference)
              ]
            )
          )
        )
      ]
    );
  }

  Widget _buildPdfWidget(List<Document> documents, BuildContext context) {
    final List<String> files = documents.map(_constructDocumentUrl).toList();
    if (files.isNotEmpty) {
      if ((files[0]?.toLowerCase() ?? '').endsWith('pdf')) {
        return PdfViewer(
          url: files[0],
          top: _appBar.preferredSize.height + MediaQuery.of(context).padding.top + _tabBar.preferredSize.height + 55.0,
          width: _calculatePdfWidth(context),
          height: _calculatePdfHeight(context),
        );
      } else {
        return ImageViewer(url: files[0]);
      }
    }

    return Center(
      child: Text(
        AppLocalizations.of(context).tr('conferences.details.no_document_found'),
        style: TextStyles.textStyle16PrimaryBlack
      )
    );
  }

  double _calculatePdfHeight(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double top = _appBar.preferredSize.height;
    double height = mediaQuery.size.height - top;
    if (height < 0.0) {
      height = 0.0;
    }

    return height;
  }

  double _calculatePdfWidth(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }

  void _downloadAndCacheDocuments(List<Document> documents) {
    final List<String> files = documents.map(_constructDocumentUrl).toList();
    _documentService.downloadAndCacheFiles(files);
  }

  String _constructDocumentUrl(Document document) =>
    '${apiConfig.apiBaseUrl}conferences/${widget.conferenceId}/document?fileName=${document.content}';
}
