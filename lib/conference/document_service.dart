import 'dart:io';

import 'package:hosrem_app/api/conference/conference_auth.dart';
import 'package:hosrem_app/api/document/document_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Document service.
class DocumentService {
  DocumentService(this.apiProvider) : assert(apiProvider != null);

  static const String SPEAKER_DOCUMENT_TYPE = 'Speaker';
  static const String OTHER_DOCUMENT_TYPE = 'Other';
  static const int HALF_SECOND_IN_MILLISECOND = 500;

  final ApiProvider apiProvider;

  /// Get documents by [conferenceId].
  Future<DocumentPagination> getDocumentsByConferenceId(String conferenceId, String type, int page, int size) async {
    final DocumentPagination documentPagination = await apiProvider.conferenceApi.getConferenceDocuments(
      conferenceId, <String, dynamic>{
      'page': page,
      'size': size,
      'type': type,
      'sort': 'speakingTime:asc'
    });
    return documentPagination;
  }

  /// Get documents by [conferenceId].
  Future<DocumentPagination> getDocuments(String conferenceId, String type, int page, int size) async {
    final AuthService authService = AuthService(apiProvider);
    final ConferenceAuth conferenceAuth = await authService.getConferenceAuth(conferenceId);
    final Map<String, dynamic> queryParams = <String, dynamic>{
      'conference': conferenceId,
      'page': page,
      'size': size,
      'type': type,
      'sort': 'speakingTime:asc'
    };

    if (conferenceAuth != null) {
      queryParams['conferenceId'] = conferenceId;
      queryParams['fullName'] = conferenceAuth.fullName;
      queryParams['regCode'] = conferenceAuth.regCode;

      final DocumentPagination documentPagination = await apiProvider.documentApi.getAllWli(queryParams);
      return documentPagination;
    }

    final DocumentPagination documentPagination = await apiProvider.documentApi.getAll(queryParams);
    return documentPagination;
  }

  /// Download and cache files.
  Future<void> downloadAndCacheFiles(List<String> urls) async {
    urls?.map((String url) => apiProvider.cacheManager.getSingleFile(url));
  }

  /// Get document from cache or download from [url] and [token].
  Future<File> getDocumentFromCacheOrDownload(String url, String token) async {
    // ignore: flutter_style_todos
    // TODO: Wait a little bit to make sure animation is done.
    await Future<void>.delayed(Duration(milliseconds: 500));
    final int startTimeInEpoch = DateTime.now().millisecondsSinceEpoch;
    final File file = await apiProvider.cacheManager.getSingleFile(url);
    final int diff = DateTime.now().millisecondsSinceEpoch - startTimeInEpoch;
    if (diff < HALF_SECOND_IN_MILLISECOND) {
      await Future<void>.delayed(Duration(milliseconds: HALF_SECOND_IN_MILLISECOND - diff));
    }
    return file;
  }
}
