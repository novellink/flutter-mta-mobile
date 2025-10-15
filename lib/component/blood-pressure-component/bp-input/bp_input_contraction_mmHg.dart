import 'package:flutter/material.dart';

class BpInputMmhg extends StatelessWidget {
  const BpInputMmhg({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30, left: 24, right: 24),
          width: 327,
          child: Text(
            '수축기 혈압',
            style: TextStyle(
              color: const Color(0xFF505050),
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 1.22,
              letterSpacing: -0.45,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, left: 24, right: 24),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF227EFF), // 선택시 파란색 테두리
                  width: 1,
                ),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  border: InputBorder.none,
                  hintText: "148",
                  hintStyle: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                  ),
                  suffix: Text(
                    "mmHg", // ✅ 오른쪽에 단위 표시
                    style: TextStyle(
                      color: Color(0xFF505050),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
