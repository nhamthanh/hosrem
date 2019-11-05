import 'package:hosrem_app/api/auth/field.dart';
import 'package:hosrem_app/api/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'field_pagination.g.dart';
/// Field response model.
@JsonSerializable(nullable: false)
class FieldPagination extends Pagination<Field> {
  FieldPagination(int totalItems, int page, int totalPages, int size, List<Field> items)
    : super(totalItems, page, totalPages, size, items);

  factory FieldPagination.fromJson(Map<String, dynamic> json) => _$FieldPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$FieldPaginationToJson(this);
}
