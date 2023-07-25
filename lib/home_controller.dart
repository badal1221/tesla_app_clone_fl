import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isBonnetDoorLock = true;
  bool isTrunkDoorLock = true;

  int selectedBottomTab = 0;
  void onBottomNavigationTabChanged(int index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  void updateRightDoorLock() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateBonnetDoorLock() {
    isBonnetDoorLock = !isBonnetDoorLock;
    notifyListeners();
  }

  void updateTrunkDoorLock() {
    isTrunkDoorLock = !isTrunkDoorLock;
    notifyListeners();
  }

  bool isCoolSelected = true;
  void updateCoolSelectedTab() {
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }

  int temp = 29;
  void updateTemp(int a) {
    temp += a;
    notifyListeners();
  }

  bool isShowTyre = false;
  void showTyreController(int index) {
    if (index == 3) {
      Future.delayed(
        const Duration(milliseconds: 400),
        () {
          isShowTyre = true;
        },
      );
    } else {
      isShowTyre = false;
    }
    notifyListeners();
  }

  bool isShowTyreStatus = false;
  void tyreStatusController(int index) {
    if (index == 3) {
      isShowTyreStatus = true;
    } else {
      Future.delayed(
        const Duration(milliseconds: 200),
        () {
          isShowTyreStatus = false;
        },
      );
    }
    notifyListeners();
  }
}
