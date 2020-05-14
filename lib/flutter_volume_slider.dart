import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FlutterVolumeSlider extends StatefulWidget {

  final Color sliderActiveColor;
  final Color sliderInActiveColor;

  FlutterVolumeSlider({
    this.sliderActiveColor,
    this.sliderInActiveColor
  });

  @override
  _FlutterVolumeSliderState createState() => _FlutterVolumeSliderState();
}

class _FlutterVolumeSliderState extends State<FlutterVolumeSlider> {

  double initVal = .1;
  MethodChannel _channel = MethodChannel('freekit.fr/volume');

  Future<void> changeVolume(double volume) async {
    try {
      return _channel.invokeMethod('changeVolume', <String, dynamic>{
        'volume': volume,
      });
    } on PlatformException catch (e) {
      throw 'Unable to change volume ${volume}: ${e.message}';
    }
  }

  Future<MaxVolume> getMaxVolume() async {
    try {
      var val = await _channel.invokeMethod('getMaxVolume');
      return MaxVolume(val.toDouble());
    } on PlatformException catch (e) {
      throw 'Unable to get max volume ';
    }
  }

  Future<MinVolume> getMinVolume() async {
    try {
      var val = await _channel.invokeMethod('getMinVolume');
      return MinVolume(val.toDouble());
    } on PlatformException catch (e) {
      throw 'Unable to get max volume ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<MaxVolume>(create: (_) async => getMaxVolume(), initialData: MaxVolume(1.0)),
        FutureProvider<MinVolume>(create: (_) async => getMinVolume(), initialData: MinVolume(0.0)),
      ],
      child: Consumer2<MaxVolume, MinVolume>(
          builder: (context, maxVol, minVol, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              CupertinoIcons.volume_mute,
              size: 25.0,
              color: Colors.black,
            ),
            Slider(
              activeColor: widget.sliderActiveColor != null ? widget.sliderActiveColor : Colors.black,
              inactiveColor: widget.sliderInActiveColor != null ? widget.sliderInActiveColor : Colors.grey,
              value: initVal,
              max: maxVol.value,
              min: minVol.value,
              onChanged: (value) {
                changeVolume(value);
                setState(() => initVal = value);
              },
            ),
            Icon(
              CupertinoIcons.volume_up,
              size: 25.0,
              color: Colors.black,
            ),
          ],
        );
      }),
    );
  }
}

class MinVolume {
  double value;
  MinVolume(this.value);
}

class MaxVolume {
  double value;
  MaxVolume(this.value);
}
