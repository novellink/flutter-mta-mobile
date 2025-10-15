// dart
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SlidingChart extends StatefulWidget {
  const SlidingChart({super.key});

  @override
  State<SlidingChart> createState() => _SlidingChartState();
}

class _SlidingChartState extends State<SlidingChart> {
  late ZoomPanBehavior _zoomPan;

  // 초기 뷰포트: 최근 30일
  late DateTime _min;
  late DateTime _max;

  final List<_Point> data = List.generate(
    120,
    (i) => _Point(
      DateTime.now().subtract(Duration(days: 119 - i)),
      100 + (i % 40),
    ),
  );

  @override
  void initState() {
    super.initState();
    _zoomPan = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      zoomMode: ZoomMode.x, // 가로축만 확대/이동
    );
    _max = DateTime.now();
    _min = _max.subtract(const Duration(days: 30));
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: _zoomPan,
      primaryXAxis: DateTimeAxis(
        autoScrollingMode: AutoScrollingMode.end,              // 최근 구간부터 시작
        autoScrollingDelta: 5,                                 // 보이는 구간 크기
        autoScrollingDeltaType: DateTimeIntervalType.days,      // 단위: 일
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(),
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: const InteractiveTooltip(enable: true),
      ),
      // ChartSeries -> CartesianSeries, 리스트 제네릭은 생략
      series: <CartesianSeries>[
        LineSeries<_Point, DateTime>(
          dataSource: data,
          xValueMapper: (p, _) => p.x,
          yValueMapper: (p, _) => p.y,
          width: 2,
        ),
      ],
    );
  }
}

class _Point {
  _Point(this.x, this.y);
  final DateTime x;
  final num y;
}