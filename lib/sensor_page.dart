// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures

import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';


class SensorPage extends StatefulWidget {
  const SensorPage({super.key, required this.title});
 
  final String title;

  @override
  State<SensorPage> createState() => _SensorStage();
}




class _SensorStage extends State<SensorPage> {
  
  final Battery _battery = Battery();
  BatteryState? _batteryState; 
  StreamSubscription<BatteryState>? _batteryStateSubscription;
  
  @override
  void initState() {
    super.initState();
    _batteryStateSubscription =
      _battery.onBatteryStateChanged.listen((BatteryState state) {
        setState(() {
      _batteryState = state;
    });
  });
}

  @override
  Widget build(BuildContext context) {
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: (){
      print('Perigo! movimento brusco');
      }
    );
  
  final periodicTimer = Timer.periodic(
  const Duration(seconds: 15),
  (timer) {
    if (_batteryState.toString() != 'BatteryState.charging' )
      print('Perigo! usb desconectado');
  },
);
    
  
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Perigo ! Botão');
          },
        child: const Icon(Icons.add),
      ),
    );    
  }
  

}