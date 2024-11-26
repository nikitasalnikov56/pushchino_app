import 'package:flutter/material.dart';
import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/ui/style/app_colors.dart';
import 'package:pushchino_app/ui/style/app_style.dart';

class LeftCard extends StatelessWidget {
  const LeftCard({
    super.key,
    required this.state,
  });
  final AuthorizationLoadedState state;
  @override
  Widget build(BuildContext context) {
    final info = state.personalUserData?.returnPersonalUserData?.personalData;
    String parseAddress(String? address) {
      if (address != null) {
        // Разделяем строку по первой запятой
        var parts = address.split(',');
        if (parts.isNotEmpty) {
          // Если есть запятая, добавляем \n после первой части
          return '${parts[0]}\n${parts.sublist(1).join(',')}';
        }
      }
      // Если строка не содержит запятую, возвращаем исходную строку
      return address ?? '';
    }

    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 16, left: 27, right: 22),
      decoration: const BoxDecoration(
        color: AppColors.smokeBlue,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: RichText(
        text: TextSpan(
          text: 'АДРЕС:\n',
          style: AppStyle.fontStyle
              .copyWith(fontWeight: FontWeight.w300, fontSize: 12),
          children: [
            TextSpan(
              text: '\n${parseAddress(info?.address)}\n',
              style: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: '\nКВАРТИРА:\t',
              style: AppStyle.fontStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            TextSpan(
              text: '${info?.flat}',
              style: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
