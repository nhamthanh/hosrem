import 'package:hosrem_app/api/auth/degree.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hosrem_app/api/pagination/pagination.dart';
part 'degree_pagination.g.dart';
/// Degree response model.
@JsonSerializable(nullable: false)
class DegreePagination extends Pagination<Degree> {
  DegreePagination(int totalItems, int page, int totalPages, int size, List<Degree> items)
    : super(totalItems, page, totalPages, size, items);

  factory DegreePagination.fromJson(Map<String, dynamic> json) => _$DegreePaginationFromJson(json);

  Map<String, dynamic> toJson() => _$DegreePaginationToJson(this);
}
