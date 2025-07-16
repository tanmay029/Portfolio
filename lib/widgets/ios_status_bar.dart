import 'dart:async';
import 'package:flutter/material.dart';

class IOSStatusBar extends StatefulWidget {
  const IOSStatusBar({Key? key}) : super(key: key);

  @override
  State<IOSStatusBar> createState() => _IOSStatusBarState();
}

class _IOSStatusBarState extends State<IOSStatusBar> {
  late String _timeString;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        _timeString = _formatDateTime(DateTime.now());
      });
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildBatteryIcon() {
    return Row(
      children: [
        Container(
          width: 20,
          height: 10,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Container(
            margin: const EdgeInsets.all(1),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            child: Container(
              width: 120,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _timeString,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.signal_cellular_4_bar,
                      color: Colors.white, size: 18),
                  const SizedBox(width: 4),
                  const Icon(Icons.wifi, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  _buildBatteryIcon(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
