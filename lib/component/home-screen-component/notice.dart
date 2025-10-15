import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Notice extends StatelessWidget {
  const Notice({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 24, right: 24),
      child: Container(
        width: 327,
        height: 90,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.5,
              color: const Color(0xFF227EFF),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19227EFF),
              blurRadius: 4,
              offset: Offset(4, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 14),
          child: SizedBox(
            width: 303.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 11),
                  child: Text(
                    '공지사항',
                    style: const TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.86,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Text(
                  '근로자의 날 오픈기념으로 이벤트 진행합니다!',
                  style: TextStyle(
                    color: const Color(0xFF227EFF),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.83,
                    letterSpacing: -0.50,
                  ),
                )
              ],
            ),
          ),
        ),
      )
      ,
    );
  }
}
