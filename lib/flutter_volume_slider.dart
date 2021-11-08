import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FlutterVolumeSlider extends StatefulWidget {
  final Display display;
  final Color? sliderActiveColor;
  final Color? sliderInActiveColor;

  FlutterVolumeSlider(
      {this.sliderActiveColor, this.sliderInActiveColor, required this.display});

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
      throw 'Unable to change volume : ${e.message}';
    }
  }

  Future<MaxVolume> getMaxVolume() async {
    try {
      var val = await _channel.invokeMethod('getMaxVolume');
      return MaxVolume(val.toDouble());
    } on PlatformException catch (e) {
      throw 'Unable to get max volume : ${e.message}';
    }
  }

  Future<MinVolume> getMinVolume() async {
    try {
      var val = await _channel.invokeMethod('getMinVolume');
      return MinVolume(val.toDouble());
    } on PlatformException catch (e) {
      throw 'Unable to get max volume e : ${e.message}';
    }
  }

  _buildVerticalContainer(maxVol, minVol) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          CupertinoIcons.volume_mute,
          size: 25.0,
          color: Colors.black,
        ),
        Container(
          height: 175,
          child: new Transform(
            alignment: FractionalOffset.center,
            // Rotate sliders by 90 degrees
            transform: new Matrix4.identity()..rotateZ(90 * 3.1415927 / 180),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 175,
                  child: Slider(
                    activeColor: widget.sliderActiveColor != null
                        ? widget.sliderActiveColor
                        : Colors.black,
                    inactiveColor: widget.sliderInActiveColor != null
                        ? widget.sliderInActiveColor
                        : Colors.grey,
                    value: initVal,
                    divisions: 50,
                    max: maxVol.value,
                    min: minVol.value,
                    onChanged: (value) {
                      changeVolume(value);
                      setState(() => initVal = value);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Icon(
          CupertinoIcons.volume_up,
          size: 25.0,
          color: Colors.black,
        ),
      ],
    );
  }

  _buildHorizontalContainer(maxVol, minVol) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          CupertinoIcons.volume_mute,
          size: 25.0,
          color: Colors.black,
        ),
        Slider(
          activeColor: widget.sliderActiveColor != null
              ? widget.sliderActiveColor
              : Colors.black,
          inactiveColor: widget.sliderInActiveColor != null
              ? widget.sliderInActiveColor
              : Colors.grey,
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
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<MaxVolume>(
            create: (_) async => getMaxVolume(), initialData: MaxVolume(1.0)),
        FutureProvider<MinVolume>(
            create: (_) async => getMinVolume(), initialData: MinVolume(0.0)),
      ],
      child: Consumer2<MaxVolume, MinVolume>(
          builder: (context, maxVol, minVol, child) {
        if (widget.display == Display.HORIZONTAL) {
          return _buildHorizontalContainer(maxVol, minVol);
        } else {
          return _buildVerticalContainer(maxVol, minVol);
        }
      }),
    );
  }
}

enum Display { HORIZONTAL, VERTICAL }

class MinVolume {
  double? value;
  MinVolume(this.value);
}

class MaxVolume {
  double? value;
  MaxVolume(this.value);
}
