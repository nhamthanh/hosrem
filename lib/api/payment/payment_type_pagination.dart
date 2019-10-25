import 'package:hosrem_app/api/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

import 'payment_type.dart';

part 'payment_type_pagination.g.dart';

/// Document response model.
@JsonSerializable(nullable: false)
class PaymentTypePagination extends Pagination<PaymentType> {
  PaymentTypePagination(int totalItems, int page, int totalPages, int size, List<PaymentType> items)
    : super(totalItems, page, totalPages, size, items);

  factory PaymentTypePagination.fromJson(Map<String, dynamic> json) => _$PaymentTypePaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTypePaginationToJson(this);
}
