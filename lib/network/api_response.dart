import 'package:equatable/equatable.dart';

/// Api response.
class ApiResponse extends Equatable {
  ApiResponse({this.total, this.page, this.size, this.items})
      : super(<Object>[total, page, size, items]);

  /// Create [ApiResponse] from [json] path.
  ApiResponse.fromJson(dynamic json) :
    total = json['data'][FIELD_TOTAL],
    page = json['data'][FIELD_PAGE],
    size = json['data'][FIELD_SIZE],
    items = json['data'][FIELD_ITEMS];

  static const String FIELD_TOTAL = 'total';
  static const String FIELD_PAGE = 'page_num';
  static const String FIELD_SIZE = 'page_size';
  static const String FIELD_ITEMS = 'items';

  final int total;
  final int page;
  final int size;
  final List<dynamic> items;
}
