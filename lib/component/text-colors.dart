import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../primary-color.dart';

class TextStyleCustom {
  // 홈 화면에 혈압 박스에 [수축기 혈압, 이완기 혈압, 맥박] 등 같은 옵션 타입일 경우
  // "수축기 혈압", "이완기 혈압", "맥박"
  static TextStyle homeBloodBoxTextStyle() {
    return TextStyle(
      color: Color(0xFF505050),
      fontSize: 12,
      fontFamily: 'Pretendard',
      height: 0.04,
    );
  }

  static TextStyle homeBloodBox() {
    return TextStyle(
        color: PrimaryColor.gray,
        fontFamily: "Pretendard",
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 6/12
    );
  }

  static TextStyle homeBloodTextNumber() {
    return TextStyle(
      color: PrimaryColor.black,
      fontSize: 20,
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w700,
      height: 22 / 20,
      letterSpacing: -0.4,
    );

  }

  static TextStyle homeBloodTextmmHg() {
    return TextStyle(
      color: PrimaryColor.black,
      fontSize: 14,
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w700,
      height: 22/20,
      letterSpacing: -0.4,
    );

  }


  static Text grayTextWidget({
    text = '', color = Colors.white
  })
  {
    return Text('${text}', style: TextStyle(color: color));
  }
}
