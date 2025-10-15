import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'CalendarBottomSheetWidget.dart'; // SvgPicture 사용

class CalendarIconButton extends StatelessWidget {
  const CalendarIconButton({
    super.key,
    this.onPressed,
    this.initialDate,
    this.onDatePicked,
    this.color = const Color(0xFF0B1E38),
    this.size = 24,
  });

  final VoidCallback? onPressed;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDatePicked;
  final Color color;
  final double size;

  void _openCalendarDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black38,
      isDismissible: false, // 창 닫히지 않게
      enableDrag: false,    // 드래그로도 닫히지 않게
      builder: (ctx) {
        return CalendarBottomSheet(
          initialDate: initialDate,
          onPicked: (d) => onDatePicked?.call(d), // 선택만 전달, 닫지 않음
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () => _openCalendarDialog(context),
      child: SizedBox(
        child: Center(
          child: SvgPicture.asset("assets/icon/calendar.svg"),
        ),
      ),
    );
  }
}
