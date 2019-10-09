import 'package:hosrem_app/api/conference/conference_resource.dart';
import 'package:hosrem_app/api/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conference_resource_pagination.g.dart';

/// Conference resource pagination response model.
@JsonSerializable(nullable: false)
class ConferenceResourcePagination extends Pagination<ConferenceResource> {
  ConferenceResourcePagination(int totalItems, int page, int totalPages, int size, List<ConferenceResource> items)
    : super(totalItems, page, totalPages, size, items);

  factory ConferenceResourcePagination.fromJson(Map<String, dynamic> json) => _$ConferenceResourcePaginationFromJson(json);

  Map<String, dynamic> toJson() => _$ConferenceResourcePaginationToJson(this);
}
