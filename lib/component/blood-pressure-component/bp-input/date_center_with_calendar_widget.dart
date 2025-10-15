import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SvgPicture 사용을 위한 import
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// CalendarBottomSheet가 선언된 파일 import
import 'package:novel/model/BloodPressureRecord.dart';
import 'package:novel/model/TempBpStore.dart'; // DateCenterWithCalendar 사용을 위해 추가

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
    // 닫히지 않으므로 await하지 않습니다.
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
        child: Center(child: SvgPicture.asset("assets/icon/calendar.svg")),
      ),
    );
  }
}

class CalendarBottomSheet extends StatefulWidget {
  const CalendarBottomSheet({
    required this.onPicked,
    this.initialDate,
    super.key,
  });

  final DateTime? initialDate;
  final ValueChanged<DateTime> onPicked;

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  // todo 날짜에 이벤트 추가 나중엔 API 고려
  List<NeatCleanCalendarEvent> _eventList = [];

  late DateTime _selectedDate;

  static const _headerHeight = 56.0;
  static const _dividerHeight = 1.0;

  @override
  void initState() {
    _loadEvents();
    super.initState();
    final init = widget.initialDate ?? DateTime.now();
    _selectedDate = DateTime(init.year, init.month, init.day);
  }

  void _selectDate(DateTime d) {
    final onlyDate = DateTime(d.year, d.month, d.day);
    setState(() => _selectedDate = onlyDate);
    widget.onPicked(onlyDate); // 외부에 알림 (창은 닫지 않음)
  }

