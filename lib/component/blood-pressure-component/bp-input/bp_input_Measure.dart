import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BpInputMeasure extends StatefulWidget {
  final String label;
  final String hint;
  final String unit;
  final ValueChanged<String>? onChanged;

  const BpInputMeasure({
    super.key,
    required this.label,
    required this.hint,
    required this.unit,
    this.onChanged,
  });

  @override
  State<BpInputMeasure> createState() => _BpInputMeasureState();
}

class _BpInputMeasureState extends State<BpInputMeasure> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF505050),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: widget.hint,
              suffixText: widget.unit,
              contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Color(0xFF505050),
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Color(0xff0075FF),  // 포커스 시 파란색
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}