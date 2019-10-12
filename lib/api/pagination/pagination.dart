import 'package:json_annotation/json_annotation.dart';

/// Pagination response model.
class Pagination<T> {
  Pagination(this.totalItems, this.page, this.totalPages, this.size, this.items);

  @JsonKey(name: 'totalSize')
  final int totalItems;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'totalPage')
  final int totalPages;

  @JsonKey(name: 'size')
  final int size;

  @JsonKey(name: 'result')
  final List<T> items;
}
