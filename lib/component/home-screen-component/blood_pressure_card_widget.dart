// lib/component/home-screen/blood_pressure_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BloodPressureCard extends StatelessWidget {
  const BloodPressureCard({
    super.key,
    required this.dateText,
    required this.statusText,
    required this.systolicText,
    required this.diastolicText,
    required this.pulseText,
    required this.systolicDiffText,
    required this.diastolicDiffText,
    required this.pulseDiffText,
    required this.onPressed,
  });

  final String dateText;           // 예: 2025.08.15
  final String statusText;         // 예: 고혈압1기
  final String systolicText;       // 예: 148
  final String diastolicText;      // 예: 88
  final String pulseText;          // 예: 70
  final String systolicDiffText;   // 예: 6.0 mmHg
  final String diastolicDiffText;  // 예: 6.0 mmHg
  final String pulseDiffText;      // 예: 6.0 bpm
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 327.w,
      height: 115.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(4, 4),
            spreadRadius: 0,
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: BorderSide.none,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          children: [
            // 혈압, 고혈압1기, 날짜
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 12, top: 12),
                      width: 303.w,
                      height: 32.h,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 110.w,
                            height: 32.h,
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 16,
                                            child: Image.asset(
                                              "assets/icon/heart-blood.png",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      child: const Text(
                                        '혈압',
                                        style: TextStyle(
                                          color: Color(0xFF111111),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w700,
                                          height: 2,
                                          letterSpacing: -0.40,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const ShapeDecoration(
                                        color: Color(0xFFC7503D),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                    Container(
                                      width: 50.w,
                                      height: 15.h,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFFEEAE2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        // spacing: 10,  // 원본 유지 필요시 그대로 두세요 (환경에 따라 제거)
                                        children: [
                                          Text(
                                            statusText,
                                            style: const TextStyle(
                                              color: Color(0xFFE5621C),
                                              fontSize: 10,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                              height: 0.60,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 103),
                            width: 90,
                            height: 10,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // spacing: 10,
                              children: [
                                Text(
                                  dateText,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Color(0xFF505050),
                                    fontSize: 10,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 0.60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // 혈압
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 22, top: 3),
                  width: 283.w,
                  height: 20.h,
                  child: Row(
                    children: const [
                      // 수축기 혈압
                      SizedBox(
                        width: 60,
                        height: 20,
                        child: Center(
                          child: Text(
                            '수축기혈압',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF505050),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 0.50,
                            ),
                          ),
                        ),
                      ),
                      // 이완기 혈압
                      SizedBox(width: 52),
                      SizedBox(
                        width: 60,
                        height: 20,
                        child: Center(
                          child: Text(
                            '이완기혈압',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF505050),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 0.50,
                            ),
                          ),
                        ),
                      ),
                      // 맥박
                      SizedBox(width: 51),
                      SizedBox(
                        width: 60,
                        height: 20,
                        child: Center(
                          child: Text(
                            '맥박',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF505050),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 0.50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 수치 표현
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 14, top: 4),
                  width: 303.w,
                  height: 25.h,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80.w,
                        height: 25.h,
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: systolicText,
                                style: const TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 1.10,
                                  letterSpacing: -0.50,
                                ),
                              ),
                              const TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  height: 1.83,
                                  letterSpacing: -0.30,
                                ),
                              ),
                              const TextSpan(
                                text: 'mmHg',
                                style: TextStyle(
                                  color: Color(0xFF505050),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.57,
                                  letterSpacing: -0.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 32.w),
                      SizedBox(
                        width: 80.w,
                        height: 25.h,
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: diastolicText,
                                style: const TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 1.10,
                                  letterSpacing: -0.50,
                                ),
                              ),
                              const TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  height: 1.83,
                                  letterSpacing: -0.30,
                                ),
                              ),
                              const TextSpan(
                                text: 'mmHg',
                                style: TextStyle(
                                  color: Color(0xFF505050),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.57,
                                  letterSpacing: -0.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 31.w),
                      SizedBox(
                        width: 80.w,
                        height: 25.h,
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: pulseText,
                                style: const TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 1.10,
                                  letterSpacing: -0.50,
                                ),
                              ),
                              const TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  height: 1.83,
                                  letterSpacing: -0.30,
                                ),
                              ),
                              const TextSpan(
                                text: 'bpm',
                                style: TextStyle(
                                  color: Color(0xFF505050),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.57,
                                  letterSpacing: -0.35,
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

            // 서로 비교한 혈압 표시
            Row(
              children: [
                Container(
                  width: 268.h,
                  margin: const EdgeInsets.only(left: 28, top: 4),
                  height: 8.h,
                  child: Row(
                    children: [
                      Container(
                        width: 48.h,
                        height: 8.h,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icon/polygon.svg",
                              width: 8,
                              height: 8,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              systolicDiffText,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Color(0xFFFF7F74),
                                fontSize: 8,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 0.75,
                                letterSpacing: -0.20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 48.h,
                        height: 8.h,
                        margin: const EdgeInsets.only(left: 64),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icon/polygon.svg",
                              width: 8,
                              height: 8,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              diastolicDiffText,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Color(0xFFFF7F74),
                                fontSize: 8,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 0.75,
                                letterSpacing: -0.20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 41.h,
                        height: 8.h,
                        margin: const EdgeInsets.only(left: 67),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icon/polygon.svg",
                              width: 8,
                              height: 8,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              pulseDiffText,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Color(0xFFFF7F74),
                                fontSize: 8,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 0.75,
                                letterSpacing: -0.20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
