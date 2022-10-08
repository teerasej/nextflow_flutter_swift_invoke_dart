import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let helloChannel = FlutterMethodChannel(name: "th.in.nextflow/hello", binaryMessenger: controller.binaryMessenger)
      
      helloChannel.setMethodCallHandler({
          (call:FlutterMethodCall, result: FlutterResult) -> Void in
          
          if( call.method.contains("sayHi")) {
              helloChannel.invokeMethod("swiftSayHi", arguments: "Hello from Swift")
          }
          
          result(false)
      })
    

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
