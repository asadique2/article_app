class GenericResponse {
  GenericResponse({this.message, this.data, this.success, this.statusCode});

  GenericResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'];
    success = json['success'];
    statusCode = json['statusCode'];
  }
  bool? success;
  dynamic data;
  String? message;
  int? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    map['message'] = message;
    map['statusCode'] = statusCode;
    return map;
  }
}
