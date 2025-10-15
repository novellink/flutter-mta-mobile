class BaseResponse {
  final int resultCode;
  final Map<String, dynamic> resultData;

  BaseResponse({
    required this.resultCode,
    required this.resultData,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      resultCode: json['resultCode'] as int,
      resultData: json['resultData'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resultCode': resultCode,
      'resultData': resultData,
    };
  }
}
