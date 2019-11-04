import 'package:hosrem_app/api/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user_conference.dart';

part 'user_conference_pagination.g.dart';

/// User conference pagination response model.
@JsonSerializable(nullable: false)
class UserConferencePagination extends Pagination<UserConference> {
  UserConferencePagination(int totalItems, int page, int totalPages, int size, List<UserConference> items)
    : super(totalItems, page, totalPages, size, items);

  factory UserConferencePagination.fromJson(Map<String, dynamic> json) => _$UserConferencePaginationFromJson(json);

  Map<String, dynamic> toJson() => _$UserConferencePaginationToJson(this);
}
