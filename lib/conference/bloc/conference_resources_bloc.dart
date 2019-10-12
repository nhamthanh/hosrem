import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/conference_resource.dart';
import 'package:hosrem_app/api/conference/conference_resource_pagination.dart';
import 'package:hosrem_app/common/error_handler.dart';

import '../conference_service.dart';
import 'conference_resources_event.dart';
import 'conference_resources_state.dart';

/// Conference bloc to load conferences.
class ConferenceResourcesBloc extends Bloc<ConferenceResourcesEvent, ConferenceResourcesState> {
  ConferenceResourcesBloc({@required this.conferenceService}) : assert(conferenceService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 10;

  final ConferenceService conferenceService;

  List<ConferenceResource> conferenceResources = <ConferenceResource>[];
  ConferenceResourcePagination conferenceResourcePagination;

  @override
  ConferenceResourcesState get initialState => ConferenceResourcesLoading();

  @override
  Stream<ConferenceResourcesState> mapEventToState(ConferenceResourcesEvent event) async* {
    if (event is RefreshConferenceResourcesEvent) {
      try {
        conferenceResourcePagination = await conferenceService.getConferenceResources(DEFAULT_PAGE, DEFAULT_PAGE_SIZE);
        conferenceResources = conferenceResourcePagination.items;
        yield RefreshConferenceResourcesCompleted(conferenceResources: conferenceResources);
        yield LoadedConferenceResources(conferenceResources: conferenceResources);
      } catch (error) {
        yield ConferenceResourcesFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoadMoreConferenceResourcesEvent) {
      try {
        if (conferenceResourcePagination.page < conferenceResourcePagination.totalPages) {
          conferenceResourcePagination = await conferenceService.getConferenceResources(
            conferenceResourcePagination.page + 1, conferenceResourcePagination.size);
          conferenceResources.addAll(conferenceResourcePagination.items);
        }
        yield LoadedConferenceResources(conferenceResources: conferenceResources);
      } catch (error) {
        yield ConferenceResourcesFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
