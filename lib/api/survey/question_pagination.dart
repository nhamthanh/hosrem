import 'package:json_annotation/json_annotation.dart';

import 'package:hosrem_app/api/pagination/pagination.dart';

import 'question.dart';

part 'question_pagination.g.dart';

/// Article response model.
@JsonSerializable(nullable: false)
class QuestionPagination extends Pagination<Question> {
  QuestionPagination(int totalItems, int page, int totalPages, int size, List<Question> items)
    : super(totalItems, page, totalPages, size, items);

  factory QuestionPagination.fromJson(Map<String, dynamic> json) => _$QuestionPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionPaginationToJson(this);
}
