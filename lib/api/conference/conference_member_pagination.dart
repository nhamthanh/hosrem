import 'package:hosrem_app/api/auth/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hosrem_app/api/pagination/pagination.dart';

part 'conference_member_pagination.g.dart';

/// Conference member response model.
@JsonSerializable(nullable: false)
class ConferenceMemberPagination extends Pagination<User> {
  ConferenceMemberPagination(int totalItems, int page, int totalPages, int size, List<User> items)
    : super(totalItems, page, totalPages, size, items);

  factory ConferenceMemberPagination.fromJson(Map<String, dynamic> json) => _$ConferenceMemberPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$ConferenceMemberPaginationToJson(this);
}
