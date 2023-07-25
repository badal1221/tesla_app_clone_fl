import 'package:flutter/material.dart';
import '../constants.dart';

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({Key? key, required this.constrains}) : super(key: key);
  final BoxConstraints constrains;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: defaultPadding,),
        Text('220 mi',
          style: Theme.of(context)
              .textTheme.headline3!
              .copyWith(color: Colors.white),
        ),
        const SizedBox(height: defaultPadding,),
        const Text('63%',
            style: TextStyle(fontSize: 24)
        ),
        const Spacer(),
        const Text('CHARGING',
            style: TextStyle(fontSize: 24)
        ),
        const Text('18 min remaining',
            style: TextStyle(fontSize: 24)
        ),
        SizedBox(height: constrains.maxHeight*0.14,),
        const DefaultTextStyle(
          style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          child:Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('22 mi/hr',),
                Text('232 v',),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding,),
      ],
    );
  }
}
