import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_app/home_controller.dart';
import '../components/tyre.dart';
import '../components/battery_status.dart';
import '../components/door_lock.dart';
import '../components/temp_details.dart';
import '../components/tesla_bottom_navigationbar.dart';
import '../components/tyre_psi_card.dart';
import '../constants.dart';
import '../models/tyrePsi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //no single ticker because of more than 1 controller
  final HomeController _controller = HomeController();

  //2nd page anim
  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  //3rd page anim
  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationCoolGlow;

  //4th page anim
  late AnimationController _tyreAnimationController;
  late Animation<double> _animationTyre1Psi;
  late Animation<double> _animationTyre2Psi;
  late Animation<double> _animationTyre3Psi;
  late Animation<double> _animationTyre4Psi;

  late List<Animation<double>> _tyreAnimations;

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationBattery = CurvedAnimation(
        parent: _batteryAnimationController,
        curve: const Interval(
            0.0, 0.5)); //animation starts at 0 and ends at 300 milisec
    _animationBatteryStatus = CurvedAnimation(
        parent: _batteryAnimationController, curve: const Interval(0.6, 1));
  }

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.2, 0.4),
    );
    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.45, 0.65),
    );
    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.7, 1),
    );
  }

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animationTyre1Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(
          0.34, 0.5), //initial delay of 400 sec let the tyres come
    );
    _animationTyre2Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.5, 0.66),
    );
    _animationTyre3Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.66, 0.82),
    );
    _animationTyre4Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.82, 1),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyreAnimations = [
      _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi
    ];
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _batteryAnimationController,
          _tempAnimationController,
          _tyreAnimationController
        ]),
        builder: (context, _) {
          return Scaffold(
            bottomNavigationBar: TeslaBottomNavigation(
              onTap: (index) {
                if (index == 1) {
                  _batteryAnimationController.forward();
                } else if (_controller.selectedBottomTab == 1 && index != 1) {
                  _batteryAnimationController.reverse(from: 0.7);
                }
                if (index == 2) {
                  _tempAnimationController.forward();
                } else if (_controller.selectedBottomTab == 2 && index != 2) {
                  _tempAnimationController.reverse(from: 0.4);
                }
                if (index == 3) {
                  _tyreAnimationController.forward();
                } else if (_controller.selectedBottomTab == 3 && index != 3) {
                  _tyreAnimationController.reverse();
                }
                _controller.showTyreController(index);
                _controller.tyreStatusController(index);
                _controller.onBottomNavigationTabChanged(index);
              },
              selectedTab: _controller.selectedBottomTab,
            ),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                    ),
                    Positioned(
                      left: constrains.maxWidth / 2 * _animationCarShift.value,
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: constrains.maxHeight * 0.15,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Car.svg",
                          width: double.infinity,
                        ),
                      ),
                    ),

                    //page no 1
                    AnimatedPositioned(
                      duration: defaultDuration,
                      //move to middle and hide if other page is being shown
                      right: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                            press: _controller.updateRightDoorLock,
                            isLock: _controller.isRightDoorLock),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                            press: _controller.updateLeftDoorLock,
                            isLock: _controller.isLeftDoorLock),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.18
                          : constrains.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                            press: _controller.updateBonnetDoorLock,
                            isLock: _controller.isBonnetDoorLock),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.21
                          : constrains.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                            press: _controller.updateTrunkDoorLock,
                            isLock: _controller.isTrunkDoorLock),
                      ),
                    ),

                    //page 2
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        'assets/icons/Battery.svg',
                        width: constrains.maxWidth * 0.45,
                      ),
                    ),
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                          opacity: _animationBatteryStatus.value,
                          child: BatteryStatus(constrains: constrains)),
                    ),

                    //page 3
                    Positioned(
                      top: 60 * (1 - _animationTempShowInfo.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                          opacity: _animationTempShowInfo.value,
                          child: TempDetails(
                            controller: _controller,
                          )),
                    ),
                    Positioned(
                      right: -100 * (1 - _animationCoolGlow.value),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _controller.isCoolSelected
                            ? Image.asset(
                                'assets/images/Cool_glow_2.png',
                                key: UniqueKey(),
                                width: 220,
                              )
                            : Image.asset(
                                'assets/images/Hot_glow_4.png',
                                key: UniqueKey(),
                                width: 220,
                              ),
                      ),
                    ),

                    //page 4
                    if (_controller.isShowTyre) ...tyres(constrains),
                    if (_controller.isShowTyreStatus)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10)
                            .copyWith(top: 10),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: defaultPadding,
                            crossAxisSpacing: defaultPadding,
                            childAspectRatio:
                                constrains.maxWidth / constrains.maxHeight,
                          ),
                          itemCount: 4,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ScaleTransition(
                            scale: _tyreAnimations[index],
                            child: TyrePsiCard(
                              isBottomTwoTyre: index >= 2,
                              tyrePsi: demoPsiList[index],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          );
        });
  }
}
