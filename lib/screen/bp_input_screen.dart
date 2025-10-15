import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel/model/TempBpStore.dart';


import '../api/kiosk-controller.dart';
import '../api/response/ApiResponseModel.dart';
import '../component/blood-pressure-component/bp-input/bp_input_Measure.dart';
import '../component/blood-pressure-component/bp-input/bp_input_time.dart';
import '../component/blood-pressure-component/bp-input/bp_input_top.dart';

Future<void> showBpInputModal(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black38,
    builder: (context) {
      return Expanded(
        child: DraggableScrollableSheet(
          expand: true,
          initialChildSize: 0.92,
          minChildSize: 0.92,
          maxChildSize: 0.92,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -6),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                child: const _BpInputContent(),
              ),
            );
          },
        ),
      );
    },
  );
}

class _BpInputContent extends StatefulWidget {
  const _BpInputContent();

  @override
  State<_BpInputContent> createState() => _BpInputContentState();
}

class _BpInputContentState extends State<_BpInputContent> {
  String _systolic = ''; // 수축기 혈압
  String _diastolic = ''; // 이완기 혈압
  String _pulse = ''; // 맥박
  String _note = '';  // 메모 텍스트 상태 관리를 위한 변수
  final TextEditingController _memoController = TextEditingController(); // 컨트롤러 추가



  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return Container(
      width: 375,
      height: 812,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          // 닫기, 제목, 저장 - 저장 버튼에 onPressed 추가
          BpInputTop(
            onSavePressed: () async {
              debugPrint('수축기 혈압: $_systolic mmHg');
              debugPrint('이완기 혈압: $_diastolic mmHg');
              debugPrint('맥박: $_pulse bpm');

              final kioskApiclient = KioskApiClient();
              Future<ApiResponse> authKiosk = kioskApiclient.authKiosk(
                "MTA001",
              );

              TempBpStore.I.add(systolic: int.parse(_systolic), diastolic: int.parse(_diastolic), heartRate: int.parse(_pulse),note: _note);

              // 키오스크 키 발급
              authKiosk.then(
                (authKioskResponse) => {
                  // 사용자 토큰 발급
                  kioskApiclient
                      .authUser(
                        userid: "01068340136",
                        type: "PHONE",
                        token: authKioskResponse.resultData.token,
                      )
                      .then(
                        (authUserResponse) => {
                          // 혈압 데이터 보내기
                          kioskApiclient.setResult(
                            token: authKioskResponse.resultData.token,
                            measureId: authUserResponse.resultData.measureId,
                            systolic: _systolic,
                            diastolic: _diastolic,
                            pulse: _pulse,
                          ),
                        },
                      ),
                },
              );
              context.pop();
            },
          ),
          // 측정 시간, 측정 일자
          BpInputTime(),
          SizedBox(height: 18.h,),
          // 수축기
          BpInputMeasure(
            label: '수축기 혈압',
            hint: '120',
            unit: 'mmHg',
            onChanged: (value) => setState(() => _systolic = value),
          ),
          SizedBox(height: 12.h,),
          // 이완기
          BpInputMeasure(
            label: '이완기 혈압',
            hint: '80',
            unit: 'mmHg',
            onChanged: (value) => setState(() => _diastolic = value),
          ),
          SizedBox(height: 12.h,),

          // 맥박
          BpInputMeasure(
            label: '맥박',
            hint: '70',
            unit: 'bpm',
            onChanged: (value) => setState(() => _pulse = value),
          ),

          SizedBox(height: 12.h,),
          Container(
            width: 327.w,
            height: 171.h,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 42,
                      child: Text(
                        '메모',
                        style: TextStyle(
                          color: const Color(0xFF505050),
                          fontSize: 18,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.22,
                          letterSpacing: -0.45,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 235),
                      width: 50,
                      child: Text(
                        '${_note.length}/60',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: const Color(0xFF8C8C8C),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                          letterSpacing: -0.40,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 327.w,
                  height: 140.h,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.50,
                        color: const Color(0xFF505050),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: TextField(
                    maxLines: null, // null로 설정하여 여러 줄 입력 가능
                    maxLength: 60,
                    controller: _memoController,
                    style: const TextStyle(
                      color: Color(0xFF505050),
                      fontSize: 12,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 2,
                      letterSpacing: -0.30,
                    ),
                    decoration: InputDecoration(
                      hintText: '메모를 입력한 부분이 보입니다',
                      counterText: '',
                      hintStyle: TextStyle(
                        color: Color(0xFF8C8C8C),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 2,
                        letterSpacing: -0.30,
                      ),
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 14, top: 3),
                    ),
                    keyboardType: TextInputType.multiline, // 여러 줄 입력을 위한 키보드 타입
                    textInputAction: TextInputAction.newline, // 엔터키를 새 줄 추가로 변경
                    onChanged: (value) {
                      setState(() {
                        _note = value;
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}