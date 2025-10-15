// lib/screen/bp/graph_section.dart
import 'package:flutter/material.dart';
import 'package:novel/primary-color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late TooltipBehavior _tooltipBehavior;

class GraphSection extends StatefulWidget {
  const GraphSection({super.key});

  @override
  State<GraphSection> createState() => _GraphSectionState();
}

class _GraphSectionState extends State<GraphSection> {
  @override
  Widget build(BuildContext context) {
    bool showSys = true;
    bool showPulse = true;

    List<ChartData> data = [
      // 최근 1주일 값
      ChartData('25.09.01', 160, 128, 70),
      ChartData('25.09.03', 140, 100, 74),
      ChartData('25.09.04', 150, 120, 90),
      ChartData('25.09.05', 145, 130, 81),
      ChartData('25.09.06', 145, 130, 81),
    ];

    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 240.h,
      color: Colors.white,
      // 배경색
      child: Column(
        children: [
          Expanded(
            child: SfCartesianChart(
              tooltipBehavior: TooltipBehavior(
                enable: true,
                canShowMarker: false,
                activationMode: ActivationMode.singleTap,
              ),
              legend: Legend(isVisible: false),

              annotations: [
                CartesianChartAnnotation(
                  region: AnnotationRegion.plotArea,
                  // 플롯 영역 안쪽
                  coordinateUnit: CoordinateUnit.logicalPixel,
                  // 픽셀 좌표로 배치
                  x: 295.w,
                  // 좌측에서 12px
                  y: 20.h,
                  // 위에서 12px
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 2),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 수축
                        GestureDetector(
                          onTap: () => setState(() => showSys = !showSys),
                          child: Opacity(
                            opacity: showSys ? 1.0 : 0.4,
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffB2D7FF),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  '수축, 이완',
                                  style: TextStyle(fontSize: 8),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // 맥박
                        GestureDetector(
                          onTap: () => setState(() => showPulse = !showPulse),
                          child: Opacity(
                            opacity: showPulse ? 1.0 : 0.4,
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffFFC0CC),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text('맥박',style: TextStyle(fontSize: 8),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // 툴팁 렌더링
              onTooltipRender: (TooltipArgs args) {
                final si = (args.seriesIndex ?? 0).toInt(); // 0: 혈압, 1: 맥박
                final pi = (args.pointIndex ?? 0).toInt();

                if (pi < 0 || pi >= data.length) return;
                final d = data[pi];

                // 헤더에 X축 라벨(요일) 표시
                args.header = d.x;

                if (si == 1) {
                  // 맥박 라인 툴팁
                  args.text = '맥박: ${d.bpm.toStringAsFixed(0)} bpm';
                } else {
                  // 혈압 범위 칼럼 툴팁
                  args.text =
                      '수축기: ${d.y.toStringAsFixed(0)} mmHg \n이완기: ${d.relaxation.toStringAsFixed(0)} mmHg';
                }
              },
              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(size: 0),
                axisLine: AxisLine(width: 0),
                labelStyle: TextStyle(
                  color: const Color(0xFF111111),
                  fontSize: 10,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.10,
                  letterSpacing: -0.50,
                ),

                // labelRotation: 30,
                // 음수: 오른쪽으로 기울어짐, 필요시 -45 등으로 조정
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                axisLabelFormatter: (AxisLabelRenderDetails details) {
                  // 숫자 폭과 유사한 figure space 2개로 살짝 오른쪽 밀기
                  const pad = '\u2007';
                  return ChartAxisLabel(
                    '$pad${details.text}',
                    details.textStyle,
                  );
                },
              ),

              primaryYAxis: NumericAxis(
                labelStyle: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 10,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 1.10,
                    letterSpacing: -0.50,
                ),
                // todo 80, 120 숫자 변경
                axisLabelFormatter: (AxisLabelRenderDetails args) {
                  if (args.value == 80 || args.value == 120) {
                    return ChartAxisLabel(
                      args.text,
                      const TextStyle(
                        color: Color(0xff7DBA68),
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return ChartAxisLabel(
                    args.text,
                    const TextStyle(color: Colors.black),
                  );
                },
                // todo 혈압 그래프
                minimum: 60,
                maximum: 200,
                interval: 20,
                plotBands: <PlotBand>[
                  // 수축기 120 기준선 (빨간 점선)
                  PlotBand(
                    start: 120,
                    end: 120,
                    dashArray: <double>[5, 10],
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400
                    ),
                    // start=end 로 ‘선’처럼 사용
                    isVisible: true,
                    borderWidth: 1,
                    borderColor: Color(0xff7DBA68),
                    color: Colors.transparent, // 배경은 투명
                  ),
                  // 정상범위(90~119) 배경 하이라이트
                  PlotBand(
                    start: 80,
                    end: 80,
                    borderWidth: 1,
                    borderColor: Color(0xff7DBA68),
                    isVisible: true,
                    dashArray: <double>[5, 10],
                  ),
                ],
              ),
              enableSideBySideSeriesPlacement: true,
              series: <CartesianSeries>[
                RangeColumnSeries<ChartData, String>(
                  color: Color(0xffB2D7FF),
                  name: "혈압",
                  width: 0.1,
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.x,
                  lowValueMapper: (ChartData data, _) => data.relaxation,
                  highValueMapper: (ChartData data, _) => data.y,
                ),
                // 맥박
                SplineSeries<ChartData, String>(
                  name: '맥박',
                  opacity: 1,
                  width: 2,
                  dataSource: data,
                  color: Color(0xffFFC0CC),
                  xValueMapper: (ChartData d, _) => d.x,
                  yValueMapper: (ChartData d, _) => d.bpm,
                  enableTooltip: true,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    width: 6,
                    height: 6,
                    shape: DataMarkerType.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.relaxation, this.bpm);

  // 요일
  final String x;

  // 수축기 혈압, 이완기 혈압
  final double y;
  final double relaxation;

  // 맥박
  final double bpm;
}
