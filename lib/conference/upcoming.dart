import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/widget/refresher/refresh_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/conferences_bloc.dart';
import 'bloc/conferences_event.dart';
import 'bloc/conferences_state.dart';
import 'conference_detail.dart';
import 'conference_item.dart';
import 'conference_service.dart';

/// Conferences page.
class Conferences extends StatefulWidget {
  @override
  State<Conferences> createState() => _ConferencesState();
}

class _ConferencesState extends BaseState<Conferences> {
  RefreshController _refreshController;
  ConferencesBloc _conferenceBloc;

  @override
  void initState() {
    super.initState();
    _conferenceBloc = ConferencesBloc(conferenceService: ConferenceService(apiProvider));
    _refreshController = RefreshController();

    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConferencesBloc>(
      builder: (BuildContext context) => _conferenceBloc,
      child: BlocListener<ConferencesBloc, ConferencesState>(
        listener: (BuildContext context, ConferencesState state) {
          if (state is ConferenceFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ConferencesBloc, ConferencesState>(
          bloc: _conferenceBloc,
          builder: (BuildContext context, ConferencesState state) {
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();

            if (state is RefreshConferencesCompleted) {
              return _buildRefreshWidget(state.conferences);
            }

            if (state is LoadedConferences) {
              return _buildRefreshWidget(state.conferences);
            }

            return LoadingIndicator();
          }
        )
      )
    );
  }

  RefreshWidget _buildRefreshWidget(List<Conference> conferences) {
    return RefreshWidget(
      child: ListView.builder(
        itemCount: conferences.length,
        itemBuilder: (BuildContext context, int index) {
          final Conference conference = conferences[index];
          return InkWell(
            child: ConferenceItem(conference),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<bool>(builder: (BuildContext context) => ConferenceDetail())
              );
            }
          );
        },
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      refreshController: _refreshController
    );
  }

  void _onLoading() {
    _conferenceBloc.dispatch(LoadMoreConferencesEvent());
  }

  void _onRefresh() {
    _conferenceBloc.dispatch(RefreshConferencesEvent());
  }

  @override
  void dispose() {
    _conferenceBloc.dispose();
    super.dispose();
  }
}
