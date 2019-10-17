import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/widget/refresher/refresh_widget.dart';
import 'package:hosrem_app/widget/text/search_text_field.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/conferences_bloc.dart';
import 'bloc/conferences_event.dart';
import 'bloc/conferences_state.dart';
import 'conference_detail.dart';
import 'conference_item.dart';
import 'conference_service.dart';

/// Upcoming conferences page.
class UpcomingConferences extends StatefulWidget {
  const UpcomingConferences({Key key, this.criteria = const <String, dynamic>{}}) : super(key: key);

  final Map<String, dynamic> criteria;

  @override
  State<UpcomingConferences> createState() => _UpcomingConferencesState();
}

class _UpcomingConferencesState extends BaseState<UpcomingConferences> {
  RefreshController _refreshController;
  ConferencesBloc _conferenceBloc;

  @override
  void initState() {
    super.initState();
    _conferenceBloc = ConferencesBloc(
      conferenceService: ConferenceService(apiProvider),
      authService: AuthService(apiProvider)
    );
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

            if (state is LoadedConferences) {
              return _buildRefreshWidget(state.conferences, state.token, state.registeredConferences);
            }

            if (state is ConferenceFailure) {
              return Center(
                child: const Text('No conference found')
              );
            }

            return LoadingIndicator();
          }
        )
      )
    );
  }

  Widget _buildRefreshWidget(List<Conference> conferences, String token, Map<String, bool> registeredConferences) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SearchTextField(
                    executeSearch: _searchConferences
                  )
                ),
              ],
            )
          ),
          Expanded(
            child: RefreshWidget(
              child: ListView.builder(
                itemCount: conferences.length,
                itemBuilder: (BuildContext context, int index) {
                  final Conference conference = conferences[index];
                  return InkWell(
                    child: ConferenceItem(conference, apiConfig, token, registeredConferences[conference.id] ?? false),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<bool>(builder: (BuildContext context) => ConferenceDetail(conference, apiConfig, token))
                      );
                    }
                  );
                },
              ),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              refreshController: _refreshController
            )
          )
        ],
      )
    );
  }

  void _onLoading() {
    _conferenceBloc.dispatch(LoadMoreConferencesEvent(searchCriteria: widget.criteria));
  }

  void _onRefresh() {
    _conferenceBloc.dispatch(RefreshConferencesEvent(searchCriteria: widget.criteria));
  }

  void _searchConferences(String value) {
    final Map<String, dynamic> searchCriteria = <String, dynamic>{};
    searchCriteria.addAll(widget.criteria);
    searchCriteria['title'] = value;
    _conferenceBloc.dispatch(RefreshConferencesEvent(searchCriteria: searchCriteria));
  }

  @override
  void dispose() {
    _conferenceBloc.dispose();
    super.dispose();
  }
}
