/// Api error.
///
/// To create an [ApiError], call [ApiError()] or use [ApiError.fromJson()]
class ApiError {
  ApiError({this.message, this.objectName});

  /// Create [ApiError] from [json] object.
  ApiError.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        objectName = json['object_name'];

  final String message;
  final String objectName;
}

