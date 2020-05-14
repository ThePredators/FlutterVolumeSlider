# FlutterVolumeSlider

[![pub package](https://img.shields.io/pub/v/flutter_volume_slider.svg)](https://pub.dev/packages/flutter_volume_slider)

A flutter widget to control volume in each Android & iOS native volume.

<img src="https://i.imgur.com/qtl727z.jpg" height="500" style="float: left;" /><img src="https://i.imgur.com/DCxykDN.jpg" height="500" style="float: left;" /><img src="https://i.imgur.com/UDjlM2Z.png" width="300" height="500" style="float: left;">

## How to use :

Just add FlutterVolumeSlider() Widget anywhere you want to control volume. Works Properly on Android and iOS.

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

