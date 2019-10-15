import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

/// Document response model.
@JsonSerializable(nullable: false)
class Document {
  Document(this.id, this.content, this.createdTime, this.previewImg, this.speakers, this.speakingTime,
    this.title, {this.docType = 'pdf'});

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'content')
  final String content;

  @JsonKey(name: 'createdTime')
  final DateTime createdTime;

  @JsonKey(name: 'previewImg')
  final String previewImg;

  @JsonKey(name: 'speakers')
  final String speakers;

  @JsonKey(name: 'speakingTime')
  final String speakingTime;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'docType')
  final String docType;

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
