import 'package:hosrem_app/api/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'user_pagination.g.dart';

/// User pagination response model.
@JsonSerializable(nullable: false)
class UserPagination extends Pagination<User> {
  UserPagination(int totalItems, int page, int totalPages, int size, List<User> items)
    : super(totalItems, page, totalPages, size, items);

  factory UserPagination.fromJson(Map<String, dynamic> json) => _$UserPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$UserPaginationToJson(this);
}
