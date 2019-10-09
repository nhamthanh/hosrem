import 'package:json_annotation/json_annotation.dart';

import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/pagination/pagination.dart';

part 'conference_pagination.g.dart';

/// Conference response model.
@JsonSerializable(nullable: false)
class ConferencePagination extends Pagination<Conference> {
  ConferencePagination(int totalItems, int page, int totalPages, int size, List<Conference> items)
    : super(totalItems, page, totalPages, size, items);

  factory ConferencePagination.fromJson(Map<String, dynamic> json) => _$ConferencePaginationFromJson(json);

  Map<String, dynamic> toJson() => _$ConferencePaginationToJson(this);
}
