# FlutterVolumeSlider

[![pub package](https://img.shields.io/pub/v/flutter_volume_slider.svg)](https://pub.dev/packages/flutter_volume_slider)

A flutter widget to control volume in each Android & iOS native volume.

<img src="samples/android.jpg" height="500" style="float: left;" /><img src="samples/default.jpg" height="500" style="float: left;" /><img src="samples/ios.png" height="500" width="300" style="float: left;" />

## How to use :

Just add VolumeSlider() Widget anywhere you want to control volume. Works Properly on Android and iOS.

```
...

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlutterVolumeSlider(
            sliderActiveColor: Colors.blue,
            sliderInActiveColor: Colors.grey,
          ),
        ),
      ),
    );
  }

```

