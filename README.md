# FlutterVolume

A flutter widget to control volume in each Android & iOS.

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
          child: VolumeSlider(
            sliderActive: Colors.blue, // optional
            sliderInActive: Colors.grey, //optional
          ),
        ),
      ),
    );
  }

```

