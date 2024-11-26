import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushchino_app/domain/manager/auth_bloc/authorization_bloc.dart';
import 'package:pushchino_app/domain/manager/navbar_bloc/bottom_navbar_bloc.dart';
import 'package:pushchino_app/ui/components/appbar_widget.dart';
import 'package:pushchino_app/ui/components/chart_background_painter.dart';
import 'package:pushchino_app/ui/components/meter_row_item.dart';
import 'package:pushchino_app/ui/components/row_info_cards.dart';
import 'package:pushchino_app/ui/components/row_items_data.dart';
import 'package:pushchino_app/ui/models/chart_data_height.dart';
import 'package:pushchino_app/ui/resources/app_images.dart';
import 'package:pushchino_app/ui/style/app_colors.dart';
import 'package:pushchino_app/ui/style/app_style.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              BottomNavbarBloc()..add(BottomNavbarLoadEvent(index: 0)),
        ),
      ],
      child: const Scaffold(
        appBar: AppBarWidget(),
        backgroundColor: AppColors.blue,
        drawer: Drawer(),
        body: MainAppBody(),
      ),
    );
  }
}

class MainAppBody extends StatelessWidget {
  const MainAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
      builder: (context, state) {
        final index = state is BottomNavbarLoadState ? state.index : 0;

        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AppImages.bgWaves,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppBody(),
              BottomNavigationBar(
                elevation: 0,
                currentIndex: index,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (index) {
                  context
                      .read<BottomNavbarBloc>()
                      .add(BottomNavbarLoadEvent(index: index));
                },
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Image.asset(
                      AppImages.home,
                      color: const Color(0xFF95A1B9),
                    ),
                    label: '',
                    activeIcon: Image.asset(
                      AppImages.home,
                      color: AppColors.white,
                    ),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Image.asset(
                      AppImages.service,
                      color: const Color(0xFF95A1B9),
                    ),
                    label: '',
                    activeIcon: Image.asset(
                      AppImages.serviceActive,
                      color: AppColors.white,
                    ),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Image.asset(AppImages.info),
                    label: '',
                    activeIcon: Image.asset(
                      AppImages.infoActive,
                      color: AppColors.white,
                    ),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Image.asset(
                      AppImages.chart,
                      color: const Color(0xFF95A1B9),
                    ),
                    label: '',
                    activeIcon: Image.asset(
                      AppImages.chartActive,
                      color: AppColors.white,
                    ),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Image.asset(
                      AppImages.balance,
                      color: const Color(0xFF95A1B9),
                    ),
                    label: '',
                    activeIcon: Image.asset(
                      AppImages.balanceActive,
                      color: AppColors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      builder: (context, state) {
        if (state is AuthorizationLoadedState) {
          return Padding(
            padding: const EdgeInsets.only(top: 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  RowInfoCards(state: state),
                  const RowItemsData(),
                  ChartBackground(
                    linesCount: 8,
                    state: state,
                    months: const [
                      'ЯНВ',
                      'ФЕВ',
                      'МАР',
                      'АПР',
                      'МАЙ',
                      'ИЮН',
                      'ИЮЛ',
                      'АВГ',
                      'СЕНТ',
                      'ОКТ',
                      'НОЯБ',
                      'ДЕК',
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        if (state is AuthorizationErrorState) {
          return Center(
            child: Text(
              state.error,
              style: AppStyle.fontStyle.copyWith(
                color: AppColors.black,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ChartBackground extends StatelessWidget {
  const ChartBackground({
    super.key,
    required this.linesCount,
    required this.state,
    required this.months,
  });
  final int linesCount;

  final AuthorizationLoadedState state;

  final List<String> months;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 25,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 28),
            child: CustomPaint(
              painter: ChartBackgroundPainter(linesCount: linesCount),
              size: Size(MediaQuery.of(context).size.width / 1.14, 150),
            ),
          ),
        ),
        SizedBox(
          height: 275,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: AppColors.smokeBlue,
                    padding: EdgeInsets.only(
                        top: 3,
                        bottom: 3,
                        left: i % 2 == 0 ? 11 : 28,
                        right: 80),
                    child: Text(
                      '${state.getMeasuringDevices?.returnDevicesData?.measuringDevicesList?[i].deviceName}',
                      style: AppStyle.fontStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 160, maxWidth: 140),
                    child: Padding(
                      padding:  EdgeInsets.only(left: i%2!=0 ? 0: 30.0),
                      child: ListView.separated(
                                     padding: const EdgeInsets.all(0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, j) {
                          return Column(
                            verticalDirection: VerticalDirection.up,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 2,
                                  bottom: 2,
                                ),
                                child: Transform.rotate(
                                  angle: -1.5710,
                                  child: Text(
                                    months[j],
                                    style: AppStyle.fontStyle
                                        .copyWith(fontSize: 10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              Container(
                                height: ChartDataHeight.calculateHeight(
                                    state, i, j),
                                width: 16,
                                constraints: const BoxConstraints(
                                    maxWidth: 16, maxHeight: 118),
                                color: i % 2 != 0
                                    ? AppColors.chartRed
                                    : AppColors.lightGrey,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                          width: 5,
                        ),
                        itemCount: months.length,
                      ),
                    ),
                  ),
                  MeterRowItem(
                    deviceNumber1:
                        '${state.getMeasuringDevices?.returnDevicesData?.measuringDevicesList?[i].deviceNumber}',
                  ),
                ],
              );
            },
            separatorBuilder: (_, __) => SizedBox(
              width: MediaQuery.of(context).size.width / 6.5,
            ),
            itemCount: state.getMeasuringDevices?.returnDevicesData
                    ?.measuringDevicesList?.length ??
                0,
          ),
        ),
      ],
    );
  }
}
