import 'package:hosrem_app/api/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

import 'membership.dart';

part 'membership_pagination.g.dart';

/// Membership pagination response model.
@JsonSerializable(nullable: false)
class MembershipPagination extends Pagination<Membership> {
  MembershipPagination(int totalItems, int page, int totalPages, int size, List<Membership> items)
    : super(totalItems, page, totalPages, size, items);

  factory MembershipPagination.fromJson(Map<String, dynamic> json) => _$MembershipPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipPaginationToJson(this);
}
