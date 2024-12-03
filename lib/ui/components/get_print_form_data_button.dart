import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushchino_app/domain/controllers/app_controllers.dart';

import 'package:pushchino_app/domain/manager/get_print_form_data/get_print_form_data_bloc.dart';
import 'package:pushchino_app/main.dart';
import 'package:pushchino_app/ui/models/notification.dart';

class GetPrintFormDataButton extends StatelessWidget {
  const GetPrintFormDataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPrintFormDataBloc, GetPrintFormDataState>(
      listener: (context, state) {
        if (state is GetPrintFormDataLoadedState) {
          Scaffold.of(context).closeDrawer();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Notifications.initializeNotifications(flutterLocalNotificationsPlugin, state.res.path);
            Notifications.showNotification(
                title: 'Файл сохранен в:',
                body: state.res.path,
                fln: flutterLocalNotificationsPlugin);
          });
        } else if (state is GetPrintFormDataErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ошибка: ${state.error}')),
              );
            }
          });
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<GetPrintFormDataBloc>().add(
              GetPrintFormDataLoadedEvent(
                login: AppControllers.login.text,
                password: AppControllers.password.text,
                date: DateTime.now(),
                type: 1,
              ),
            );
          },
          child: const Text('Скачать квитанцию'),
        );
      },
    );
  }

 
}



// _downloadFile(String login, String password) async{
  //   final api = Api.instance;
  //   var time = DateTime.now().millisecondsSinceEpoch;
  //   var path = "/storage/emulated/0/Download/pdf-$time.pdf";
  //   var file = File(path);
  // var token = await api.fetchNewToken(login, password);
  // if (token == null) {
  //       throw Exception('Не удалось получить токен.');
  //     }
  //     var date = DateTime.now();
  //     final currentDate = DateFormat('yyyy-MM-dd').format(date);

  //   var res = await get(Uri.parse('https://dmitrov.moya-kvitanciya.ru/api/GetPrintForm?Token=$token&Period=$currentDate&OperationType=1'));
  //   file.writeAsBytes(res.bodyBytes);
  // }