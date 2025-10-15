// 상태값
// 토큰 값
class ApiResponse {
  final int resultCode;
  final ResultData resultData;

  ApiResponse({
    required this.resultCode,
    required this.resultData,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      resultCode: json['resultCode'],
      resultData: ResultData.fromJson(json['resultData']),
    );
  }
}

// token
class ResultData {
  final String token;

  ResultData({
    required this.token,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) {
    return ResultData(
      token: json['token'],
    );
  }
}
