import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/public_registration.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/conference/participate/bloc/search_registered_users_bloc.dart';
import 'package:hosrem_app/conference/participate/bloc/search_registered_users_event.dart';
import 'package:hosrem_app/conference/participate/bloc/search_registered_users_state.dart';
import 'package:hosrem_app/conference/participate/search_registered_users_item.dart';
import 'package:hosrem_app/conference/participate/search_registered_users_service.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/widget/refresher/refresh_widget.dart';
import 'package:hosrem_app/widget/text/search_text_field.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// SearchRegisteredUsers of conference page.
class SearchRegisteredUsers extends StatefulWidget {
  const SearchRegisteredUsers(this.conferenceId, {Key key, this.searchRegisteredUsersBloc, this.criteria = const <String, dynamic>{}}) : assert(conferenceId != null), super(key: key);

  final SearchRegisteredUsersBloc searchRegisteredUsersBloc;
  final Map<String, dynamic> criteria;
  final String conferenceId;

  @override
  State<SearchRegisteredUsers> createState() => _SearchRegisteredUsersState();
}

class _SearchRegisteredUsersState extends BaseState<SearchRegisteredUsers> {
  RefreshController _refreshController;
  SearchRegisteredUsersBloc _searchRegisteredUsersBloc;

  @override
  void initState() {
    super.initState();
    _searchRegisteredUsersBloc = widget.searchRegisteredUsersBloc ?? SearchRegisteredUsersBloc(
      searchRegisteredUsersService: SearchRegisteredUsersService(apiProvider),
      authService: AuthService(apiProvider)
    );
    _refreshController = RefreshController();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchRegisteredUsersBloc>(
      builder: (BuildContext context) => _searchRegisteredUsersBloc,
      child: BlocListener<SearchRegisteredUsersBloc, SearchRegisteredUsersState>(
        listener: (BuildContext context, SearchRegisteredUsersState state) {
          if (state is SearchRegisteredUsersFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<SearchRegisteredUsersBloc, SearchRegisteredUsersState>(
          bloc: _searchRegisteredUsersBloc,
          builder: (BuildContext context, SearchRegisteredUsersState state) {
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();

            if (state is LoadedSearchRegisteredUsers) {
              return _buildContentPage(state.searchRegisteredUsers);
            }

            if (state is SearchRegisteredUsersFailure) {
              return Center(
                child: Text(AppLocalizations.of(context).tr('conferences.no_conference_found'))
              );
            }

            return LoadingIndicator();
          }
        )
      )
    );
  }

  Widget _buildContentPage(List<PublicRegistration> SearchRegisteredUser) {
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
                    executeSearch: _searchSearchRegisteredUser
                  )
                ),
              ],
            )
          ),
          Expanded(
            child: _buildRefreshWidget(SearchRegisteredUser)
          )
        ],
      )
    );
  }

  Widget _buildRefreshWidget(List<PublicRegistration> searchRegisteredUser) {
    return RefreshWidget(
      child: ListView.builder(
        itemCount: searchRegisteredUser.length,
        itemBuilder: (BuildContext context, int index) {
          final PublicRegistration participate = searchRegisteredUser[index];
          return Container(
            child: SearchRegisteredUsersItem(participate, apiConfig),
          );
        },
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      refreshController: _refreshController
    );
    
  }

  void _onLoading() {
    _searchRegisteredUsersBloc.dispatch(LoadMoreSearchRegisteredUsersEvent(conferenceId: widget.conferenceId, searchCriteria: widget.criteria));
  }

  void _onRefresh() {
    _searchRegisteredUsersBloc.dispatch(RefreshSearchRegisteredUsersEvent(conferenceId: widget.conferenceId, searchCriteria: widget.criteria));
  }

  void _searchSearchRegisteredUser(String value) {
    final Map<String, dynamic> searchCriteria = <String, dynamic>{};
    searchCriteria.addAll(widget.criteria);
    searchCriteria['fullName'] = value.toLowerCase();
    _searchRegisteredUsersBloc.dispatch(RefreshSearchRegisteredUsersEvent(conferenceId: widget.conferenceId, searchCriteria: searchCriteria));
  }

  @override
  void dispose() {
    _searchRegisteredUsersBloc.dispose();
    super.dispose();
  }
}
