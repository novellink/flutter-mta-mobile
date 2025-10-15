// lib/api/kiosk-controller/user_response_model.dart

class UserResponse {
  final int resultCode;
  final UserData resultData;

  UserResponse({
    required this.resultCode,
    required this.resultData,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      resultCode: json['resultCode'],
      resultData: UserData.fromJson(json['resultData']),
    );
  }

  Map<String, dynamic> toJson() => {
    'resultCode': resultCode,
    'resultData': resultData.toJson(),
  };
}

class UserData {
  final String measureId;
  final String username;
  final String nextstep;
  final int status;
  final String gender;
  final String birthday;
  final String phoneNumber;

  UserData({
    required this.measureId,
    required this.username,
    required this.nextstep,
    required this.status,
    required this.gender,
    required this.birthday,
    required this.phoneNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      measureId: json['measureid'] ?? '',
      username: json['username'] ?? '',
      nextstep: json['nextstep'] ?? '',
      status: json['status'] ?? 0,
      gender: json['gender'] ?? '',
      birthday: json['birthday'] ?? '',
      phoneNumber: json['phonenumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'measureid': measureId,
    'username': username,
    'nextstep': nextstep,
    'status': status,
    'gender': gender,
    'birthday': birthday,
    'phonenumber': phoneNumber,
  };
}
