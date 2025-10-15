import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

import 'package:novel/component/common/bottom-bar.dart';
import 'package:novel/iPhone_top.dart';
import 'package:novel/model/TempBpStore.dart';
import 'package:novel/screen/bp_input_screen.dart';

import '../component/blood-pressure-component/bp-event-history/DateBarWithCalendarButton.dart';
import '../component/blood-pressure-component/blood-pressure-info/guidance_panel_widget.dart';
import '../component/blood-pressure-component/blood-pressure-info/pressure_monitoring_widget.dart';
import '../component/blood-pressure-component/blood-pressure-info/sliding_chart_widget.dart';
import '../component/blood-pressure-component/blood-pressure-info/summary_row_widget.dart';
import '../component/blood-pressure-component/bp-history/bp_app_bar_widget.dart';
import '../component/blood-pressure-component/bp-history/bp_log_sheet_widget.dart';
import '../component/blood-pressure-component/bp-history/bp_segmented_switch.dart';
import '../model/BloodPressureRecord.dart';


// 예시 이벤트(필요 시 API 연동으로 교체)
final List<NeatCleanCalendarEvent> _eventList = [
  NeatCleanCalendarEvent(
    '고혈압 1기',
    description: '148 / 128 mmHg 70 bpm',
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1, 0, 0),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1, 0, 0),
    color: Colors.orange,
    isMultiDay: false,
    metadata: {"type": "edit"},
  ),
  NeatCleanCalendarEvent(
    '고혈압 1기',
    description: '148 / 128 mmHg 70 bpm',
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3, 10, 0),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3, 10, 0),
    color: Colors.orange,
    isMultiDay: false,
  ),
];

class BloodPressureInfo extends StatefulWidget {
  const BloodPressureInfo({super.key});

  @override
  State<BloodPressureInfo> createState() => _BloodPressureInfoState();
}

class _BloodPressureInfoState extends State<BloodPressureInfo> {
  DateTime _currentDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    List<BpRecord> bpRecords =  TempBpStore.I.items;
    BpRecord bpRecordsFirst = bpRecords.first;


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IphoneTop(),
          BpAppBar(
            onBack: () => context.go('/'),
            onOpenList: () => showBpLogSheet(context, bpRecords),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: DateBarWithCalendarButton(
                      dateText: DateFormat('yyyy.MM.dd').format(_currentDate),
                      initialDate: _currentDate,
                      events: _eventList,
                      onDatePicked: (d) {
                        setState(() {
                          _currentDate = DateTime(d.year, d.month, d.day);
                        });
                      },
                      onAddPressed: () => showBpInputModal(context),
                    ),
                  ),
                  SummaryRow(bpRecord: bpRecordsFirst),
                  PressureRow(bpRecord: bpRecordsFirst),
                  // GraphSection(),
                  SlidingChart(),
                  Container(
                    width: double.infinity,
                    height: 60.h,
                    color: Colors.white,
                    child: BpSegmentedSwitch(
                      initialIndex: 0,
                      onChanged: (i) {
                        // TODO: i 값에 따라 목록/그래프 갱신
                      },
                    ),
                  ),
                  GuidancePanel(bpRecord: bpRecordsFirst),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 375.w,
                    height: 250.h,
                    color: const Color(0xFFF9FAFB),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24 ,top: 6, bottom: 7),
                      child: SizedBox(
                        width: 327.w,
                        height: 250.h,
                        child: Image.asset("assets/images/mmhg-graph.png"),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
          Container(color: Colors.white, child: const BottomBar(location: 'chart')),
          Container(color: Colors.white, height: 24),
        ],
      ),
    );
  }
}