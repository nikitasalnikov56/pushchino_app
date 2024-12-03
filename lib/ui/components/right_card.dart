import 'package:flutter/material.dart';
import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/ui/style/app_colors.dart';
import 'package:pushchino_app/ui/style/app_style.dart';

class RightCard extends StatelessWidget {
  const RightCard({
    super.key,
    required this.state,
  });
  final AuthorizationLoadedState state;
  @override
  Widget build(BuildContext context) {
    final data = state.billingData?.billingPersonData?.accountingInformationList;
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 12, left: 16, right: 22),
      decoration: const BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Балланс: ${'\t' * 12}',
              style: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              children: [
                 TextSpan(
                  text: '${data?.sumTotal} \t\t',
                ),
                TextSpan(
                  text: 'руб\n',
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: '\nСумма к оплате:  ${'\t' * 8}',
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: '${data?.payment} \t\t\t',
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: 'руб\n',
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: '\nНеобходимо внести:  \t\t\t',
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: '${data?.debt} \t\t\t',
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: 'руб\n',
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
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
