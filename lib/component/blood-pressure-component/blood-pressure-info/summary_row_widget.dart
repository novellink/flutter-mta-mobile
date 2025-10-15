// lib/screen/bp/summary_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel/component/blood-pressure-component/blood-pressure-info/range_segment_bar.dart';
import 'package:novel/component/ui_decorations.dart';
import 'package:novel/model/BloodPressureRecord.dart';
import 'package:novel/primary-color.dart';

class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key, required this.bpRecord});

  final BpRecord bpRecord;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _HypertensionStatusCard(bpRecord),
          const SizedBox(width: 15),
          _HeartRateCard(bpRecord: bpRecord),
        ],
      ),
    );
  }
}

class _HypertensionStatusCard extends StatelessWidget {
  const _HypertensionStatusCard(BpRecord bpRecord);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156.w,
      height: 125.h,
      decoration: grayBoxDecoration(),
      child: Container(
        margin: EdgeInsets.only(
          left: 23, right: 23, top: 30, bottom: 31
        ),
        width: 110.w,
        height: 64.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 110.w,
              margin: EdgeInsets.only(bottom: 12),
              child: Text(
                "고혈압 1기",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFE5621C),
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 1.60,
                  letterSpacing: -0.50,
                ),
              ),
            ),
            Container(
              width: 110.w,
              height: 20.h,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 2,
                    offset: Offset(1, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: RangeSegmentBar(
                colors: const [
                  Color(0xFF56C271), // Green
                  Color(0xFFF2D64B), // Yellow
                  Color(0xFFE5621C), // Deep Orange
                  Color(0xFF9E2C6A), // Magenta
                ],
                height: 14,
                indicator: 0.60, // 위치 이동
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class _HeartRateCard extends StatelessWidget {
  final BpRecord bpRecord;

  const _HeartRateCard({required this.bpRecord});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156.w,
      height: 125.h,
      decoration: grayBoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Stack(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: heartBoxDecoration(color: PrimaryColor.pink),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 7,
                ),
                width: 24,
                height: 24,
                child: SvgPicture.asset("assets/icon/heart-red.svg"),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _BpmText(value: bpRecord.heartRate),
                  const Text(
                    "맥박",
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff626262),
                      height: 24 / 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BpmText extends StatelessWidget {
  const _BpmText({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$value',
            style: TextStyle(
              color: const Color(0xFF111111),
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 1.10,
              letterSpacing: -0.50,
            ),
          ),
          TextSpan(
            text: ' ',
            style: TextStyle(
              color: const Color(0xFF0D1B34),
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              height: 1.10,
              letterSpacing: -0.50,
            ),
          ),
          TextSpan(
            text: 'bpm',
            style: TextStyle(
              color: const Color(0xFF505050),
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              height: 1.57,
              letterSpacing: -0.35,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.right,
    );
  }
}
