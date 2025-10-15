import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



// 환영메시지, 기업회원 버튼
class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 14, horizontal: 24
      ),
      child: Container(
        width: 327.w,
        height: 42.h,
        child: Row(
          children: [
            Container(
              width: 190.w,
              height: 42.h,
              child: Text(
                "메디터치에 오신 걸 환영합니다. 스마트하게 건강 관리하세요!",
                softWrap: true,
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.3125, // 행간
                  letterSpacing: -0.4, // 자간
                ),
              ),
            ),

            Expanded(
              child: Container(
                width: 88.w,
                height: 24.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset("assets/icon/office.svg"),
                    Text(
                      '기업회원 전환',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 0.22,
                        letterSpacing: -0.50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
