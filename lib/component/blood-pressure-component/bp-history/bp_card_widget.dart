// lib/screen/bp/bp_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel/model/BloodPressureRecord.dart';

import 'package:intl/intl.dart';


class BpCard extends StatelessWidget {
  BpCard({
    super.key,
    this.stage = '고혈압1기',
    this.sourceText = '블루투스 측정',
    this.stageColor = const Color(0xFFE5621C),
    required this.bpRecord,
  });

  final BpRecord bpRecord;
  final String stage;
  final String sourceText;
  final Color stageColor;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 150.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadows: [
          BoxShadow(
            color: Color(0x28000000),
            blurRadius: 2,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // 좌측
              Container(
                margin: EdgeInsets.only(left: 12, top: 12, bottom: 12),
                width: 120.w,
                height: 82.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.w,
                      height: 24.h,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        stage,
                        style: TextStyle(
                          color: const Color(0xFFE5621C),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.50,
                          letterSpacing: -0.40,
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 120.w,
                            height: 25.h,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${bpRecord.systolic} / ${bpRecord.systolic}',
                                    style: TextStyle(
                                      color: const Color(0xFF111111),
                                      fontSize: 16,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      height: 1.38,
                                      letterSpacing: -0.40,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                      color: const Color(0xFF111111),
                                      fontSize: 12,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      height: 1.83,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'mmHg',
                                    style: TextStyle(
                                      color: const Color(0xFF505050),
                                      fontSize: 12,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.83,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                      color: const Color(0xFF111111),
                                      fontSize: 12,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.83,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 120.w,
                            height: 25.h,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${bpRecord.heartRate}',
                                    style: TextStyle(
                                      color: const Color(0xFF111111),
                                      fontSize: 16,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      height: 1.38,
                                      letterSpacing: -0.40,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                      color: const Color(0xFF111111),
                                      fontSize: 12,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      height: 1.83,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'bpm',
                                    style: TextStyle(
                                      color: const Color(0xFF505050),
                                      fontSize: 12,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.83,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                      color: const Color(0xFF111111),
                                      fontSize: 12,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.83,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 우측
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 12,
                      left: 93,
                      right: 12,
                      bottom: 24,
                    ),
                    width: 90.w,
                    height: 8.h,
                    child: Text(
                      DateFormat('yyyy.MM.dd hh:mm').format(bpRecord.measuredAt),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: const Color(0xFF505050),
                        fontSize: 10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 0.60,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 103, right: 17, bottom: 12),
                    width: 75.w,
                    height: 48.h,
                    child: Column(
                      children: [
                        // 측정장소 입력
                        Container(
                          width: 75.w,
                          height: 24.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 6),
                                width: 16,
                                height: 16,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFFC0CC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Container(
                                  width: 6,
                                  height: 9,
                                  margin: EdgeInsets.only(left: 5, right: 5, top: 4, bottom: 3),
                                  child: SvgPicture.asset(
                                    "assets/icon/location.svg",
                                  ),
                                ),
                              ),
                              Text(
                                '측정장소 입력',
                                style: TextStyle(
                                  color: const Color(0xFF505050),
                                  fontSize: 10,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 2.40,
                                  letterSpacing: -0.25,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 블루투스 측정
                        if(bpRecord.source == "블루투스")
                          Container(
                          width: 75,
                          height: 24,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 6),
                                width: 16,
                                height: 16,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF227EFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 2,
                                    vertical: 2,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icon/round-bluetooth.svg",
                                  ),
                                ),
                              ),
                              Text(
                                '블루투스 측정',
                                style: TextStyle(
                                  color: const Color(0xFF505050),
                                  fontSize: 10,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 2.40,
                                  letterSpacing: -0.25,
                                ),
                              ),
                            ],
                          ),
                        )
                        else
                          Container(
                            width: 75,
                            height: 24,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 6),
                                  width: 16,
                                  height: 16,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF505050),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 2,
                                      vertical: 2,
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/icon/pen-bold.svg",
                                    ),
                                  ),
                                ),
                                Text(
                                  '수기정보 입력',
                                  style: TextStyle(
                                    color: const Color(0xFF505050),
                                    fontSize: 10,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 2.40,
                                    letterSpacing: -0.25,
                                  ),
                                ),
                              ],
                            ),
                          )

                      ],
                    ),
                  ),
                ],
              ),

              // 메모를 입력한 부분이 보입니다.

            ],
          ),
          Container(
            width: 303,
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
            decoration: ShapeDecoration(
              color: const Color(0xFFF3F3F3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                SizedBox(
                  width: 275, // ScreenUtil을 쓰신다면 275.w로 변경 가능
                  child: TextField(
                    controller: TextEditingController(text: bpRecord.note),
                    maxLines: 1, // 여러 줄 입력을 원하면 아래 참고
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
                      hintStyle: const TextStyle(
                        color: Color(0xFF8C8C8C),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 2,
                        letterSpacing: -0.30,
                      ),
                      isDense: true,
                      border: InputBorder.none,       // 테두리 없애기
                      contentPadding: EdgeInsets.zero // 패딩 제거로 기존 높이감 유지
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}