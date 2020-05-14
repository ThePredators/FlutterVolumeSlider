package fr.freekit.FlutterVolumeSlider

import android.content.Context
import android.content.Context.AUDIO_SERVICE
import androidx.annotation.NonNull;

import android.media.AudioManager

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.view.WindowManager;


public class FlutterVolumePlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var applicationContext : Context
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "freekit.fr/volume")
    channel.setMethodCallHandler(this);
    this.applicationContext = flutterPluginBinding.getApplicationContext();
  }

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "freekit.fr/volume")
      channel.setMethodCallHandler(FlutterVolumePlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "changeVolume") {
      val volumeValue: Double? = call.argument("volume");
      changeVolume(volumeValue!!.toInt())
      result.success(null)
    } else if (call.method == "getMaxVolume") {
      result.success(getMaxVolume())
    } else if (call.method == "getMinVolume") {
      result.success(getMinVolume())
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  fun getMaxVolume(): Int {
    val audioManager: AudioManager = applicationContext.getSystemService(AUDIO_SERVICE) as AudioManager
    return audioManager.mediaMaxVolume
  }

  fun getMinVolume(): Int {
    val audioManager: AudioManager = applicationContext.getSystemService(AUDIO_SERVICE) as AudioManager
    return audioManager.mediaMinVolume
  }

  fun changeVolume(volume: Int) {
    val audioManager: AudioManager = applicationContext.getSystemService(AUDIO_SERVICE) as AudioManager
    // Get the maximum media/music volume
    val maxVolume = audioManager.mediaMaxVolume

    if(volume <= maxVolume) {
      audioManager.setMediaVolume(volume)
    }
  }

  // Extension function to change media volume programmatically
  fun AudioManager.setMediaVolume(volumeIndex:Int) {
    // Set media volume level
    this.setStreamVolume(
            AudioManager.STREAM_MUSIC, // Stream type
            volumeIndex, // Volume index
            AudioManager.FLAG_SHOW_UI// Flags
    )
  }

  // Extension property to get media maximum volume index
  val AudioManager.mediaMaxVolume:Int
    get() = this.getStreamMaxVolume(AudioManager.STREAM_MUSIC)

  //Min Volume
  val AudioManager.mediaMinVolume:Int
    get() = this.getStreamMinVolume(AudioManager.STREAM_MUSIC)


  // Extension property to get media/music current volume index
  val AudioManager.mediaCurrentVolume:Int
    get() = this.getStreamVolume(AudioManager.STREAM_MUSIC)

}

