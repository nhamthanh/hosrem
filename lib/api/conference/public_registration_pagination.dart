import 'package:hosrem_app/api/conference/public_registration.dart';
import 'package:hosrem_app/api/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_registration_pagination.g.dart';

/// Public registration pagination response model.
@JsonSerializable(nullable: false)
class PublicRegistrationPagination extends Pagination<PublicRegistration> {
  PublicRegistrationPagination(int totalItems, int page, int totalPages, int size, List<PublicRegistration> items)
    : super(totalItems, page, totalPages, size, items);

  factory PublicRegistrationPagination.fromJson(Map<String, dynamic> json) => _$PublicRegistrationPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PublicRegistrationPaginationToJson(this);
}