import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class Event {
  final String title;
  final String description;
  final int systolic;    // 수축기 혈압
  final int diastolic;   // 이완기 혈압
  final int pulse;       // 맥박
  final DateTime time;
  final Color color;

  Event({
    required this.title,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.time,
    this.color = Colors.blue,
    String? description,
  }) : description = description ?? '$systolic / $diastolic mmHg $pulse bpm';
}

class MyCalendarWidget extends StatefulWidget {
  const MyCalendarWidget({super.key});

  @override
  State<MyCalendarWidget> createState() => _MyCalendarWidgetState();
}

class _MyCalendarWidgetState extends State<MyCalendarWidget> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  
  // 범위
  static final DateTime kFirstDay = DateTime.utc(2020, 1, 1);
  static final DateTime kLastDay = DateTime.utc(2035, 12, 31);

  // 이벤트 맵
  final Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    initializeDateFormatting('ko_KR', null);
    _loadSampleEvents();
  }

  void _loadSampleEvents() {
    // 샘플 이벤트 데이터
    final sampleEvents = [
      Event(
        title: '고혈압 1기',
        systolic: 148,
        diastolic: 128,
        pulse: 70,
        time: DateTime(2025, 9, 10),
        color: Colors.orange,
      ),
      Event(
        title: '정상혈압',
        systolic: 120,
        diastolic: 80,
        pulse: 72,
        time: DateTime(2025, 9, 8),
        color: Colors.green,
      ),
    ];

    // 이벤트를 날짜별로 맵에 저장
    for (final event in sampleEvents) {
      final day = DateTime(event.time.year, event.time.month, event.time.day);
      if (!_events.containsKey(day)) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar<Event>(
          locale: 'ko_KR',
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          
          eventLoader: _getEventsForDay,
          
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },

          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextFormatter: (date, locale) =>
                '${date.year}년 ${date.month}월',
          ),

          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
            todayDecoration: BoxDecoration(
              color: Color(0xFF227EFF),
              shape: BoxShape.circle
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.black87,
              shape: BoxShape.circle
            ),
            markerSize: 6.0,
            markerDecoration: BoxDecoration(
              color: Color(0xFF227EFF),
              shape: BoxShape.circle,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // 선택된 날짜의 이벤트 목록
        Expanded(
          child: ListView(
            children: [
              ..._getEventsForDay(_selectedDay ?? _focusedDay)
                  .map((event) => Card(
                    child: ListTile(
                      leading: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: event.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text(event.title),
                      subtitle: Text(event.description),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}