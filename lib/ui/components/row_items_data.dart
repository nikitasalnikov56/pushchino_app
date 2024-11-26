import 'package:flutter/material.dart';
import 'package:pushchino_app/ui/style/app_colors.dart';
import 'package:pushchino_app/ui/style/app_style.dart';

class RowItemsData extends StatelessWidget {
  const RowItemsData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 28, top: 54, bottom: 54),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              'ДО ПЕРЕДАЧИ ПОКАЗАНИЙ',
              style: AppStyle.fontStyle.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(width: 21),
          Container(
            width: 42,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: AppColors.white),
            ),
            alignment: Alignment.center,
            child: Text(
              '6',
              style: AppStyle.fontStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(width: 18),
          Text(
            'ДНЕЙ',
            style: AppStyle.fontStyle.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(width: 18),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
            ),
            onPressed: () {},
            child: Text(
              'ПЕРЕДАТЬ\nПОКАЗАНИЯ',
              textAlign: TextAlign.center,
              style: AppStyle.fontStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
