import UIKit
import Flutter
import WatchConnectivity

@available(iOS 9.3, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
     
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
     
    }
    
    func sendString(text: String){
        print(text)
        let session = WCSession.default;
        if(session.isPaired && session.isReachable){
         DispatchQueue.main.async {
                print("Sending counter...")
                session.sendMessage(["counter": text], replyHandler: nil)
            }
        }else{
            print("Watch not reachable...")
        }
    }

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    if(WCSession.isSupported()){
                  let session = WCSession.default;
                  session.delegate = self;
                  session.activate();
    }
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let channel = FlutterMethodChannel(name: "myWatchChannel",
              binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
       if(call.method == "sendStringToNative"){
       // We will call a method called "sendStringToNative" in flutter.
          self.sendString(text: call.arguments as! String)
          }
    })


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
