import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BpInputTop extends StatelessWidget {
  final VoidCallback? onSavePressed; // 저장 버튼 콜백 추가

  const BpInputTop({super.key, this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: 375.w,
      height: 56.h,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 24),
            width: 327.h,
            height: 24.h,
            child: Row(
              children: [
                IconButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: SvgPicture.asset("assets/icon/close.svg", width: 24, height: 24,),
                ),
                Container(
                  margin: EdgeInsets.only(left: 106, right: 94),
                  child: Text(
                    '혈압입력',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF227EFF),
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.20,
                      letterSpacing: -0.50,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: onSavePressed, // 저장 버튼 클릭시 콜백 호출
                  child: Text(
                    '저장',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF227EFF),
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 1.20,
                      letterSpacing: -0.50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
