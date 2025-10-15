class BpRecord {
  final String id;            // 임시 식별자
  final int systolic;         // 수축기 혈압
  final int diastolic;        // 이완기 혈압
  final int heartRate;        // 맥박(bpm)
  final DateTime measuredAt;  // 측정 시각
  final String source;        // 예: '블루투스', '수기 입력'
  final String? note;         // 메모(선택)

  const BpRecord({
    required this.id,
    required this.systolic,
    required this.diastolic,
    required this.heartRate,
    required this.measuredAt,
    required this.source,
    this.note,
  });
}
