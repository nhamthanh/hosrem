import 'package:hosrem_app/api/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

import 'notification.dart';

part 'notification_pagination.g.dart';

/// Notification pagination response model.
@JsonSerializable(nullable: false)
class NotificationPagination extends Pagination<Notification> {
  NotificationPagination(int totalItems, int page, int totalPages, int size, List<Notification> items)
    : super(totalItems, page, totalPages, size, items);

  factory NotificationPagination.fromJson(Map<String, dynamic> json) => _$NotificationPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPaginationToJson(this);
}
