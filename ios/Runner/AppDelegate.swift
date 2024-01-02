import UIKit
import Flutter
import FirebaseCore
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyBAuFxcNsfHWmbEm2RgYgpNXoGLI8RTw9I?language=ar")
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *) {
       UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    // GeneratedPluginRegistrant.register(with: self)
     application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
