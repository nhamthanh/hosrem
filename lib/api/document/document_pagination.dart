import 'package:hosrem_app/api/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hosrem_app/api/document/document.dart';

part 'document_pagination.g.dart';

/// Document response model.
@JsonSerializable(nullable: false)
class DocumentPagination extends Pagination<Document> {
  DocumentPagination(int totalItems, int page, int totalPages, int size, List<Document> items)
    : super(totalItems, page, totalPages, size, items);

  factory DocumentPagination.fromJson(Map<String, dynamic> json) => _$DocumentPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentPaginationToJson(this);
}
