// lib/api/kiosk-controller/kiosk_api_client.dart
import 'package:dio/dio.dart';
import 'package:novel/api/response/BaseResponseModel.dart';
import 'package:novel/api/response/UserResponseModel.dart';
import 'response/ApiResponseModel.dart';

class KioskApiClient {
  final Dio _dio;
  static const String baseUrl = 'https://novel.rosq.co.kr:8488/api';

  KioskApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 3),
        ),
      );

  // 무조건 토큰 발급해야함 매번마다
  Future<ApiResponse> authKiosk(String kioskId) async {
    try {
      final response = await _dio.post(
        '/auth-kiosk',
        data: {"kioskid": kioskId},
      );
      return ApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 결과 내보내기
  Future<BaseResponse> setResult({
    required String token,
    required String measureId,
    required String systolic,
    required String diastolic,
    required String pulse,
    String status = "고혈압",
    bool serviceForce = true,
  }) async {
    try {
      final response = await _dio.post(
        '/set-result',
        data: {
          "token": token,
          "measureid": measureId,
          "device": "BP",
          "result": {
            "high": systolic,
            "low": diastolic,
            "pulse": pulse,
            "status": status,
          },
          "serviceforce": serviceForce.toString(),
        },
      );
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 계정 조회
  Future<UserResponse> authUser({
    required String userid,
    required String type,
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        '/auth-user',
        data: {"userid": userid, "type": type, "token": token},
      );
      return UserResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('서버 연결 시간이 초과되었습니다');
      case DioExceptionType.badResponse:
        return Exception('서버 오류: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('요청이 취소되었습니다');
      default:
        return Exception('네트워크 오류가 발생했습니다');
    }
  }
}
