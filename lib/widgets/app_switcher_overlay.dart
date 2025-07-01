import 'package:flutter/material.dart';
import 'package:ios_simulator_flutter_web/main.dart';
import 'package:ios_simulator_flutter_web/widgets/app_card.dart';

class AppSwitcherOverlay extends StatelessWidget {
  final List<SimulatorScreen> openedApps;
  final Function(SimulatorScreen) onCloseScreen;
  final Function(SimulatorScreen) onTapScreen;
  final Widget Function(SimulatorScreen) appCardBuilder;
  

  const AppSwitcherOverlay({
    Key? key,
    required this.openedApps,
    required this.onCloseScreen,
    required this.onTapScreen,
    required this.appCardBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Stack(
        children: openedApps.map((screen) {
          return Draggable(
            feedback: appCardBuilder(screen),
            childWhenDragging: Container(),
            onDragEnd: (details) {
              if (details.offset.dy < -100) {
                onCloseScreen(screen);
              }
            },
            child: GestureDetector(
              onTap: () => onTapScreen(screen),
              child: AppCard(screen: screen),
            ),
          );
        }).toList(),
      ),
    );
  }
}
