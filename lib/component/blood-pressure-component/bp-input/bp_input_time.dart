import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bp_input_measure_time.dart';
import 'bp_input_calendar.dart';


class BpInputTime extends StatelessWidget {
  const BpInputTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 24, top: 15),
              width: 157.w,
              height: 22.h,
              child: Text(
                " 측정 일자",
                style: const TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff505050),
                  height: 1.22,
                  letterSpacing: -0.45,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 13, top: 15),
              width: 157.w,
              height: 22.h,
              child: Text(
                " 측정 시간",
                style: const TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff505050),
                  height: 1.22,
                  letterSpacing: -0.45,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 24, right: 11, top: 8),
              width: 158.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff505050), width: 0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: ExampleCalendarButton(), // 달력
            ),
            TimePickerBox(),
          ],
        )
      ],
    );
  }
}
