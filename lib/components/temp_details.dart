import 'package:flutter/material.dart';
import 'package:tesla_app/components/temp_btn.dart';

import '../constants.dart';
import '../home_controller.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({Key? key, required HomeController controller})
      : _controller = controller,
        super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBtn(
                  isActive: _controller.isCoolSelected,
                  svgSrc: 'assets/icons/coolShape.svg',
                  title: 'Cool',
                  press: _controller.updateCoolSelectedTab,
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                TempBtn(
                  isActive: !_controller.isCoolSelected,
                  svgSrc: 'assets/icons/heatShape.svg',
                  title: 'Heat',
                  press: _controller.updateCoolSelectedTab,
                  activeColor: redColor,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                onPressed: () => _controller.updateTemp(1),
                icon: const Icon(
                  Icons.arrow_drop_up,
                  size: 48,
                ),
              ),
              Text(
                "${_controller.temp}\u2103",
                style: const TextStyle(fontSize: 86),
              ),
              IconButton(
                onPressed: () => _controller.updateTemp(-1),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 48,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Text('CURRENT TEMPERATURE'),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('INSIDE'),
                  Text(
                    "20\u2103",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'OUTSIDE',
                    style: TextStyle(color: Colors.white54),
                  ),
                  Text(
                    "35\u2103",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white54),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
