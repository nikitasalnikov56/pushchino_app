import 'package:flutter/material.dart';
import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/ui/style/app_colors.dart';
import 'package:pushchino_app/ui/style/app_style.dart';

class RowTitles extends StatelessWidget {
  const RowTitles({
    super.key,
    required this.state,
    required this.index1,
    required this.index2,
    required this.i,
  });
  final AuthorizationLoadedState state;
  final int index1;
  final int index2;
  final int i;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           if (index1 < (state.getMeasuringDevices?.returnDevicesData?.measuringDevicesList?.length ?? 0))
          Container(
            color: AppColors.smokeBlue,
            padding:
                const EdgeInsets.only(top: 3, bottom: 3, left: 28, right: 80),
               
            child: Text(
              '${state.getMeasuringDevices?.returnDevicesData?.measuringDevicesList?[index1].deviceName}'.toUpperCase(),
              style: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
           SizedBox(width: MediaQuery.of(context).size.width / 10),
          
               if (index2 < (state.getMeasuringDevices?.returnDevicesData?.measuringDevicesList?.length ?? 0))
          Container(
            color: AppColors.smokeBlue,
            padding:
                const EdgeInsets.only(top: 3, bottom: 3, left: 11, right: 80),
                
            child: Text(
              '${state.getMeasuringDevices?.returnDevicesData?.measuringDevicesList?[index2].deviceName}'.toUpperCase(),
              style: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



//  margin: EdgeInsets.only(
//                 right: (index2 == (state.getMeasuringDevices?.returnDevicesData?.measuringDevicesList?.length ?? 0) -1) ? 35 : 0,
//               ),

// state
//           .getMeasuringDevices!.returnDevicesData!.measuringDevicesList!
//           .map((e) {
//         return Container(
//           color: AppColors.smokeBlue,
//           margin: const EdgeInsets.only(right: 35),
//           padding: EdgeInsets.only(
//               top: 3, bottom: 3, left: 28, right: i % 2 == 0 ? 80 : 92),
//           child: Text(
//             '${e.deviceName}'.toUpperCase(),
//             style: AppStyle.fontStyle.copyWith(
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         );
//       }).toList(),
