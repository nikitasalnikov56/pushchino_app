
import 'package:flutter/material.dart';
import 'package:pushchino_app/ui/style/app_style.dart';

class MeterRowItem extends StatelessWidget {
  const MeterRowItem({
    super.key,
    required this.deviceNumber1,
  });
  final String deviceNumber1;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Прибор учета:\n',
        style: AppStyle.fontStyle.copyWith(fontWeight: FontWeight.w300),
        children: [
          TextSpan(
            text: deviceNumber1,
            style: AppStyle.fontStyle.copyWith(),
          ),
        ],
      ),
    );
  }
}
