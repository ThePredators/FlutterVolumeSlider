# FlutterVolumeSlider

[![pub package](https://img.shields.io/pub/v/flutter_volume_slider.svg)](https://pub.dev/packages/flutter_volume_slider)

A flutter widget to control volume in each Android & iOS.

<img src="https://i.imgur.com/CgbodmG.jpg" height="500" style="float: left;" /> <img src="https://i.imgur.com/UDjlM2Z.png" width="300" height="500" style="float: left;">


## How to use :

Just add FlutterVolumeSlider Widget anywhere you want to control volume.

Works Properly on Android and iOS.

**Display Horizontally :** 

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
            display: Display.HORIZONTAL,
            sliderActiveColor: Colors.blue,
            sliderInActiveColor: Colors.grey,
          ),
        ),
      ),
    );
  }

```

**Display Vertically :** 

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
            display: Display.VERTICAL,
            sliderActiveColor: Colors.blue,
            sliderInActiveColor: Colors.grey,
          ),
        ),
      ),
    );
  }

```