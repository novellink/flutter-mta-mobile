// dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

import '../bp-input/date_center_with_calendar_widget.dart';

class CalendarIconButton extends StatelessWidget {
  const CalendarIconButton({
    super.key,
    this.onPressed,
    this.initialDate,
    this.onDatePicked,
    this.eventsList,
    this.size = 24.0,
  });

  final VoidCallback? onPressed;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDatePicked;
  final List<NeatCleanCalendarEvent>? eventsList;
  final double size;

  void _openCalendarDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black38,
      isDismissible: false,
      enableDrag: false,
      builder: (ctx) {
        return CalendarBottomSheet(
          initialDate: initialDate,
          onPicked: (d) => onDatePicked?.call(d),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () => _openCalendarDialog(context),
      child: SizedBox(
        width: size + 8,
        height: size + 8,
        child: Center(
          child: SvgPicture.asset(
            "assets/icon/calendar.svg",
            width: size,
            height: size,
            placeholderBuilder: (_) => Icon(Icons.calendar_today, size: size),
            // 에셋 이슈 대비
            colorFilter: const ColorFilter.mode(Color(0xFF0B1E38), BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
