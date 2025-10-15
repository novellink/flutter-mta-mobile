import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatelessWidget {
  final String location;                     // 'home' | 'chart' | 'calendar' | 'setting'
  final ValueChanged<String>? onChanged;     // 탭 변경 콜백 (선택)

  const BottomBar({
    super.key,
    required this.location,
    this.onChanged,
  });

  static const _blue = Color(0xFF227EFF);
  static const _gray = Color(0xFF8C8C8C);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 44.92, right: 42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(id: 'home',     asset: 'assets/icon/home.svg'),
          _navItem(id: 'chart',    asset: 'assets/icon/chart.svg'),
          _navItem(id: 'calendar', asset: 'assets/icon/calendar.svg'),
          _navItem(id: 'setting',  asset: 'assets/icon/setting.svg'),
        ],
      ),
    );
  }

  Widget _navItem({required String id, required String asset}) {
    final bool active = (location == id);

    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () => onChanged?.call(id),
      child: Container(
        width: 56,                     // 터치/배경 영역
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffF9FAFB), // 선택 시 파란 배경
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Color(0xffF9FAFB), blurRadius: 12, offset: const Offset(0, 4))]
        ),
        child: SvgPicture.asset(
          asset,
          width: 28,
          height: 28,
          colorFilter: ColorFilter.mode(active ? _blue : _gray, BlendMode.srcIn), // 아이콘 색
        ),
      ),
    );
  }
}
