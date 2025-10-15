// dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_svg/svg.dart';

import 'calendar_icon_button_widget.dart';

class DateBarWithCalendarButton extends StatelessWidget {
  const DateBarWithCalendarButton({
    super.key,
    required this.dateText,
    this.initialDate,
    this.onDatePicked,
    this.onAddPressed,
    this.events,
    this.color = const Color(0xFF0B1E38),
  });

  final String dateText;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDatePicked;
  final VoidCallback? onAddPressed;
  final List<NeatCleanCalendarEvent>? events;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 133),
        Text(
          dateText,
          style: const TextStyle(
            color: Color(0xFF0D1B34),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Pretendard',
            height: 1.2,
            letterSpacing: -0.40,
          ),
        ),
        SizedBox(width: 6.w),
        CalendarIconButton(
          initialDate: initialDate,
          onDatePicked: onDatePicked,
        ),
        const Spacer(),
        SizedBox(
          width: 32,
          height: 32,
          child: ElevatedButton(
            onPressed: onAddPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              // backgroundColor: const Color(0xFF227EFF),
              shadowColor: Colors.black.withOpacity(0.15),
              elevation: 4,
            ),
            child: SvgPicture.asset("assets/icon/plus.svg"),
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
