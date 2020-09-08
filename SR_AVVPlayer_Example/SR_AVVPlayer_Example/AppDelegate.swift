//
//  AppDelegate.swift
//  SR_AVVPlayer_Example
//
//  Created by Andreas Becher on 08.08.19.
//  Copyright © 2019 Sportradar. All rights reserved.
//

import UIKit
import SRAVVPlayer


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()
    let viewContoller = ViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = viewContoller
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        
        viewContoller.view.backgroundColor = UIColor.white
        window!.backgroundColor = UIColor.white
        
        //setup Video Player Framework (license validation)
        let playerSetup = AVVPlayerSetup(domain: URL(string:"ott.onair.events"), licenseKey: "599089d5-40f6-4777-9ec5-8d6075f58beb", chromeCastAppId: "2D8999A3")
        AVVPlayer.setup(playerSetup) { (avvError) in
            print("AVVPlayerSetup -> error: \(avvError.debugDescription)")
            if avvError == nil
            {
                 self.viewContoller.setupVideoPlayer()
            }
        }
        return true
    }

}

