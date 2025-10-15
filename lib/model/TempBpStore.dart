import 'BloodPressureRecord.dart';

/// 메모리에만 보관되는 간단한 임시 저장소
class TempBpStore {
  TempBpStore._();
  static final TempBpStore I = TempBpStore._();

  final List<BpRecord> _items = <BpRecord>[
    BpRecord(
      id: _genId(),
      systolic: 148,
      diastolic: 128,
      heartRate: 70,
      measuredAt: DateTime(2025, 8, 15, 13, 40),
      source: '블루투스',
      note: '식후 30분',
    ),
    BpRecord(
      id: _genId(),
      systolic: 122,
      diastolic: 78,
      heartRate: 63,
      measuredAt: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      source: '수기입력',
      note: null,
    ),
    BpRecord(
      id: _genId(),
      systolic: 122,
      diastolic: 78,
      heartRate: 63,
      measuredAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      source: '수기입력',
      note: null,
    ),
    BpRecord(
      id: _genId(),
      systolic: 122,
      diastolic: 78,
      heartRate: 63,
      measuredAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      source: '수기입력',
      note: null,
    ),
    BpRecord(
      id: _genId(),
      systolic: 135,
      diastolic: 85,
      heartRate: 72,
      measuredAt: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
      source: '블루투스',
      note: '가벼운 운동 후',
    ),
  ];

  // 정렬된 읽기 전용 목록(최신순)
  List<BpRecord> get items {
    final sorted = [..._items]..sort((a, b) => b.measuredAt.compareTo(a.measuredAt));
    return List.unmodifiable(sorted);
  }

  // 비동기로 가져오기(약간의 지연으로 API 느낌)
  Future<List<BpRecord>> fetchAll({Duration delay = const Duration(milliseconds: 150)}) async {
    await Future.delayed(delay);
    return items;
  }

  // 추가(편의 함수)
  BpRecord add({
    required int systolic,
    required int diastolic,
    required int heartRate,
    DateTime? measuredAt,
    String source = '수기입력',
    String? note,
  }) {
    final record = BpRecord(
      id: _genId(),
      systolic: systolic,
      diastolic: diastolic,
      heartRate: heartRate,
      measuredAt: measuredAt ?? DateTime.now(),
      source: source,
      note: note,
    );
    _items.add(record);
    return record;
  }

  // 수정(동일 id 교체)
  bool update(BpRecord updated) {
    final idx = _items.indexWhere((e) => e.id == updated.id);
    if (idx == -1) return false;
    _items[idx] = updated;
    return true;
  }

  // 삭제
  bool remove(String id) {
    final before = _items.length;
    _items.removeWhere((e) => e.id == id);
    return _items.length != before;
  }

  // 단건 조회
  BpRecord? findById(String id) {
    try {
      return _items.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}

String _genId() => 'bp_${DateTime.now().microsecondsSinceEpoch}';
