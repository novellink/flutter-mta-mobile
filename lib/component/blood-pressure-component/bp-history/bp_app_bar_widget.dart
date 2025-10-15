// lib/screen/bp/bp_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BpAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BpAppBar({
    super.key,
    required this.onBack,
    required this.onOpenList,
  });

  final VoidCallback onBack;
  final VoidCallback onOpenList;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      color: Color(0xff227Eff),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ← 아이콘 (24x24)
          SizedBox(
            width: 24,
            height: 24,
            child: InkWell(
              onTap: onBack,
              child: SvgPicture.asset("assets/icon/back.svg")
            ),
          ),

          // 제목
          Container(
            margin: EdgeInsets.only(left: 117, right: 96),
            child: Text(
              '혈압',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard',
                height: 0.06,
                letterSpacing: -0.50,
              ),
            ),
          ),

          // '목록' 버튼 (우측)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onOpenList,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: SvgPicture.asset("assets/icon/menu.svg")
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}