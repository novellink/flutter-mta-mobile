// lib/screen/bp/graph_section.dart
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ─────────────────────────────────────────────
/// 데이터 모델
/// ─────────────────────────────────────────────
class BPPoint {
  final DateTime date;
  final int systolic;   // 수축기
  final int diastolic;  // 이완기
  final int pulse;      // 맥박

  BPPoint({
    required this.date,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
  });
}

/// ─────────────────────────────────────────────
/// 그래프 섹션
/// ─────────────────────────────────────────────
class GraphSection extends StatefulWidget {
  const GraphSection({super.key});

  @override
  State<GraphSection> createState() => _GraphSectionState();
}

class _GraphSectionState extends State<GraphSection> {
  static const int kWindow = 7; // 화면에 항상 보여줄 X축 틱 수
  final List<BPPoint> _seriesData = [];
  ChartSeriesController? _bpRangeCtrl;
  ChartSeriesController? _pulseLineCtrl;

  @override
  void initState() {
    super.initState();
    _generateDummyData(); // 더미 100개
  }

  /// 더미 데이터 100개 (12시간 간격)
  void _generateDummyData() {
    final now = DateTime.now();
    final random = Random();
    for (int i = 0; i < 100; i++) {
      final date = now.subtract(Duration(hours: 12 * (100 - i)));
      final sys = 110 + random.nextInt(40);               // 110~149
      final dia = sys - (20 + random.nextInt(20));        // sys - (20~39)
      final pulse = 60 + random.nextInt(40);              // 60~99
      _seriesData.add(BPPoint(date: date, systolic: sys, diastolic: dia, pulse: pulse));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      height: 270.h,
      color: Colors.white,
      child: Column(
        children: [
          // ── 상단 범례
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0,1))],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLegendDot(const Color(0xFF87CEFA), '수축, 이완'),
                  const SizedBox(width: 12),
                  _buildLegendDot(const Color(0xFFFFC0CC), '맥박'),
                ],
              ),
            ),
          ),

          // ── 차트
          Expanded(
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              legend: const Legend(isVisible: false),

              // 트랙볼: builder만 사용(tooltipSettings 미사용)
              trackballBehavior: TrackballBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                lineType: TrackballLineType.vertical,
                tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                builder: (BuildContext context, TrackballDetails details) {
                  // groupAllPoints 모드에 안전한 인덱스 추출
                  final g = details.groupingModeInfo;
                  final list = g?.currentPointIndices;
                  final int? idx = (list != null && list.isNotEmpty)
                      ? list.first
                      : details.pointIndex;

                  if (idx == null || idx < 0 || idx >= _seriesData.length) {
                    return const SizedBox.shrink();
                  }
                  final p = _seriesData[idx];

                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(DateFormat('MM/dd HH:mm').format(p.date),
                            style: const TextStyle(color: Colors.white70, fontSize: 11)),
                        const SizedBox(height: 2),
                        const SizedBox(height: 2),
                        Text('수축기 혈압: ${p.systolic} mmHg',
                            style: const TextStyle(color: Colors.white)),
                        Text('이완기 혈압: ${p.diastolic} mmHg',
                            style: const TextStyle(color: Colors.white)),
                        Text('맥박: ${p.pulse} bpm',
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                },
              ),

              // X축: 카테고리형 시계열 + 항상 7틱
              primaryXAxis: DateTimeCategoryAxis(
                dateFormat: DateFormat('MM-dd\nHH:mm'),
                intervalType: DateTimeIntervalType.minutes,
                autoScrollingDelta: kWindow,              // ← 항상 7개 보이기
                autoScrollingMode: AutoScrollingMode.end,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                majorTickLines: const MajorTickLines(size: 0),
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(width: 0.5),
                labelStyle: const TextStyle(
                  color: Color(0xFF111111), fontSize: 10, height: 1.1, letterSpacing: -0.5, fontWeight: FontWeight.w400,
                ),
              ),

              // Y축: 혈압/맥박 공용
              primaryYAxis: NumericAxis(
                minimum: 60,
                maximum: 200,
                interval: 20,
                majorGridLines: const MajorGridLines(width: 0.5),
                labelStyle: const TextStyle(
                  color: Color(0xFF111111), fontSize: 10, height: 1.1, letterSpacing: -0.5, fontWeight: FontWeight.w400,
                ),
                plotBands: const [
                  PlotBand(
                    start: 120, end: 120,
                    isVisible: true, dashArray: [5, 10],
                    borderWidth: 1, borderColor: Color(0xff7DBA68),
                    color: Colors.transparent,
                  ),
                  PlotBand(
                    start: 80, end: 80,
                    isVisible: true, dashArray: [5, 10],
                    borderWidth: 1, borderColor: Color(0xff7DBA68),
                    color: Colors.transparent,
                  ),
                ],
              ),

              // 시리즈: RangeColumn(혈압), Line(맥박)
              series: [
                RangeColumnSeries<BPPoint, DateTime>(
                  name: '혈압(수축~이완)',
                  width: 0.15,
                  spacing: 0.25,
                  dataSource: _seriesData,
                  xValueMapper: (d, _) => d.date,
                  lowValueMapper: (d, _) => d.diastolic.toDouble(),
                  highValueMapper: (d, _) => d.systolic.toDouble(),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  onRendererCreated: (ctrl) => _bpRangeCtrl = ctrl,
                  color: const Color(0xFF87CEFA)
                ),
                LineSeries<BPPoint, DateTime>(
                  name: '맥박',
                  dataSource: _seriesData,
                  xValueMapper: (d, _) => d.date,
                  yValueMapper: (d, _) => d.pulse.toDouble(),
                  width: 2,
                  markerSettings: const MarkerSettings(
                    isVisible: true, width: 6, height: 6, shape: DataMarkerType.circle,
                  ),
                  onRendererCreated: (ctrl) => _pulseLineCtrl = ctrl,
                  color: const Color(0xFFFF7DA0),
                ),
              ],

              // 확대/줌 비활성, 가로 스크롤만
              zoomPanBehavior: ZoomPanBehavior(
                enablePanning: true,
                enablePinching: false,
                enableDoubleTapZooming: false,
                zoomMode: ZoomMode.x,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 범례 도형
  Widget _buildLegendDot(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration:BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
