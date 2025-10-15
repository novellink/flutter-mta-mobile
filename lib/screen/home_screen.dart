import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ← 추가: 상태바 아이콘 색
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:novel/component/common/bottom-bar.dart';
import 'package:novel/iPhone_top.dart';
import 'package:novel/model/TempBpStore.dart';

import 'package:intl/intl.dart';


import '../component/home-screen-component/blood_pressure_card_widget.dart';
import '../component/home-screen-component/notice.dart';
import '../component/home-screen-component/user-profile.dart';
import '../component/home-screen-component/welcome-banner.dart';
import '../model/BloodPressureRecord.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BpRecord> items =  TempBpStore.I.items;

  @override
  Widget build(BuildContext context) {
    BpRecord firstItem = items.first;
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      body: Column(
        children: [
          // 파란 배경을 노치까지 칠하고, 내용만 SafeArea로 내리기
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light, // 상태바 아이콘 밝게(흰색)
            child: Container(
              width: double.infinity,
              color: const Color(0xFF227EFF),
              child: SafeArea(
                bottom: false, // 상단만 보호
                child: Column(
                  children: const [
                    UserProfileBar(),
                    WelcomeBanner(),
                  ],
                ),
              ),
            ),
          ),

          // 스크롤 영역
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const Notice(),
                BloodPressureCard(
                  dateText: DateFormat('yyyy.MM.dd hh:mm').format(firstItem.measuredAt),
                  statusText: '고혈압1기',
                  systolicText: '${firstItem.systolic}',
                  diastolicText: '${firstItem.diastolic}',
                  pulseText: '${firstItem.heartRate}',
                  systolicDiffText: '6 mmHg',
                  diastolicDiffText: '6 mmHg',
                  pulseDiffText: '6 bpm',
                  onPressed: () => context.go('/blood-pressure/info'),
                ),
              ],
            ),
          ),

          // 하단 바
          const BottomBar(location: 'home'),
          SizedBox(height: 34.h),
        ],
      ),
    );
  }
}
