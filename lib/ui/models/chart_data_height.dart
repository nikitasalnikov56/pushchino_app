import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/domain/models/get_measuring_devices.dart';

class ChartDataHeight {
static  double calculateHeight(AuthorizationLoadedState state, int deviceIndex, int readingIndex) {
  final devices = state.getMeasuringDevices?.returnDevicesData?.measuringDevicesList;

  if (devices == null || deviceIndex >= devices.length) {
    return 0;
  }

  final device = devices[deviceIndex];


  if (device.readingsList is List<ReadingsList>) {
    final readingsList = device.readingsList as List<ReadingsList>;
    if (readingIndex < readingsList.length) {

      final actual = double.tryParse(readingsList[readingIndex].actual ?? '0') ?? 0;
      return (actual * 10) + 20; 
    }
  } else if (device.readingsList is List && (device.readingsList as List).isNotEmpty) {

    final readingsList = device.readingsList as List;
    if (readingIndex < readingsList.length && readingsList[readingIndex] is Map<String, dynamic>) {
      final actual = double.tryParse(readingsList[readingIndex]['Actual']?.toString() ?? '0') ?? 0;
      return (actual * 10) + 20;
    }
  } else if (device.readingsList is Map<String, dynamic>) {

    final readings = device.readingsList as Map<String, dynamic>;
    final actual = double.tryParse(readings['Actual']?.toString() ?? '0') ?? 0;
    return (actual * 10) + 20;
  }

  return 0; 
}


}