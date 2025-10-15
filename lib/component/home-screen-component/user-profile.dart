import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfileBar extends StatelessWidget {
  const UserProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      height: 54.h,
      width: 327.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 왼쪽: 프로필 + 이름
          SizedBox(
            height: 54.h,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 프로필 이미지
                SizedBox(
                  width: 54.h, // 정사각형이니 h 기준 사용
                  height: 54.h,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile/profile.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // 이름 + 드롭다운 아이콘
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 140.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          '노블이',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sp,
                            height: 1.6, // line-height multiplier
                          ),
                        ),
                      ),
                      SizedBox(width: 9.w),
                      SvgPicture.asset(
                        'assets/icon/downward.svg',
                        width: 14.w,
                        height: 6.78.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 가운데 여백을 반응형으로
          const Spacer(),

          // 오른쪽: 두 개의 아이콘 버튼
          _Icon24(
            asset: 'assets/icon/user-group.svg',
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
          _Icon24(
            asset: 'assets/icon/control.svg',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _Icon24 extends StatelessWidget {
  final String asset;
  final VoidCallback onPressed;
  const _Icon24({required this.asset, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24.w,
      height: 24.w,
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints.tightFor(
          width: 24.w,
          height: 24.w,
        ),
        onPressed: onPressed,
        icon: SvgPicture.asset(
          asset,
          width: 24.w,
          height: 24.w,
          // 색을 바꾸고 싶다면 color가 아니라 colorFilter 사용:
          // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
