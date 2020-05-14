import Flutter
import UIKit
import MediaPlayer

public class SwiftFlutterVolumePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "freekit.fr/volume", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterVolumePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "changeVolume") {
        guard let arguments = call.arguments as? [String: Any] else {return}
        if let volumeValue = arguments["volume"] as? Double {
            self.changeVolume(volumeValue)
        }
        result(nil)
    } else if (call.method == "getMaxVolume") {
        result(self.getMaxVolume())
    } else if (call.method == "getMinVolume") {
        result(self.getMinVolume())
    } else {
        result(FlutterMethodNotImplemented)
    }
  }

  func getMinVolume() -> Int {
      return 0
  }
  
  func getMaxVolume() -> Int {
      return 1
  }
  
  func changeVolume(_ volume: Double){
      MPVolumeView.setVolume(volume)
  }
}

extension MPVolumeView {
    static func setVolume(_ volume: Double) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = Float(volume)
        }
    }
}