  Future<void> _loadEvents() async {
    final fetchAll = await TempBpStore.I.fetchAll();
    final events = fetchAll
        .map(
          (bpRecord) => NeatCleanCalendarEvent(
            '고혈압 1기',
            description:
                '${bpRecord.systolic} / ${bpRecord.diastolic}mmHg${bpRecord.heartRate}',
            startTime: bpRecord.measuredAt,
            endTime: bpRecord.measuredAt,
            color: Colors.orange,
            isMultiDay: false,
            metadata: {"type": bpRecord.source},
          ),
        )
        .toList();

    if (mounted) {
      // 위젯이 여전히 존재하는지 확인
      setState(() {
        _eventList = events;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // 뒤로가기 닫힘 방지
      child: DraggableScrollableSheet(
        expand: true,
        initialChildSize: 0.92,
        minChildSize: 0.92,
        maxChildSize: 0.92,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, -6),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final sheetHeight = constraints.maxHeight;
                final calendarHeight =
                    sheetHeight - _headerHeight - _dividerHeight;

                return ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    // CalendarModalHeader 대체: 동일 스타일 인라인
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              // 스타일 유지: X 버튼 동작 막음 (창 닫히지 않게)
                              context.pop();
                            },
                            icon: Image.asset(
                              'assets/images/close.png',
                              width: 24,
                              height: 24,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.close, size: 24),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              final now = DateTime.now();
                              _selectDate(
                                DateTime(now.year, now.month, now.day),
                              ); // 오늘 선택
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                            ),
                            child: const Text(
                              '오늘',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF227EFF),
                                fontSize: 20,
                                fontFamily: 'Pretendard',
                                height: 0.06,
                                letterSpacing: -0.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: _dividerHeight),

                    SizedBox(
                      height: calendarHeight,
                      child: Calendar(

                        expandableDateFormat: 'MMMM yyyy',

                        // 년월 표시 스타일
                        displayMonthTextStyle: const TextStyle(
                          color: const Color(0xFF111111),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: 1.60,
                        ),


                        // 캘린더 상단에 나오는 요일 커스텀 마이징
                        dayOfWeekStyle: TextStyle(
                          color: const Color(0xFF101828),
                          fontSize: 10,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: 1.60,
                        ),

                        selectedColor: Color(0xff227EFF),

                        // 기본 색상 및 스타일
                        eventDoneColor: Colors.amber,
                        bottomBarColor: Colors.white,

                        todayButtonText: "오늘",
                        showEventListViewIcon: false,
                        weekDays: const ['일', '월', '화', '수', '목', '금', '토'],
                        eventListBuilder:
                            (
                              BuildContext context,
                              List<NeatCleanCalendarEvent> calendarEvent,
                            ) {
                              return Column(
                                children: [
                                  Container(
                                    width: 375.w,
                                    height: 24.h,
                                    color: const Color(0xff227EFF),
                                    child: SizedBox(
                                      width: 311.w,
                                      height: 22.h,
                                      child: Text(
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                        "${_selectedDate.year}년 ${_selectedDate.month}월 ${_selectedDate.day}일",
                                      ),
                                    ),
                                  ),
                                  (calendarEvent.isNotEmpty)
                                      ? Container(
                                          height: 380.h,
                                          child: ListView.builder(
                                            itemCount: calendarEvent.length,
                                            itemBuilder: (context, index) {
                                              final event =
                                                  calendarEvent[index];
                                              return Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: 15,
                                                    ),
                                                    width: 375.w,
                                                    height: 142.h,
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Color(
                                                            0xFFF3F3F3,
                                                          ),
                                                        ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        /// 주황색 세로줄
                                                        Container(
                                                          width: 10.w,
                                                          height: 142.h,
                                                          margin:
                                                              const EdgeInsets.only(
                                                                left: 5,
                                                                right: 6,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            color: Color(
                                                              0xFFE5621C,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  999,
                                                                ),
                                                          ),
                                                        ),

                                                        /// 오른쪽 컨텐츠
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              /// 상단: 고혈압1기 + 시간
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: 80,
                                                                    height: 20,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      spacing:
                                                                          10,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              80,
                                                                          height:
                                                                              20,
                                                                          child: Text(
                                                                            '고혈압1기',
                                                                            style: TextStyle(
                                                                              color: const Color(
                                                                                0xFFE5621C,
                                                                              ),
                                                                              fontSize: 14,
                                                                              fontFamily: 'Pretendard',
                                                                              fontWeight: FontWeight.w600,
                                                                              height: 1.71,
                                                                              letterSpacing: -0.35,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin:
                                                                        EdgeInsets.only(
                                                                          top:
                                                                              12,
                                                                          right:
                                                                              21,
                                                                        ),
                                                                    width: 90,
                                                                    height: 12,
                                                                    child: Text(
                                                                      '${DateFormat('HH:mm').format(event.startTime).padLeft(2, '0')}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style: TextStyle(
                                                                        color: const Color(
                                                                          0xFF505050,
                                                                        ),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Pretendard',
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        height:
                                                                            0.50,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              const SizedBox(
                                                                height: 8,
                                                              ),

                                                              /// 중간: 혈압/맥박 + 측정장소/수기정보
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  /// 왼쪽 측정값
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            90,
                                                                        child: Text.rich(
                                                                          TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '${event.description.split("mmHg")[0]}',
                                                                                style: TextStyle(
                                                                                  color: const Color(
                                                                                    0xFF111111,
                                                                                  ),
                                                                                  fontSize: 14,
                                                                                  fontFamily: 'Pretendard',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  height: 1.57,
                                                                                  letterSpacing: -0.35,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: ' ',
                                                                                style: TextStyle(
                                                                                  color: const Color(
                                                                                    0xFF111111,
                                                                                  ),
                                                                                  fontSize: 12,
                                                                                  fontFamily: 'Pretendard',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  height: 1.83,
                                                                                  letterSpacing: -0.30,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: 'mmHg',
                                                                                style: TextStyle(
                                                                                  color: const Color(
                                                                                    0xFF505050,
                                                                                  ),
                                                                                  fontSize: 10,
                                                                                  fontFamily: 'Pretendard',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  height: 2.20,
                                                                                  letterSpacing: -0.25,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: ' ',
                                                                                style: TextStyle(
                                                                                  color: const Color(
                                                                                    0xFF8C8C8C,
                                                                                  ),
                                                                                  fontSize: 10,
                                                                                  fontFamily: 'Pretendard',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  height: 2.20,
                                                                                  letterSpacing: -0.25,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            3.h,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            100,
                                                                        child: Text.rich(
                                                                          TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '${event.description.split("mmHg")[1]}',
                                                                                style: TextStyle(
                                                                                  color: const Color(
                                                                                    0xFF111111,
                                                                                  ),
                                                                                  fontSize: 14,
                                                                                  fontFamily: 'Pretendard',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  height: 1.57,
                                                                                  letterSpacing: -0.35,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: ' ',
                                                                                style: TextStyle(
                                                                                  color: const Color(
                                                                                    0xFF111111,
                                                                                  ),
                                                                                  fontSize: 12,
                                                                                  fontFamily: 'Pretendard',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  height: 1.83,
                                                                                  letterSpacing: -0.30,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: 'bpm ',
                                                                                style: TextStyle(
                                                                                  color: const Color(
                                                                                    0xFF505050,
                                                                                  ),
                                                                                  fontSize: 10,
                                                                                  fontFamily: 'Pretendard',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  height: 2.20,
                                                                                  letterSpacing: -0.25,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),

                                                                  const Spacer(),

                                                                  /// 오른쪽 버튼 2개 (측정장소, 수기정보)
                                                                  Container(
                                                                    width: 75.w,
                                                                    height:
                                                                        48.h,
                                                                    margin:
                                                                        EdgeInsets.only(
                                                                          right:
                                                                              21,
                                                                        ),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              75,
                                                                          height:
                                                                              24,
                                                                          child: Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              /// 네모 박스
                                                                              Container(
                                                                                width: 16,
                                                                                height: 16,
                                                                                margin: const EdgeInsets.only(
                                                                                  right: 6,
                                                                                ),
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(
                                                                                    0xFFFFC0CC,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    4,
                                                                                  ),
                                                                                ),
                                                                                child: Container(
                                                                                  width: 16.w,
                                                                                  height: 16.h,
                                                                                  child: Container(
                                                                                    margin: EdgeInsets.only(
                                                                                      left: 5,
                                                                                      right: 5,
                                                                                      top: 4,
                                                                                      bottom: 3,
                                                                                    ),
                                                                                    child: SvgPicture.asset(
                                                                                      width: 6.w,
                                                                                      height: 9.h,
                                                                                      "assets/icon/location.svg",
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              /// 텍스트
                                                                              const Text(
                                                                                '측정장소 입력',
                                                                                style: TextStyle(
                                                                                  color: Color(
                                                                                    0xFF505050,
                                                                                  ),
                                                                                  fontSize: 10,
                                                                                  fontFamily: 'Pretendard',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  height: 2.40,
                                                                                  letterSpacing: -0.25,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            if (event.metadata.getType() ==
                                                                                EventTypes.edit)
                                                                              Row(
                                                                                children: [
                                                                                  // 수기정보 입력 type
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(
                                                                                      right: 6,
                                                                                    ),
                                                                                    width: 16.w,
                                                                                    height: 16.h,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(
                                                                                        0xFF505050,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(
                                                                                        4,
                                                                                      ),
                                                                                    ),
                                                                                    child: Container(
                                                                                      margin: EdgeInsets.symmetric(
                                                                                        vertical: 4,
                                                                                        horizontal: 4,
                                                                                      ),
                                                                                      child: SvgPicture.asset(
                                                                                        "assets/icon/pen-bold.svg",
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    '수기정보 입력',
                                                                                    textAlign: TextAlign.right,
                                                                                    style: TextStyle(
                                                                                      color: const Color(
                                                                                        0xFF505050,
                                                                                      ),
                                                                                      fontSize: 10,
                                                                                      fontFamily: 'Pretendard',
                                                                                      fontWeight: FontWeight.w400,
                                                                                      height: 2.40,
                                                                                      letterSpacing: -0.25,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            else if (event.metadata.getType() ==
                                                                                EventTypes.bluetooth)
                                                                              Row(
                                                                                children: [
                                                                                  // 수기정보 입력 type
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(
                                                                                      right: 6,
                                                                                    ),
                                                                                    width: 16.w,
                                                                                    height: 16.h,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(
                                                                                        0xff227EFF,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(
                                                                                        4,
                                                                                      ),
                                                                                    ),
                                                                                    child: Container(
                                                                                      width: 12,
                                                                                      height: 12,
                                                                                      margin: EdgeInsets.only(
                                                                                        left: 3,
                                                                                        right: 3.06,
                                                                                        top: 1,
                                                                                        bottom: 1.41,
                                                                                      ),
                                                                                      child: SvgPicture.asset(
                                                                                        "assets/icon/round-bluetooth.svg",
                                                                                        width: 5.94,
                                                                                        height: 9.59,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    '블루투스 측정',
                                                                                    textAlign: TextAlign.right,
                                                                                    style: TextStyle(
                                                                                      color: const Color(
                                                                                        0xFF505050,
                                                                                      ),
                                                                                      fontSize: 10,
                                                                                      fontFamily: 'Pretendard',
                                                                                      fontWeight: FontWeight.w400,
                                                                                      height: 2.40,
                                                                                      letterSpacing: -0.25,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              const SizedBox(
                                                                height: 12,
                                                              ),

                                                              /// 하단 메모
                                                              Container(
                                                                width: 333.w,
                                                                height: 30.h,
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          14,
                                                                      vertical:
                                                                          6,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8,
                                                                      ),
                                                                ),
                                                                child: TextField(
                                                                  decoration: InputDecoration(
                                                                    hintText:
                                                                        "메모를 입력한 부분이 보입니다.",
                                                                    hintStyle: TextStyle(
                                                                      color: const Color(
                                                                        0xFF505050,
                                                                      ),
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'Pretendard',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      height: 2,
                                                                      letterSpacing:
                                                                          -0.30,
                                                                    ),
                                                                    // ⬅️ 힌트 텍스트
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        )
                                      : Container(),
                                ],
                              );
                            },
                        eventsList: _eventList,
                        showEvents: true,
                        isExpanded: true,
                        locale: 'ko_KR',
                        onDateSelected: (DateTime date) {
                          _selectDate(
                            date,
                          ); // 오늘 버튼/날짜 선택 시 상단 날짜와 콜백만 갱신(창은 닫히지 않음)
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class EventTypes {
  static const String edit = '수기입력';
  static const String bluetooth = '블루투스';
  static const String view = 'view';
  static const String none = 'none';
}

// 2. 확장 함수 사용
extension MapDataExtension on Map<String, dynamic>? {
  String? getType() {
    return this?['type']?.toString();
  }
}
