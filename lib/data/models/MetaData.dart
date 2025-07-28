class MetaData {
  int? code;
  String? status;
  String? message;

  MetaData({
    this.code,
    this.status,
    this.message,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      code: json['code'] ?? 0,
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code' : code,
      'status': status,
      'message': message,
    };
  }
}