import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class TeslaBottomNavigation extends StatelessWidget {
  const TeslaBottomNavigation({Key? key, required this.selectedTab, required this.onTap}) : super(key: key);

  final int selectedTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      onTap: onTap,
      currentIndex: selectedTab,
      items:List.generate(navIconSrc.length,
            (index)=>BottomNavigationBarItem(
          icon:SvgPicture.asset(navIconSrc[index],
            color: index==selectedTab?primaryColor:Colors.white54,),
          label: "",
        ),
      ),
    );
  }
}

List<String> navIconSrc=[
  'assets/icons/Lock.svg',
  'assets/icons/Charge.svg',
  'assets/icons/Temp.svg',
  'assets/icons/Tyre.svg'
];


