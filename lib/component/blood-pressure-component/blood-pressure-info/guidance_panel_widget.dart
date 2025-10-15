// lib/screen/bp/guidance_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel/model/BloodPressureRecord.dart';


class GuidancePanel extends StatelessWidget {
  const GuidancePanel({super.key, required this.bpRecord});
  final BpRecord bpRecord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        width: 327.w,
        height: 90.h,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFF3F3F3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 24, right: 23, top: 15, bottom: 12),
          width: 280.w,
          height: 63.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GuideTitleRow(),
              SizedBox(height:  15.h),
              _GuideLine(
                leading: "혈압은 ",
                highlight: "고혈압1기",
                trailing: " 입니다.",
              ),
            ],
          ),

        ),
      ),
    );
  }
}

class _GuideTitleRow extends StatelessWidget {
  const _GuideTitleRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      height: 24.h,
      child: Text.rich(
        TextSpan(
          children: [
            _t('정상 혈압 범위는 ', bold: true),
            _t('120/80', color: Color(0xFF227EFF), bold: true),
            _t(' ', bold: true),
            _t('mmHg'),
            _t(' 미만입니다.', bold: true),
          ],
        ),
      ),
    );
  }

  static TextSpan _t(
    String text, {
    Color color = const Color(0xFF505050),
    bool bold = false,
  }) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w600,
        height: 1.50,
        letterSpacing: -0.40,
      ),
    );
  }
}

class _GuideLine extends StatelessWidget {
  const _GuideLine({
    required this.leading,
    required this.highlight,
    required this.trailing,
  });

  final String leading;
  final String highlight;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      height: 24.h,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: leading,
              style: TextStyle(
                color: const Color(0xFF505050),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 1.50,
                letterSpacing: -0.40,
              ),
            ),
            const TextSpan(
              text: '',
              style: TextStyle(
                color: const Color(0xFF616161),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 1.50,
                letterSpacing: -0.40,
              ),
            ),
            TextSpan(
              text: highlight,
              style: const TextStyle(
                color: Color(0xFFE5621C),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 1.5,
                letterSpacing: -0.4,
              ),
            ),
            TextSpan(
              text: trailing,
              style: TextStyle(
                color: const Color(0xFF505050),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 1.50,
                letterSpacing: -0.40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
