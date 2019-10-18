import 'dart:io';

import 'package:hosrem_app/api/document/document_pagination.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Document service.
class DocumentService {
  DocumentService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get documents by [conferenceId].
  Future<DocumentPagination> getDocumentsByConferenceId(String conferenceId, int page, int size) async {
    final DocumentPagination documentPagination = await apiProvider.documentApi.getAll(<String, dynamic>{
      'page': page,
      'size': size,
      'type': 'Speaker'
    });
    return documentPagination;
  }

  /// Download and cache files.
  Future<void> downloadAndCacheFiles(List<String> urls, String token) async {
    urls?.map((String url) => apiProvider.cacheManager.getSingleFile(url));
  }

  /// Get document from cache or download from [url] and [token].
  Future<File> getDocumentFromCacheOrDownload(String url, String token) async {
    await Future<void>.delayed(Duration(milliseconds: 500));
    return apiProvider.cacheManager.getSingleFile(url);
  }
}
