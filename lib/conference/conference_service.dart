import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:hosrem_app/api/conference/conference_pagination.dart';
import 'package:hosrem_app/api/conference/conference_resource_pagination.dart';
import 'package:hosrem_app/network/api_provider.dart';
import 'package:path_provider/path_provider.dart';

/// Conference service.
class ConferenceService {
  ConferenceService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get conferences.
  Future<ConferencePagination> getConferences(Map<String, dynamic> queryParams) async {
    final ConferencePagination conferences = await apiProvider.conferenceApi.getAll(queryParams);
    return conferences;
  }

  /// Get conference resources.
  Future<ConferenceResourcePagination> getConferenceResources(int page, int size) async {
    final ConferenceResourcePagination conferenceResources = await apiProvider.conferenceApi.getAllConferenceResources(<String, dynamic>{
      'page': page,
      'size': size
    });
    return conferenceResources;
  }

  /// Download conference resources
  Future<File> downloadResource(String url) async {
    final String filename = url.substring(url.lastIndexOf('/') + 1);
    final HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
    final HttpClientResponse response = await request.close();
    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}
