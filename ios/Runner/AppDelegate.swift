import UIKit
import Flutter
//import workmanager

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
//        WorkmanagerPlugin.registerTask(withIdentifier: "create-newborn")
//        // Make other plugins available during a background fetch
//        WorkmanagerPlugin.setPluginRegistrantCallback { registry in
//            GeneratedPluginRegistrant.register(with: registry)
//        }
        UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*20))
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
