//
//  AppDelegate.swift
//  ProgressNavigationBar
//
//  Created by Naoki Hiroshima on 2/3/16.
//  Copyright © 2016 WTF. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        ProgressNavigationBar.appearance().progressTintColor = UIColor.redColor()
        NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        return true
    }
    
    var progress: Float = 0.0
    
    func onTimer() {
        guard let nc = window!.rootViewController as? UINavigationController else { return }
        if let nb = nc.navigationBar as? ProgressNavigationBar {
            progress += Float(arc4random_uniform(50)) / 1000
            if progress >= 1.5 { progress = -0.5 }
            
            nb.progress = progress
            
            if let vc = nc.viewControllers.first as? ViewController {
                vc.label.text = "\(Int(nb.progress * 100))"
            }
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
}
